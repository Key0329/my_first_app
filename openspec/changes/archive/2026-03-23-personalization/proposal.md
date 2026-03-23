## Why

工具箱目前首頁工具順序固定、主題色唯一，使用者無法根據自己的使用習慣和喜好客製化。提供工具排序和品牌色選擇，能提升個人化體驗和 App 黏性，讓使用者有「這是我的工具箱」的歸屬感。

## What Changes

- 首頁工具 Grid 支援拖曳排序，自訂排列順序
- 排序結果持久化到 SharedPreferences
- 設定頁新增「品牌色主題」選項，提供多種預設色彩主題
- 品牌色選擇持久化，全 App 響應色彩變化
- 完整 i18n

## Capabilities

### New Capabilities

- `personalization-tool-order`: 首頁工具拖曳排序功能，自訂工具排列與持久化
- `personalization-theme-color`: 品牌色主題選擇功能，自訂 App 主色調

### Modified Capabilities

（無）

## Impact

- 受影響程式碼：
  - `lib/pages/home_page.dart` — Grid 改為 ReorderableListView 或類似拖曳元件
  - `lib/services/user_preferences_service.dart` — 新增工具排序持久化
  - `lib/services/theme_service.dart` — 新增品牌色選擇
  - `lib/theme/design_tokens.dart` — 品牌色改為動態
  - `lib/pages/settings_page.dart` — 新增品牌色選擇 UI
  - `lib/l10n/app_zh.arb` / `app_en.arb` — 新增 i18n 字串
  - `test/` — 新增對應測試
