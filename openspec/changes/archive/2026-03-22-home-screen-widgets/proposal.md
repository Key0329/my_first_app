## Why

桌面 Widget 是目前 iOS/Android 平台最強的「被動曝光」管道 — 用戶每次滑到桌面都能看到 App 品牌，朋友看到也會問「這是什麼 App」形成免費曝光。CEO 和 PM 分析均指出 Widget 是提升 DAU 和留存率的核心功能（預估日活提升 20-30%）。Marketing 分析也確認 Widget 在 App Store 截圖中非常吸睛，能提升下載轉換率。

計算機和匯率換算是使用頻率最高的兩個工具，做成 Widget 後用戶連 App 都不用打開就能使用，大幅降低使用門檻。

## What Changes

- 新增 `home_widget` Flutter 套件依賴
- 新增**計算機 Widget**：iOS WidgetKit + Android AppWidget，顯示快捷計算機入口，點擊直接打開 App 的計算機工具
- 新增**匯率 Widget**：顯示最近一次查詢的匯率結果（幣別對 + 匯率值 + 更新時間），點擊打開匯率換算工具
- Flutter 端新增 `WidgetService`，負責 Widget 資料的寫入與更新
- 匯率換算工具在完成轉換後，自動更新 Widget 資料

## Capabilities

### New Capabilities

- `home-screen-widgets`: iOS WidgetKit 和 Android AppWidget 的計算機快捷入口與匯率顯示 Widget

### Modified Capabilities

（無）

## Impact

- 新增依賴：`home_widget` 套件
- 新增檔案：
  - `lib/services/widget_service.dart` — Widget 資料管理
  - `ios/CalculatorWidget/` — iOS WidgetKit extension（Swift）
  - `ios/CurrencyWidget/` — iOS WidgetKit extension（Swift）
  - `android/app/src/main/res/layout/` — Android Widget layout XML
  - `android/app/src/main/java/.../widget/` — Android AppWidget provider
  - `android/app/src/main/res/xml/` — Android Widget metadata XML
- 受影響程式碼：
  - `pubspec.yaml` — 新增 home_widget
  - `ios/Runner.xcodeproj` — 新增 Widget extension targets
  - `android/app/src/main/AndroidManifest.xml` — 註冊 Widget receivers
  - `lib/tools/currency_converter/currency_converter_page.dart` — 轉換完成後更新 Widget 資料
