## 1. i18n 字串

- [x] [P] 1.1 在 `app_zh.arb` 和 `app_en.arb` 新增 personalization 相關 i18n 字串（tool order i18n、theme color i18n）

## 2. 品牌色主題

- [x] [P] 2.1 在 `ThemeService` 新增品牌色主題選擇邏輯（accent color selection、accent color options、accent color persistence），定義 6 種預設色
- [x] 2.2 修改 `app_theme.dart` 讀取 `ThemeService.accentColor` 動態生成 ColorScheme
- [x] 2.3 在設定頁新增品牌色選擇 UI（accent color in settings page — 色彩圓點 + 勾選指示）

## 3. 工具排序

- [x] 3.1 在 `UserPreferencesService` 新增拖曳排序實作持久化邏輯（tool order customization、tool order persistence、new tools handling）
- [x] 3.2 在首頁新增排序 UI 方式：排序按鈕 + 底部 Sheet 拖曳列表（reorder UI）

## 4. 測試

- [x] [P] 4.1 撰寫品牌色主題的 unit test（accent color selection、accent color persistence、accent color options）
- [x] [P] 4.2 撰寫工具排序的 unit test（tool order customization、tool order persistence、new tools handling）
- [x] [P] 4.3 撰寫設定頁品牌色選擇的 widget test（accent color in settings page）
