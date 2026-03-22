## 1. ARB 檔案新增所有缺少的 key（ARB key 命名慣例）

- [x] 1.1 掃描所有頁面、工具頁面、共用 widgets 的硬編碼字串，統一新增到 `app_zh.arb` 和 `app_en.arb`，完善 multi-language support 確保所有 user-visible strings 有對應 key。執行 `flutter gen-l10n` 重新生成 AppLocalizations

## 2. 頁面層替換（分批替換策略 — 頁面層）

- [x] 2.1 [P] 替換 `lib/pages/home_page.dart` 中所有硬編碼中文為 AppLocalizations — app pages display localized strings
- [x] 2.2 [P] 替換 `lib/pages/settings_page.dart` 中所有硬編碼中文為 AppLocalizations — app pages display localized strings
- [x] 2.3 [P] 替換 `lib/pages/favorites_page.dart` 中所有硬編碼中文為 AppLocalizations — app pages display localized strings
- [x] 2.4 [P] 替換 `lib/pages/onboarding_page.dart` 中所有硬編碼中文為 AppLocalizations — app pages display localized strings

## 3. 工具頁面替換 — 計算類（分批替換策略 — 工具頁面）

- [x] 3.1 [P] 替換計算類工具頁面硬編碼中文（calculator、unit_converter、bmi_calculator、split_bill、date_calculator、currency_converter）為 AppLocalizations — tool pages display localized strings
- [x] 3.2 [P] 替換測量類工具頁面硬編碼中文（level、compass、protractor、screen_ruler、noise_meter）為 AppLocalizations — tool pages display localized strings
- [x] 3.3 [P] 替換生活類工具頁面硬編碼中文（flashlight、stopwatch_timer、password_generator、color_picker、qr_generator、qr_scanner_live、random_wheel）為 AppLocalizations — tool pages display localized strings

## 4. 共用 widgets 替換 與 ToolCategory label 處理

- [x] 4.1 替換共用 widgets（error_state、confirm_dialog、share_button 等）中硬編碼中文為 AppLocalizations — shared widgets display localized strings。同時處理 ToolCategory label 處理，在有 context 的地方使用 AppLocalizations

## 5. 驗證

- [x] 5.1 [P] 執行 `flutter analyze` 確認零 warning/error
- [x] 5.2 [P] 執行 `flutter test` 確認所有測試通過，確保 switching locale updates all text 不會造成 regression
