## 1. 基礎建設

- [x] 1.1 [P] 新增 `image_picker` 依賴（`flutter pub add image_picker`）
- [x] 1.2 [P] 新增 ARB key（zh + en）：相簿取色、HSL 格式、歷史持久化相關標籤。執行 `flutter gen-l10n`

## 2. 功能實作

- [x] 2.1 修改 `color_picker_page.dart` 實現 HSL 格式顯示（HSL color format display）— 更新 color value display，`_ColorEntry` 新增 `hsl` getter，色值顯示區新增 HSL 行
- [x] 2.2 修改 `color_picker_page.dart` 實現 persistent color history（color history palette 持久化）— 歷史記錄持久化到 SharedPreferences，initState 載入、變更時保存
- [x] 2.3 修改 `color_picker_page.dart` 實現 pick color from gallery image — 使用 image_picker 從相簿選圖取色（從相簿選圖取色功能），header 新增相機/相簿切換，支援 color picking and display

## 3. 驗證

- [x] 3.1 [P] 執行 `flutter analyze` 確認零 warning/error
- [x] 3.2 [P] 執行 `flutter test` 確認所有測試通過
