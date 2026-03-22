## 1. i18n 字串

- [x] [P] 1.1 在 `app_zh.arb` 和 `app_en.arb` 新增 word counter 相關 i18n 字串（internationalization support）

## 2. 核心實作

- [x] [P] 2.1 建立 `lib/tools/word_counter/word_counter_page.dart`，實作文字計數邏輯（character count、word count with CJK support、line count、paragraph count、estimated reading time）與即時計算策略（real-time statistics update）
- [x] 2.2 實作 UI 佈局：multiline TextField + 統計結果 Grid 卡片（word counter tool page）
- [x] 2.3 實作 AppBar clear text action 與 copy statistics summary 功能

## 3. 工具註冊

- [x] 3.1 在 `tool_item.dart` 的 `allTools` 中新增 word_counter 工具項目（tool registry integration）

## 4. 測試

- [x] 4.1 撰寫文字計數邏輯的 unit test（character count、word count with CJK support、line count、paragraph count、estimated reading time）
- [x] 4.2 撰寫 widget test（word counter tool page、clear text action、copy statistics summary）
