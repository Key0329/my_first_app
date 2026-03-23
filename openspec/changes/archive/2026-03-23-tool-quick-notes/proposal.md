## Why

工具箱目前缺少文字記錄類工具。快速筆記是手機端高頻需求，使用者常需即時記下想法、待辦事項或臨時資訊。不需要完整的筆記 App，只要輕量、快速的建立/編輯/刪除功能，搭配本地持久化即可。與番茄鐘搭配可形成「專注 + 記錄」的使用情境。

## What Changes

- 新增「快速筆記」工具頁面，提供筆記的建立、編輯、刪除功能
- 筆記清單以卡片形式顯示，支援搜尋過濾
- 每則筆記包含標題（可選）和內容，自動記錄建立/更新時間
- 使用 SharedPreferences 本地持久化（JSON 序列化）
- 在 tool registry 中註冊，歸類為「生活」
- 完整 i18n 支援（繁體中文 + 英文）

## Capabilities

### New Capabilities

- `tool-quick-notes`: 快速筆記工具，提供筆記的 CRUD 操作、搜尋過濾、本地持久化

### Modified Capabilities

（無）

## Impact

- 受影響程式碼：
  - `lib/tools/quick_notes/quick_notes_page.dart` — 筆記列表頁（新檔案）
  - `lib/tools/quick_notes/note_edit_page.dart` — 筆記編輯頁（新檔案）
  - `lib/tools/quick_notes/note_model.dart` — 筆記資料模型（新檔案）
  - `lib/models/tool_item.dart` — 新增 quick_notes 工具註冊
  - `lib/theme/design_tokens.dart` — 新增 quick_notes 漸層色
  - `lib/l10n/app_zh.arb` / `app_en.arb` — 新增 i18n 字串
  - `test/tools/quick_notes_test.dart` — 新增測試（新檔案）
