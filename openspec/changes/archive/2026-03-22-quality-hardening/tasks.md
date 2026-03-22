## 1. Design Token 補全

- [x] [P] 1.1 新增 Motion Token constants in Design Tokens：在 `DT` 類中加入 `durationFast`、`durationMedium`、`durationSlow` 常數（Design Token 補全）
- [x] [P] 1.2 新增 Opacity Token constants in Design Tokens：在 `DT` 類中加入 `opacityDisabled`、`opacityOverlay`、`opacityHover` 常數（Design Token 補全）
- [x] 1.3 更新 `test/theme/design_tokens_test.dart` 加入 Motion Token 與 Opacity Token 的單元測試

## 2. 補測試策略 — 抽出純邏輯並撰寫測試

- [x] [P] 2.1 Pure logic unit tests for compass tool：抽出 degreeToDirection 函數至 `compass_logic.dart`，撰寫 `test/tools/compass_logic_test.dart`（補測試策略）
- [x] [P] 2.2 Pure logic unit tests for color picker tool：抽出 RGB/HSL/Hex 互轉函數至 `color_picker_logic.dart`，撰寫 `test/tools/color_picker_logic_test.dart`（補測試策略）
- [x] [P] 2.3 Pure logic unit tests for flashlight tool：抽出 SOS 頻率計算函數至 `flashlight_logic.dart`，撰寫 `test/tools/flashlight_logic_test.dart`（補測試策略）
- [x] [P] 2.4 Pure logic unit tests for level tool：抽出加速度轉角度與水平判定函數至 `level_logic.dart`，撰寫 `test/tools/level_logic_test.dart`（補測試策略）
- [x] [P] 2.5 Pure logic unit tests for noise meter tool：抽出 dB 轉顏色映射與分類函數至 `noise_meter_logic.dart`，撰寫 `test/tools/noise_meter_logic_test.dart`（補測試策略）
- [x] [P] 2.6 Pure logic unit tests for protractor tool：抽出角度計算與正規化函數至 `protractor_logic.dart`，撰寫 `test/tools/protractor_logic_test.dart`（補測試策略）
- [x] [P] 2.7 Pure logic unit tests for screen ruler tool：抽出 PPI 計算與像素轉換函數至 `screen_ruler_logic.dart`，撰寫 `test/tools/screen_ruler_logic_test.dart`（補測試策略）

## 3. 無障礙 Semantics 策略

- [x] [P] 3.1 實作 Calculator button semantics：為計算機每個按鈕加入 Semantics widget（無障礙 Semantics 策略）
- [x] [P] 3.2 實作 Noise meter value semantics：為噪音計 dB 數值加入 Semantics widget 與 liveRegion（無障礙 Semantics 策略）
- [x] [P] 3.3 實作 Compass bearing semantics：為指南針方位顯示加入 Semantics widget（無障礙 Semantics 策略）
- [x] [P] 3.4 實作 Protractor angle semantics：為量角器角度顯示加入 Semantics widget（無障礙 Semantics 策略）

## 4. 確認對話框統一模式

- [x] 4.1 建立共用 ConfirmDialog widget，使用 showAdaptiveDialog 與 AlertDialog.adaptive（確認對話框統一模式），實作 Confirmation dialog for destructive actions 規格
- [x] [P] 4.2 將 ConfirmDialog 套用於計算機清除歷史操作（確認對話框統一模式）
- [x] [P] 4.3 將 ConfirmDialog 套用於碼錶重設操作（確認對話框統一模式）
- [x] [P] 4.4 將 ConfirmDialog 套用於隨機轉盤刪除選項操作（確認對話框統一模式）

## 5. 錯誤狀態統一

- [x] 5.1 建立標準錯誤狀態元件，實作 Unified error state display 規格：使用 colorScheme.error 色彩與 Icons.error_outline 圖示（錯誤狀態統一）
- [x] [P] 5.2 將錯誤狀態元件套用於噪音計感測器初始化失敗場景（錯誤狀態統一）
- [x] [P] 5.3 將錯誤狀態元件套用於指南針感測器初始化失敗場景（錯誤狀態統一）
- [x] [P] 5.4 將錯誤狀態元件套用於水平儀感測器初始化失敗場景（錯誤狀態統一）

## 6. NumberPicker controller 生命週期修復

- [x] 6.1 修復 random_wheel_page.dart 中的 NumberPicker controller lifecycle fix：確保 controller 在 initState 建立、dispose 中釋放（NumberPicker controller 生命週期修復）
