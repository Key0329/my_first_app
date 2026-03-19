## Context

工具箱 Pro 目前有 12 個工具，採用模組化架構：每個工具獨立目錄，透過 `ToolItem` 註冊、`GoRouter` 路由、`ImmersiveToolScaffold` 統一頁面骨架。本次需移除「發票對獎」並新增 4 個工具（BMI 計算機、AA 制分帳、隨機決定器、螢幕尺規），維持相同架構模式。

現有 UI 採用 Material 3 + teal seed color，工具頁面使用沉浸式雙區佈局（漸層 header + 圓角 body），支援 Hero 過渡動畫與 Light/Dark 主題。

## Goals / Non-Goals

**Goals:**

- 新增 4 個實用工具，每個工具遵循現有架構模式
- 移除發票對獎及其專屬依賴（`http`、`mobile_scanner`），減少 app 體積
- 所有新工具支援繁中 + 英文 i18n
- 所有新工具適配 Light/Dark 主題
- 不新增任何外部 package

**Non-Goals:**

- 不重構現有工具或架構
- 不調整 Bento Grid 佈局邏輯
- 不新增後端 API 或網路功能

## Decisions

### BMI 計算機 UI 設計

採用 `ImmersiveToolScaffold`，品牌色 `Color(0xFFE91E63)`（桃紅色，健康/生命力意象）。

**Header 區**：圓形儀表盤顯示 BMI 數值，以顏色環帶表示分級區間（過輕藍、正常綠、過重橙、肥胖紅），指針指向當前數值位置。

**Body 區**：
- 身高輸入：Slider（140–220 cm）+ 數字顯示，即時拖動即時計算
- 體重輸入：Slider（30–200 kg）+ 數字顯示
- 結果卡片：BMI 分類標籤（過輕 / 正常 / 過重 / 肥胖）+ 建議體重範圍

**計算公式**：`BMI = 體重(kg) / 身高(m)²`

**分級標準**（WHO）：
- < 18.5：過輕
- 18.5–24.9：正常
- 25.0–29.9：過重
- ≥ 30.0：肥胖

業務邏輯分離至 `bmi_logic.dart`，頁面 UI 在 `bmi_calculator_page.dart`。

### AA 制分帳計算機 UI 設計

採用 `ImmersiveToolScaffold`，品牌色 `Color(0xFF26A69A)`（青綠色，金錢/分享意象）。

**Header 區**：大字顯示總金額與人數摘要（例：「$1,500 ÷ 3 人」）。

**Body 區**：
- 總金額輸入：TextField + 數字鍵盤
- 人數控制：圓形加減按鈕（最少 2 人，最多 30 人）
- 結果區：每人應付金額，顯示尾數處理方式
- 尾數處理：若除不盡，第一人多付餘數（例：100 ÷ 3 = 34 + 33 + 33）

MVP 僅做均分，不做自訂比例分配。單檔 `split_bill_page.dart` 即可。

### 隨機決定器（轉盤）UI 設計

採用 `ImmersiveToolScaffold`，品牌色 `Color(0xFFFF7043)`（珊瑚橘，趣味/遊戲意象）。

**Header 區**：轉盤主體，以 `CustomPainter` 繪製彩色扇形分區，每個選項佔據等角區域。頂部固定三角形指針。轉盤支援觸控旋轉手勢。

**Body 區**：
- 選項清單：`ListView` 顯示已輸入的選項，向左滑動刪除
- 新增選項：底部 TextField + 新增按鈕
- 旋轉按鈕：中央 FAB「開始旋轉」
- 結果彈窗：旋轉停止後 Dialog 顯示選中結果

**動畫實作**：
- `AnimationController` 控制旋轉角度
- `CurvedAnimation` 搭配 `Curves.decelerate` 實現自然減速
- 旋轉持續時間 2–4 秒（隨機），最終停止角度對應選中項目
- 預設選項：「選項 1」、「選項 2」（至少需要 2 個選項才能旋轉）

檔案結構：`random_wheel_page.dart`（UI + 動畫）+ `wheel_painter.dart`（CustomPainter）。

### 螢幕尺規 UI 設計

採用 `ImmersiveToolScaffold`，品牌色 `Color(0xFF5C6BC0)`（靛藍色，精確/工具意象）。

**首次使用——校準流程**：
- 全屏畫面，中央顯示信用卡輪廓（標準 85.6mm × 53.98mm）
- 使用者將實體信用卡放在螢幕上，拖動 Slider 調整輪廓大小直到吻合
- 按下「完成校準」後，根據已知尺寸反算螢幕 PPI
- PPI 值存入 `SharedPreferences`，之後不再需要校準（可在設定中重新校準）

**校準後——尺規模式**：
- Header 區：顯示當前 PPI 值 + 「重新校準」按鈕
- Body 區：`CustomPainter` 繪製雙刻度尺（上方公分、下方英寸）
  - 公分刻度：每 mm 短線、每 5mm 中線、每 cm 長線 + 數字
  - 英寸刻度：每 1/16 吋短線、每 1/4 吋中線、每吋長線 + 數字
- 尺規沿螢幕左邊緣垂直繪製，可上下滑動延伸量測範圍

檔案結構：`screen_ruler_page.dart`（UI + 校準邏輯）+ `ruler_painter.dart`（CustomPainter）。

### 移除發票對獎策略

1. 從 `allTools` 列表移除 `invoice_checker` 項目
2. 從 `app.dart` 移除路由與 import
3. 刪除 `lib/tools/invoice_checker/` 目錄（3 個檔案）
4. 刪除 `test/tools/invoice_checker_test.dart`
5. 從 i18n ARB 檔案移除 `tool_invoice_checker` 相關字串
6. 檢查 `pubspec.yaml`：確認 `http` 和 `mobile_scanner` 無其他使用者後移除
7. 移除 `android/app/src/main/AndroidManifest.xml` 中 mobile_scanner 的相機權限（若無其他工具需要）

### 工具圖示與色彩方案

| 工具 | 圖示 | 色彩 | 色彩意象 |
|------|------|------|----------|
| BMI 計算機 | `Icons.monitor_heart` | `#E91E63` 桃紅 | 健康、生命力 |
| AA 制分帳 | `Icons.groups` | `#26A69A` 青綠 | 金錢、共享 |
| 隨機決定器 | `Icons.casino` | `#FF7043` 珊瑚橘 | 趣味、運氣 |
| 螢幕尺規 | `Icons.straighten` | `#5C6BC0` 靛藍 | 精確、測量 |

注意：螢幕尺規的 icon 與水平儀相同（`Icons.straighten`），需改用 `Icons.design_services` 或 `Icons.square_foot` 以避免混淆。最終選用 `Icons.square_foot`（直角尺意象）。

## Risks / Trade-offs

- **[螢幕尺規精度]** → 信用卡校準仰賴使用者操作精確度；透過放大手勢與微調 Slider 降低誤差。校準後的 PPI 值持久化，避免重複操作。
- **[轉盤動畫效能]** → `CustomPainter` 繪製多扇區 + 旋轉動畫在低階裝置可能造成 jank；限制選項上限（20 個）並使用 `RepaintBoundary` 隔離重繪。
- **[相機權限殘留]** → 移除 mobile_scanner 後需確認 AndroidManifest.xml 和 Info.plist 中的相機權限已清理，否則上架審核可能被質疑。
- **[收藏列表相容性]** → 已收藏 invoice_checker 的使用者升級後，收藏列表中會出現無效 ID；`SettingsService` 載入時應過濾不存在的工具 ID（現有邏輯已在 `toggleFavorite` 中用 `allTools` 比對）。
