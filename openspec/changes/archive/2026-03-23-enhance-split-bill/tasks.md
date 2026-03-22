## 1. 計算邏輯擴展

- [x] 1.1 [P] 新增 ARB key（zh + en）：小費相關、比例模式、多項目模式、mode switching 標籤。執行 `flutter gen-l10n`
- [x] 1.2 [P] 擴展 `split_bill_page.dart` 計算邏輯，新增 `calculateWithTip()`（小費百分比整合到等分模式）、`calculateByRatio()`（比例輸入）、`calculateMultiItem()`（多項目彙總）純函式

## 2. UI 增強

- [x] 2.1 修改 `split_bill_page.dart` 新增 mode switching — SegmentedButton 三模式切換（等分/比例/多項目），實現 tip percentage option（0/5/10/15/20% Chip 行），等分模式加入小費並更新 total amount and participant count input 的計算
- [x] 2.2 修改 `split_bill_page.dart` 實現 ratio-based split mode（不等分模式 — 比例輸入 UI），每人一個比例欄位，按比例分帳
- [x] 2.3 修改 `split_bill_page.dart` 實現 multi-item split mode（多項目拆分模式 UI），項目列表（品名+金額+人數），每項目獨立計算，彙總結果

## 3. 驗證

- [x] 3.1 [P] 執行 `flutter analyze` 確認零 warning/error
- [x] 3.2 [P] 執行 `flutter test` 確認所有測試通過
