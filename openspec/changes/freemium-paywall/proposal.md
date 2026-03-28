## Why

App 目前功能完整但缺乏商業模式，無法覆蓋維運成本或產生收益。透過 Freemium 模式，免費版以底部 banner 廣告維持營運，Pro 版提供一次性買斷（NT$90）以去廣告、解鎖自訂主題與 Widget，降低付費門檻並提升轉換率。

## What Changes

- 新增 `isPro` 狀態至 `AppSettings`，全 App 共用
- 免費版在所有工具頁底部顯示 banner 廣告（AdMob），不遮擋主要操作區域
- 設定頁新增「Pro 升級」入口，展示付費牆畫面
- Pro 一次性買斷 NT$90，完成後永久移除廣告
- StoreKit2（iOS）+ Google Play Billing（Android）整合，處理購買、回復購買
- 自訂主題色與 Home Screen Widget 功能改為 Pro 專屬，免費版顯示升級提示

## Capabilities

### New Capabilities

- `pro-entitlement`: 管理 isPro 狀態，持久化至 SharedPreferences，提供 ProService 供全 App 查詢
- `paywall-screen`: Pro 升級畫面，展示功能對比、定價（NT$90）、購買按鈕、回復購買
- `in-app-purchase`: StoreKit2 / Google Play Billing 整合，處理 purchase flow、receipt 驗證（本地）、restore
- `banner-ads`: AdMob banner 廣告整合，免費版在工具頁底部顯示，Pro 版隱藏

### Modified Capabilities

- `settings`: 新增「升級至 Pro」入口卡片及 Pro 徽章顯示（已購買時）
- `personalization-theme-color`: 自訂品牌色改為 Pro 專屬，免費版鎖定 Indigo 預設主題並顯示升級提示
- `home-screen-widgets`: Widget 功能標示 Pro 專屬，免費版在設定中顯示升級 CTA

## Impact

- 新增套件：`google_mobile_ads`、`in_app_purchase`（或 `purchases_flutter` RevenueCat）
- 受影響檔案：
  - `lib/services/app_settings.dart`（新增 isPro）
  - `lib/services/pro_service.dart`（新增）
  - `lib/screens/paywall_screen.dart`（新增）
  - `lib/widgets/banner_ad_widget.dart`（新增）
  - `lib/screens/settings_page.dart`（新增 Pro 入口）
  - `lib/screens/tools/tool_page_scaffold.dart` 或 `immersive_tool_scaffold.dart`（嵌入 banner）
  - `lib/screens/personalization_page.dart`（鎖定主題色）
  - `pubspec.yaml`（新增依賴）
  - `android/app/build.gradle`、`ios/Runner/Info.plist`（AdMob App ID）
