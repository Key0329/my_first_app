## 1. 基礎建設

- [x] 1.1 新增 ARB key（zh + en）：碼錶快捷/再來一次/匯出、密碼歷史/易記模式、QR 多類型模板。執行 `flutter gen-l10n`

## 2. 碼錶/計時器增強

- [x] 2.1 [P] 修改 `stopwatch_timer_page.dart` 實現 timer quick-set buttons（碼錶快捷時間按鈕 3/5/10/15/30min）、timer repeat button（碼錶「再來一次」按鈕）。同時強化 countdown timer 功能
- [x] 2.2 [P] 修改 `stopwatch_timer_page.dart` 實現 lap record export（分圈紀錄匯出）— 複製按鈕，格式化所有分圈為文字，強化 lap recording 功能

## 3. 密碼產生器增強

- [x] 3.1 [P] 修改 `password_generator_page.dart` 實現 memorable password mode（密碼易記模式）— 易記 toggle、word-based 生成、單詞數 slider，強化 password generation 功能
- [x] 3.2 [P] 修改 `password_generator_page.dart` 實現 password history storage（密碼歷史記錄）— 最近 20 組密碼持久化、masked 列表、清除按鈕

## 4. QR 產生器增強

- [x] 4.1 [P] 修改 `qr_generator_page.dart` 實現 QR code type templates（QR 產生器多類型模板）— SegmentedButton 切換文字/WiFi/Email，各類型輸入表單與編碼格式，強化 QR Code generation

## 5. 驗證

- [x] 5.1 [P] 執行 `flutter analyze` 確認零 warning/error
- [x] 5.2 [P] 執行 `flutter test` 確認所有測試通過
