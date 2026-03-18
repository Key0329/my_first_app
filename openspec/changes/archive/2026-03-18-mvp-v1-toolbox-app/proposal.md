## Why

台灣市場缺少一款繁體中文、跨平台、無廣告轟炸的多合一工具箱 app。現有競品（Smart Tools）僅支援 Android、付費版仍有廣告、無繁中介面。我們要用 Flutter 打造一款活潑親切、包含 12 個精品工具 + 統一發票對獎的工具箱 app，同時上架 iOS 和 Android。

MVP v1 先以全功能免費上架驗證市場，v2 再加入 AdMob + 內購變現機制。

## What Changes

- 建立完整的 Flutter 專案架構（分層結構、GoRouter 路由、Material 3 主題）
- 實作底部三 Tab 導航（工具列表、收藏、設定）+ ShellRoute，工具頁面全螢幕 push
- 實作 12 個工具：計算機、單位換算器、QR Code 掃描器、手電筒、水平儀、指南針、碼錶/倒數計時、噪音計、密碼產生器、色彩擷取器、量角器、統一發票對獎
- 台灣在地化單位（坪、台斤、民國年）
- 收藏功能（長按工具卡片加入/移除）
- 暗黑模式（免費提供，支援亮/暗/跟隨系統）
- 多語系支援（繁中 + 英文）
- 狀態管理使用 `ChangeNotifier` + `ListenableBuilder`

## Capabilities

### New Capabilities

- `app-shell`: App 外殼框架 — GoRouter 路由、ShellRoute 底部導航、Material 3 主題（teal seed color）、暗黑模式切換
- `tool-calculator`: 計算機 — 四則運算、小數點、括號、歷史記錄
- `tool-unit-converter`: 單位換算器 — 長度/重量/面積/溫度 + 台灣單位（坪、台斤、民國年）
- `tool-qr-scanner`: QR Code 掃描器 — 掃描 + 產生 QR Code / Barcode
- `tool-flashlight`: 手電筒 — 開關、亮度調節、SOS 閃爍
- `tool-level`: 水平儀 — 水平/垂直偵測、角度顯示、震動回饋
- `tool-compass`: 指南針 — 方位角、磁北/真北切換
- `tool-stopwatch-timer`: 碼錶/倒數計時 — 碼錶 + 圈速記錄、倒數計時 + 鬧鈴
- `tool-noise-meter`: 噪音計 — 分貝偵測、即時圖表、參考值對照
- `tool-password-generator`: 密碼產生器 — 自訂長度/字元、一鍵複製、強度指示
- `tool-color-picker`: 色彩擷取器 — 相機即時取色、HEX/RGB 值、調色盤歷史
- `tool-protractor`: 量角器 — 觸控量角、角度顯示
- `tool-invoice-checker`: 統一發票對獎 — 掃描發票 QR Code、自動比對中獎號碼、顯示獎金
- `favorites`: 收藏功能 — 長按加入/移除收藏、收藏頁快速存取
- `settings`: 設定頁 — 主題切換、語言切換、關於、隱私政策
- `localization`: 多語系 — 繁中 + 英文，使用 Flutter 官方 i18n 方案

### Modified Capabilities

（無，全新專案）

## Impact

- **新增程式碼**：`lib/` 下建立完整分層結構（pages, tools, widgets, services, models, theme, utils）
- **套件依賴**：go_router, sensors_plus, mobile_scanner, torch_light, noise_meter, http, shared_preferences
- **平台權限**：相機（QR 掃描、色彩擷取）、麥克風（噪音計）、網路（發票 API）
- **平台設定**：Android `AndroidManifest.xml` 權限宣告、iOS `Info.plist` 權限描述
