## Context

目前專案是全新的 Flutter 模板（計數器範例），需要從零建構一個多合一工具箱 app。目標平台為 iOS + Android，使用 Flutter 3.41.x（Stable）。

專案定位為台灣市場的繁體中文工具箱 app，競品分析顯示 Smart Tools 有需求但痛點明顯（廣告轟炸、無繁中、僅 Android）。MVP v1 全功能免費上架驗證市場，不含廣告與內購。

## Goals / Non-Goals

**Goals:**

- 建立可維護的分層專案架構，方便後續擴展工具
- 12 個工具全部可用，品質穩定
- 暗黑模式 + 繁中/英文多語系
- 收藏功能讓常用工具快速存取
- 活潑親切的視覺風格（Material 3, teal seed color）

**Non-Goals:**

- 不做廣告整合（AdMob）— 留給 v2
- 不做內購機制（Pro 買斷）— 留給 v2
- 不做免費/Pro 工具鎖定 — v1 全功能開放
- 不做 Widget 桌面小工具
- 不做 Apple Watch 版本
- 不做貨幣即時匯率（離線換算即可）

## Decisions

### 狀態管理：ChangeNotifier + ListenableBuilder

使用 Flutter 內建的 `ChangeNotifier` 搭配 `ListenableBuilder`，不引入 Riverpod/Bloc 等第三方套件。

**替代方案**：Riverpod — 功能更強但學習成本高，工具型 app 的狀態需求簡單（主題、語言、收藏列表、Pro 狀態），`ChangeNotifier` 完全足夠。

**實作方式**：建立 `AppSettings` ChangeNotifier，包含 themeMode、locale、favorites，透過 `ListenableBuilder` 在需要的 widget 中監聽。

### 導航架構：GoRouter + ShellRoute

使用 `go_router` 的 `ShellRoute` 實現底部三 Tab 導航（工具列表、收藏、設定）。點入工具頁面時 push 全螢幕路由，底部導航消失。

**替代方案**：Navigator 2.0 原生 — 太底層，boilerplate 多。Bottom Nav 保持常駐 — 工具頁面（水平儀、指南針、量角器）需要全螢幕空間，底部導航是干擾。

### 主題系統：Material 3 + ColorScheme.fromSeed

seed color 使用 `Colors.teal`，風格為活潑親切。暗黑模式免費提供，支援三種模式（亮色、暗色、跟隨系統）。工具卡片使用大圓角（borderRadius: 16）、每個工具有專屬彩色圓形 icon 背景。

### 檔案拆分原則

邏輯超過 50 行才拆出獨立檔案。僅計算機（運算式解析）、單位換算器（單位定義資料）、統一發票（QR 解析 + API）需要拆分，其餘工具單檔完成。

### 開發順序：先純軟體後硬體

- Phase 1（框架 + 純軟體）：專案結構 → 計算機 → 單位換算 → 密碼產生 → 碼錶
- Phase 2（相機/掃描）：QR 掃描 → 色彩擷取 → 統一發票
- Phase 3（感測器）：手電筒 → 水平儀 → 指南針 → 噪音計
- Phase 4（特殊 UI + 打磨）：量角器 → 暗黑模式微調 → 多語系 → 測試 → 上架

好處：前期不需實機，開發迭代快；相機類集中處理可複用權限邏輯；感測器類統一用實機測試。

### 本地儲存：shared_preferences

收藏列表和設定（主題、語言）使用 `shared_preferences`。資料量小、結構簡單，不需要 SQLite。

### 統一發票 API：財政部電子發票整合服務平台

QR Code 前 10 碼解析發票號碼（2 碼英文 + 8 碼數字），透過財政部 API 取得最新中獎號碼比對。如 API 無法使用，降級為手動輸入號碼比對。

## Risks / Trade-offs

- **[感測器精度不一致]** → 加入校準功能說明，多機型測試後調整敏感度閾值
- **[財政部 API 申請延遲]** → 先實作離線版（手動輸入發票號碼比對），API 後補
- **[16 個 capability spec 數量多]** → 工具型 app 各工具獨立，spec 雖多但各自簡單，不會交互影響
- **[v1 免費全開放可能影響 v2 轉換]** → 早期用戶量少，主要目的是驗證產品方向和收集回饋
