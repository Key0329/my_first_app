## 1. 移除發票對獎

- [x] 1.1 執行移除發票對獎策略：刪除 `lib/tools/invoice_checker/` 目錄（invoice_checker_page.dart、invoice_api.dart、invoice_parser.dart）及 `test/tools/invoice_checker_test.dart`
- [x] 1.2 從 `lib/models/tool_item.dart` 的 allTools 移除 invoice_checker 項目，從 `lib/app.dart` 移除 invoice checker route 及 import，更新 tool list displayed as grid 工具總數為 15
- [x] 1.3 從 i18n ARB 檔案移除 invoice checker localization strings（`tool_invoice_checker` 相關鍵值）
- [x] 1.4 從 `pubspec.yaml` 移除 `http` 和 `mobile_scanner` 依賴（確認無其他使用者），執行 `flutter pub get`
- [x] 1.5 清理 `android/app/src/main/AndroidManifest.xml` 和 `ios/Runner/Info.plist` 中 mobile_scanner 相關的相機權限設定

## 2. BMI 計算機

- [x] [P] 2.1 建立 `lib/tools/bmi_calculator/bmi_logic.dart`，實作 BMI calculation from height and weight 邏輯及 BMI category classification display 分級判定（BMI 計算機 UI 設計）
- [x] [P] 2.2 建立 `lib/tools/bmi_calculator/bmi_calculator_page.dart`，實作 ImmersiveToolScaffold integration，header 區圓形儀表盤、body 區雙 Slider 輸入與 healthy weight range suggestion 結果卡片
- [x] 2.3 在 `lib/models/tool_item.dart` 新增 bmi_calculator ToolItem，在 `lib/app.dart` 新增 routes for new tools（/tools/bmi-calculator）

## 3. AA 制分帳計算機

- [x] [P] 3.1 建立 `lib/tools/split_bill/split_bill_page.dart`，實作 total amount and participant count input、equal split calculation with remainder handling、summary display in header，使用 ImmersiveToolScaffold integration（AA 制分帳計算機 UI 設計）
- [x] 3.2 在 `lib/models/tool_item.dart` 新增 split_bill ToolItem，在 `lib/app.dart` 新增 routes for new tools（/tools/split-bill）

## 4. 隨機決定器（轉盤）

- [x] [P] 4.1 建立 `lib/tools/random_wheel/wheel_painter.dart`，實作 spinning wheel with custom options 的 CustomPainter 繪製彩色扇形分區（隨機決定器（轉盤）UI 設計）
- [x] [P] 4.2 建立 `lib/tools/random_wheel/random_wheel_page.dart`，實作 spin animation with deceleration（AnimationController + CurvedAnimation）、option list management（新增/刪除選項）、結果 Dialog，使用 ImmersiveToolScaffold integration
- [x] 4.3 在 `lib/models/tool_item.dart` 新增 random_wheel ToolItem，在 `lib/app.dart` 新增 routes for new tools（/tools/random-wheel）

## 5. 螢幕尺規

- [x] [P] 5.1 建立 `lib/tools/screen_ruler/ruler_painter.dart`，實作 dual-scale ruler display 的 CustomPainter（公分 + 英寸雙刻度）（螢幕尺規 UI 設計）
- [x] [P] 5.2 建立 `lib/tools/screen_ruler/screen_ruler_page.dart`，實作 credit card PPI calibration 校準流程、recalibration option、尺規顯示模式，使用 ImmersiveToolScaffold integration
- [x] 5.3 在 `lib/models/tool_item.dart` 新增 screen_ruler ToolItem（工具圖示與色彩方案：`Icons.square_foot`、`#5C6BC0`），在 `lib/app.dart` 新增 routes for new tools（/tools/screen-ruler）

## 6. 國際化與註冊

- [x] 6.1 在 `lib/l10n/app_zh.arb` 和 `lib/l10n/app_en.arb` 新增 localization strings for new tools（tool_bmi_calculator、tool_split_bill、tool_random_wheel、tool_screen_ruler）及各工具頁面 UI 元素文字
- [x] 6.2 執行 `flutter gen-l10n` 重新產生 localization 檔案，執行 `flutter analyze` 確認無錯誤

## 7. 驗證

- [x] 7.1 執行 `flutter test` 確認既有測試通過（移除 invoice_checker 後無殘留引用）
- [x] 7.2 執行 `flutter run` 驗證所有 15 個工具可正常開啟、收藏功能正常、搜尋功能正常
