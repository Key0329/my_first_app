## 1. 依賴與基礎設施

- [x] [P] 1.1 新增 `home_widget` 套件至 `pubspec.yaml` — 使用 home_widget 套件而非純原生實作，提供 Flutter ↔ 原生 Widget 資料橋接
- [x] [P] 1.2 建立 `lib/services/widget_service.dart` — Widget data bridge via home_widget 的 `WidgetService` 類別，封裝 `HomeWidget.saveWidgetData()` 與 `HomeWidget.updateWidget()` 操作

## 2. Calculator quick-launch widget（計算機 Widget 為靜態快捷入口）

- [x] [P] 2.1 實作 Calculator quick-launch widget 的 iOS 版（SwiftUI WidgetKit）— iOS 使用 SwiftUI WidgetKit，兩個 Widget 合成一個 Extension `SpectraWidgets`，包含 `CalculatorWidget` 顯示品牌漸層 + icon + 標題，點擊打開 `/tools/calculator`
- [x] [P] 2.2 建立 Android 計算機 Widget — Android 使用 XML layout + Kotlin AppWidgetProvider，新增 `CalculatorWidgetProvider.kt`、layout XML、metadata XML，點擊透過 Deep Link 打開計算機

## 3. Currency rate display widget（匯率 Widget 顯示上次查詢結果）

- [x] 3.1 實作 Currency rate display widget 的 iOS 版（SwiftUI WidgetKit）— 在 `SpectraWidgets` Extension 加入 `CurrencyWidget`，讀取 App Group 共享資料顯示幣別對 + 匯率 + 更新時間，無資料時顯示 placeholder
- [x] 3.2 建立 Android AppWidget 匯率 Widget — 新增 `CurrencyWidgetProvider.kt`、layout XML、metadata XML，讀取 SharedPreferences 顯示匯率資料
- [x] 3.3 在 `currency_converter_page.dart` 完成轉換後呼叫 `WidgetService` 更新匯率 Widget 資料

## 4. 平台配置

- [x] [P] 4.1 iOS App Group 配置 — 在 `Runner.entitlements` 與 Widget Extension 的 entitlements 中加入 `group.com.spectra.toolbox`，配置 `home_widget` 的 `appGroupId`
- [x] [P] 4.2 Android AndroidManifest.xml 配置 — 註冊兩個 Widget 的 `<receiver>` 與 `<meta-data>`

## 5. 驗證

- [x] 5.1 執行 `flutter analyze` 確認零 warning/error
- [x] 5.2 執行 `flutter test` 確認所有測試通過
- [x] 5.3 在 iOS 模擬器上新增計算機 Widget 並驗證點擊行為
- [x] 5.4 在 Android 模擬器上新增匯率 Widget 並驗證資料顯示
