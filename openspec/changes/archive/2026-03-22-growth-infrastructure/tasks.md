## 1. Firebase 初始化與 AnalyticsService

- [x] [P] 1.1 新增 `firebase_core`、`firebase_analytics`、`firebase_crashlytics` 至 `pubspec.yaml`，實作 Decision: AnalyticsService 抽象層設計：建立 `lib/services/analytics_service.dart`，實作 AnalyticsService singleton initialization，提供統一事件記錄介面
- [x] [P] 1.2 修改 `lib/main.dart`，在 `main()` 中初始化 Firebase Core/Analytics/Crashlytics，實作 Crashlytics error reporting：設定 `FlutterError.onError` 和 `PlatformDispatcher.instance.onError` 轉發至 Crashlytics

## 2. Analytics 事件追蹤

- [x] [P] 2.1 實作 Tool open event tracking：在工具頁面開啟時記錄 `tool_open` 事件（含 `tool_id` 和 `source` 參數）
- [x] [P] 2.2 實作 Tool complete event tracking：在 BMI calculator、split bill、random wheel、QR generator 完成操作時記錄 `tool_complete` 事件
- [x] 2.3 實作 Analytics route observer for page tracking：建立 `AnalyticsRouteObserver extends NavigatorObserver`，在 `lib/app.dart` 註冊至 GoRouter，自動記錄 `screen_view` 事件
- [x] 2.4 實作 Tab switch event tracking：在底部導航 tab 切換時記錄 `tab_switch` 事件（含 `tab_name` 參數）

## 3. 分享功能

- [x] 3.1 新增 `share_plus` 至 `pubspec.yaml`，實作 Decision: 分享文本模板設計：建立 `lib/widgets/share_button.dart`，實作 ShareButton widget in tool actions，放入 ImmersiveToolScaffold actions 區域
- [x] 3.2 實作 Share button disabled state before result：ShareButton 在工具尚未產生結果前為 disabled 狀態，產生結果後才啟用
- [x] [P] 3.3 實作 Split bill share text template：在 `split_bill_page.dart` 加入 ShareButton，分享文本包含總金額、每人金額、人數與 deep link URL
- [x] [P] 3.4 實作 Random wheel share text template：在 `random_wheel_page.dart` 加入 ShareButton，分享文本包含選中結果與 deep link URL
- [x] [P] 3.5 實作 BMI calculator share text template：在 `bmi_calculator_page.dart` 加入 ShareButton，分享文本包含 BMI 值、分類、身高、體重與 deep link URL
- [x] [P] 3.6 實作 QR generator share image and text：在 `qr_generator_page.dart` 加入 ShareButton，分享 QR Code 圖片與 deep link URL 文字
- [x] 3.7 實作 Tool share event tracking：在每個工具的分享按鈕觸發時記錄 `tool_share` 事件

## 4. Deep Link 配置

- [x] 4.1 實作 Decision: Deep Link 路由配置：配置 GoRouter deep link 支援，實作 Deep link routing configuration，URL 格式 `https://spectra.app/tools/{tool-id}` 對應現有路由
- [x] [P] 4.2 配置 iOS Universal Links：在 `Runner.entitlements` 加入 Associated Domains `applinks:spectra.app`
- [x] [P] 4.3 配置 Android App Links：在 `AndroidManifest.xml` 加入 intent-filter 處理 `https://spectra.app/tools/*`

## 5. ASO 準備

- [x] [P] 5.1 實作 Decision: ASO 基礎準備與 bundle ID 修正：修正 bundle ID 為 `com.spectra.toolbox`（Android `build.gradle` + iOS Xcode project），實作 App display name for ASO
- [x] [P] 5.2 實作 Marketing subtitle on home page：修改首頁副標題為「15+ 實用工具，一個 App 搞定」

## 6. 驗證

- [x] 6.1 執行 `flutter analyze` 確認無靜態分析錯誤
- [x] 6.2 執行 `flutter test` 確認既有測試通過
