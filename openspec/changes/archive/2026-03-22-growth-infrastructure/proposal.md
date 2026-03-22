## Why

目前「工具箱」App 零數據追蹤、零分享機制、零病毒傳播能力，AARRR 漏斗全斷。沒有 Analytics 就無法知道用戶最常用哪些工具、在哪裡流失；沒有分享功能就無法產生有機增長；沒有 Deep Link 就無法做任何 referral 或行銷導流；bundle ID 仍是 `my_first_app`，上架 App Store / Google Play 前必須修正。本次 change 建立 App 增長所需的全部基礎設施。

## What Changes

- 整合 Firebase Analytics + Crashlytics：建立 `AnalyticsService`，在每個工具開啟/完成/分享時記錄事件（`tool_open`、`tool_complete`、`tool_share`）
- 使用 `share_plus` 套件在分帳、隨機轉盤、BMI、QR Code 4 個工具加入分享按鈕，支援工具結果分享
- 配置 GoRouter deep link + iOS Universal Links + Android App Links，支援 `https://spectra.app/tools/{tool-id}` 格式
- ASO 準備：修正 bundle ID 為 `com.spectra.toolbox`、修正 App 名稱為「Spectra 工具箱」、更新首頁描述文案

## Capabilities

### New Capabilities

- `analytics-tracking`: Firebase Analytics 事件追蹤系統，包含 AnalyticsService 抽象層、自動記錄工具開啟/完成/分享事件、Crashlytics 錯誤回報
- `social-sharing`: 工具結果分享功能，4 個工具（分帳/轉盤/BMI/QR Code）的分享按鈕與分享文本模板

### Modified Capabilities

- `bento-home`: 首頁 ASO 相關調整 — App 名稱改為「Spectra 工具箱」、副標題更新為行銷導向文案

## Impact

- 受影響的程式碼：
  - `lib/services/analytics_service.dart` — 新增 AnalyticsService
  - `lib/main.dart` — Firebase 初始化
  - `lib/app.dart` — Deep link 路由配置、NavigatorObserver 註冊
  - `lib/tools/split_bill/split_bill_page.dart` — 加入分享按鈕
  - `lib/tools/random_wheel/random_wheel_page.dart` — 加入分享按鈕
  - `lib/tools/bmi_calculator/bmi_calculator_page.dart` — 加入分享按鈕
  - `lib/tools/qr_generator/qr_generator_page.dart` — 加入分享按鈕
  - `lib/widgets/share_button.dart` — 新增共用分享按鈕 widget
  - `lib/pages/home_page.dart` — 標題文案更新
  - `lib/widgets/app_scaffold.dart` — App 名稱更新
  - `pubspec.yaml` — 新增 firebase_core、firebase_analytics、firebase_crashlytics、share_plus 套件
  - `android/app/build.gradle` — bundle ID 修正
  - `ios/Runner.xcodeproj` — bundle ID 修正
  - `android/app/src/main/AndroidManifest.xml` — Deep link intent filter
  - `ios/Runner/Info.plist` — Universal Links 配置
  - `ios/Runner/Runner.entitlements` — Associated Domains
