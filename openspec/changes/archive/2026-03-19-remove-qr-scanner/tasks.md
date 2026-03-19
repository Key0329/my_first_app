## 1. 將檔案搬移至 qr_generator 目錄

- [x] 1.1 建立 `lib/tools/qr_generator/qr_generator_page.dart`，從 `qr_scanner_page.dart` 提取 `_GeneratorTab` 內容，移除 TabBar 改為單頁佈局，class 重新命名為 `QrGeneratorPage`（移除 QR Code and Barcode scanning 相關程式碼）
- [x] 1.2 刪除 `lib/tools/qr_scanner/` 目錄（移除 Camera permission handling 相關程式碼）

## 2. 更新路由與工具清單

- [x] [P] 2.1 更新 `lib/app.dart` 路由：import 改為 `qr_generator_page.dart`，路徑改為 `/tools/qr-generator`，widget 改為 `QrGeneratorPage`
- [x] [P] 2.2 更新 `lib/models/tool_item.dart` 工具定義：id、nameKey、icon、routePath 更新為 qr_generator 相關值

## 3. 更新 i18n 字串

- [x] [P] 3.1 更新 `lib/l10n/app_en.arb`：將 `toolQrScanner` 改為 `toolQrGenerator`，值改為 "QR Generator"（QR Code generation 重新命名）
- [x] [P] 3.2 更新 `lib/l10n/app_zh.arb`：將 `toolQrScanner` 改為 `toolQrGenerator`，值改為 "QR Code 產生器"

## 4. 移除 mobile_scanner 依賴

- [x] 4.1 從 `pubspec.yaml` 移除 `mobile_scanner` 依賴並執行 `flutter pub get`（移除 mobile_scanner 依賴）
- [x] [P] 4.2 檢查並移除 `android/app/src/main/AndroidManifest.xml` 中的相機權限宣告
- [x] [P] 4.3 檢查並移除 `ios/Runner/Info.plist` 中的相機使用說明（NSCameraUsageDescription）

## 5. 測試驗證

- [x] 5.1 更新 `test/tools/qr_generator_test.dart` — import 改為新路徑，確保測試通過
- [x] [P] 5.2 執行 `flutter analyze` 確保無靜態分析警告
- [x] [P] 5.3 執行 `flutter test` 確保全部測試通過
