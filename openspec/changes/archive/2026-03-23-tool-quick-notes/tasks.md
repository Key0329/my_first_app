## 1. i18n 字串

- [x] [P] 1.1 在 `app_zh.arb` 和 `app_en.arb` 新增 quick notes 相關 i18n 字串（internationalization support）

## 2. 資料模型與持久化

- [x] [P] 2.1 建立 `lib/tools/quick_notes/note_model.dart`，實作 note data model（id、title、content、createdAt、updatedAt）與 JSON 序列化
- [x] 2.2 實作 local persistence 邏輯（持久化策略：SharedPreferences + JSON 陣列覆寫）

## 3. UI 實作

- [x] 3.1 建立 `lib/tools/quick_notes/quick_notes_page.dart`，實作 UI 架構：quick notes list page（筆記卡片清單 + FAB + 空狀態）
- [x] 3.2 實作搜尋實作：search notes 功能（即時過濾搜尋欄）
- [x] 3.3 建立 `lib/tools/quick_notes/note_edit_page.dart`，實作 create note 與 edit note 功能（標題 + 內容 TextField，auto-save on back）
- [x] 3.4 實作 delete note 功能（滑動刪除 + 確認對話框）

## 4. 工具註冊

- [x] 4.1 在 `tool_item.dart` 的 `allTools` 中新增 quick_notes 工具項目（tool registry integration），新增 design_tokens.dart gradient

## 5. 測試

- [x] [P] 5.1 撰寫 Note model 與持久化邏輯的 unit test（note data model、local persistence）
- [x] [P] 5.2 撰寫 widget test（quick notes list page、create note、edit note、delete note、search notes）
