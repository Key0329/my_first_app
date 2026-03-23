## Context

目前的 `DT` (design_tokens.dart) 已涵蓋間距、圓角、品牌色、光暗色彩、元件尺寸、動畫 duration 和 opacity。但字體只有零散的大小常數（fontTitle、fontToolLabel 等），不成體系；陰影完全沒有 token；色彩沒有語義層（success/error/warning）；動畫缺乏 Curve token；Accessibility 僅在計算機、噪音計、指南針、量角器四個工具有 Semantics 標註，其餘 16+ 個工具頁面皆未覆蓋。

## Goals / Non-Goals

**Goals:**

- 建立完整 Typography Scale 並替換所有散落的 fontSize 硬編碼
- 新增 Shadow/Elevation token 層級，套用到卡片和工具元件
- 加入 Semantic Color token（success/error/warning/info），給亮/暗模式各一組
- 新增 Animation Curve token
- 統一 Iconography 尺寸為五級標準
- 全工具頁面補齊 Semantics 標註（label、hint、liveRegion）
- Slider 類元件加入 semanticFormatterCallback
- 驗證所有文字/背景色彩對比度 ≥ 4.5:1

**Non-Goals:**

- 不重寫 ColorScheme.fromSeed 機制（保留 Material 3 seed color）
- 不改動 toolGradients 的實際色值（視覺不變）
- 不引入外部設計 token 工具（如 style-dictionary）
- 不做跨平台 token 同步（Web/iOS/Android 統一 token 檔案）

## Decisions

### Typography Scale 架構

在 `DT` 中新增完整的 Typography Scale，對齊 Material 3 層級但使用自訂值：

| Token | Size | Weight | 用途 |
|-------|------|--------|------|
| `displayLarge` | 32 | w700 | 工具計算結果大數字 |
| `displayMedium` | 28 | w700 | 頁面主標題 |
| `headlineLarge` | 24 | w600 | 區塊標題 |
| `headlineMedium` | 20 | w600 | 子區塊標題 |
| `titleLarge` | 18 | w600 | 卡片標題、導航標題 |
| `titleMedium` | 16 | w500 | 工具名稱、按鈕文字 |
| `bodyLarge` | 16 | w400 | 內文 |
| `bodyMedium` | 14 | w400 | 表單標籤、說明文字 |
| `bodySmall` | 12 | w400 | 輔助說明、時間戳 |
| `labelLarge` | 14 | w500 | 按鈕標籤 |
| `labelMedium` | 12 | w500 | Badge、Tag |
| `labelSmall` | 10 | w500 | Pro badge、微小標籤 |

提供 `TextStyle` getter 方法接受 Brightness 參數，自動套用對應色彩。同時在 `AppTheme` 中設定 `textTheme` 讓 Material 元件自動採用。

### Shadow / Elevation Token

新增四級 shadow token，以 `BoxShadow` 形式提供：

| Token | blur | offset | opacity | 用途 |
|-------|------|--------|---------|------|
| `shadowNone` | 0 | 0,0 | 0 | 平面元件 |
| `shadowSm` | 4 | 0,1 | 0.08 | 卡片 hover 狀態 |
| `shadowMd` | 8 | 0,2 | 0.12 | 浮起卡片（ToolSectionCard） |
| `shadowLg` | 16 | 0,4 | 0.16 | Modal、BottomSheet |

暗色模式下 shadow 不可見，改用邊框強調層次（維持現有 darkCardBorder 策略）。

### Semantic Color Token

在 `DT` 中新增語義色彩，亮/暗模式各一組：

| Semantic | Light | Dark | 用途 |
|----------|-------|------|------|
| `success` | #10B981 | #34D399 | 正確結果、完成狀態 |
| `error` | #EF4444 | #F87171 | 錯誤訊息、刪除 |
| `warning` | #F59E0B | #FBBF24 | 警告、過期提示 |
| `info` | #3B82F6 | #60A5FA | 資訊提示、連結 |

提供 `DT.success(b)` / `DT.error(b)` 等 helper method，與現有 `DT.title(b)` 模式一致。

### Animation Curve Token

新增 Curve token 到 `DT`：

| Token | Curve | 用途 |
|-------|-------|------|
| `curveStandard` | `Curves.easeInOut` | 一般過渡 |
| `curveDecelerate` | `Curves.easeOut` | 進場動畫 |
| `curveAccelerate` | `Curves.easeIn` | 離場動畫 |
| `curveSpring` | `Curves.elasticOut` | 彈性效果（收藏、按鈕） |

### Iconography 尺寸標準化

將現有散落的 icon size 整合為五級：

| Token | Size | 用途 |
|-------|------|------|
| `iconXs` | 16 | 內嵌小圖示 |
| `iconSm` | 20 | 列表/搜尋圖示 |
| `iconMd` | 24 | 標準圖示（現有 iconSize） |
| `iconLg` | 32 | 工具頁面強調圖示 |
| `iconXl` | 48 | 首頁工具卡片圖示容器 |

### Accessibility 策略

分三個層級逐步補齊：

1. **結果數值 liveRegion** — BMI 結果、匯率結果、分帳結果、計時器等數值顯示加 `Semantics(liveRegion: true, value: ...)`
2. **互動元件 label/hint** — 所有 IconButton、GestureDetector、自訂按鈕加 `Semantics(label:, hint:)`
3. **Slider semanticFormatterCallback** — 番茄鐘 duration slider、BMI 身高/體重 slider 加格式化回調

## Risks / Trade-offs

- **[大量檔案修改]** → Typography 替換涉及幾乎所有頁面的 fontSize 硬編碼。採取漸進策略：先定義 token，再逐頁替換，確保每步都能編譯通過。
- **[Shadow 在暗色模式不可見]** → 維持現有暗色邊框策略，不強行加 shadow。亮色模式享受 shadow 層次感。
- **[Accessibility 標註增加 widget tree 深度]** → Semantics widget 幾乎沒有效能影響（Flutter framework 層級支援），可以放心加入。
- **[Typography 替換可能影響現有佈局]** → 新舊 size 相近（差距 ≤ 2dp），不太可能破壞版面。但仍需逐頁目視檢查。
