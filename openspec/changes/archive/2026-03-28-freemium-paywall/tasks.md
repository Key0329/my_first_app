## 1. 基礎設施

- [x] 1.1 [P] 在 `pubspec.yaml` 新增 `in_app_purchase` 與 `google_mobile_ads` 套件依賴，執行 `flutter pub get`（使用 `in_app_purchase` 官方套件而非 RevenueCat）
- [x] 1.2 [P] 建立 `lib/config/ad_config.dart`，定義 `AdConfig` 常數類別（debug 使用 Google 測試 Ad Unit ID，release 使用正式 ID）；設定 AdMob App ID 至 `android/app/src/main/AndroidManifest.xml` 和 `ios/Runner/Info.plist`（AdMob banner 初始化）
- [x] 1.3 建立 `lib/services/pro_service.dart`，實作 `ProService extends ChangeNotifier`，含 SharedPreferences key `is_pro`、`isPro` getter、`setPro(bool)` 方法及 `init()` — 對應 Pro status persistence、Pro status activation、Pro-gated feature check 需求；Pro 狀態儲存於 SharedPreferences，不依賴網路

## 2. 核心功能實作

- [x] 2.1 建立 `lib/services/in_app_purchase_service.dart`，實作 `InAppPurchaseService`：訂閱 `purchaseStream`、`buyPro()`（product ID `com.spectra.toolbox.pro`）、`restorePurchases()`；purchase/restore 成功時呼叫 `ProService.setPro(true)`，error 時 emit error event — 對應 In-app purchase initialization、Purchase flow、Restore purchases 需求（使用 `in_app_purchase` 官方套件而非 RevenueCat；付費牆定價固定 NT$90 一次性）
- [x] 2.2 [P] 建立 `lib/widgets/banner_ad_widget.dart`，實作 `BannerAdWidget`：依 `ProService.isPro` 動態顯示/隱藏 `AdSize.banner`，ad 載入失敗時 collapse 至零高度，`dispose()` 時釋放 `BannerAd` instance；嵌入 `ImmersiveToolScaffold` 底部 slot — 對應 Banner ad widget in tool pages、Banner ad lifecycle management 需求（AdMob banner 嵌入 ImmersiveToolScaffold 底部）
- [x] 2.3 [P] 建立 `lib/screens/paywall_screen.dart`，實作 `PaywallScreen`：品牌漸層 header、三項 Pro 功能對比列表、NT$90 定價標籤、「立即升級」按鈕（含 loading 狀態）、「回復購買」文字連結、購買/回復成功後 dismiss — 對應 Paywall screen layout、Paywall CTA triggers purchase、Restore purchase 需求（付費牆定價固定 NT$90 一次性）

## 3. UI 整合

- [x] 3.1 更新 `lib/pages/settings_page.dart`，於頂部新增「Pro」section ToolSectionCard：free 狀態顯示升級 CTA，Pro 狀態顯示「已是 Pro 用戶 ✓」；點擊 CTA 開啟 `PaywallScreen` — 對應 Pro upgrade card in settings 需求（Pro 狀態儲存於 SharedPreferences，不依賴網路）
- [x] 3.2 [P] 更新主題色選擇區塊（`lib/pages/settings_page.dart` 或 `personalization_page.dart`），free 用戶鎖定非預設色 swatch（顯示 lock icon overlay）並點擊開啟 `PaywallScreen` — 對應 Accent color selection 需求（主題色與 Widget 採「軟鎖定」策略）
- [x] 3.3 [P] 更新 Widget 設定入口，free 用戶顯示 Pro badge 並點擊開啟 `PaywallScreen`，Pro 用戶正常進入設定流程 — 對應 Widget Pro gating in settings 需求（主題色與 Widget 採「軟鎖定」策略）

## 4. 初始化串接

- [x] 4.1 在 `lib/main.dart` 的 `main()` 中加入 `await MobileAds.instance.initialize()` 於 `runApp()` 前（AdMob banner initialization）
- [x] 4.2 在 `lib/app.dart` 的 `MultiProvider` 中加入 `ChangeNotifierProvider<ProService>`，確保全 App Widget tree 可透過 `context.watch<ProService>()` 存取 Pro 狀態（Pro-gated feature check）

## 5. 測試

- [x] 5.1 [P] 撰寫 `test/services/pro_service_test.dart`：驗證 `init()` 讀取持久化狀態、`setPro(true/false)` 正確寫入並通知 listeners、預設值為 `false`
- [x] 5.2 [P] 撰寫 `test/services/in_app_purchase_service_test.dart`：mock `InAppPurchase.instance`，驗證 purchased 狀態觸發 `ProService.setPro(true)`、error 狀態不觸發、restore 流程
- [x] 5.3 [P] 撰寫 `test/screens/paywall_screen_test.dart`：驗證 free 用戶升級 CTA 可見、Pro 用戶不顯示升級 CTA、「回復購買」按鈕觸發 restore flow
- [x] 5.4 [P] 撰寫 `test/widgets/banner_ad_widget_test.dart`：驗證 Pro 用戶 banner 為 `SizedBox.shrink()`（零高度）、free 用戶 banner 可見
