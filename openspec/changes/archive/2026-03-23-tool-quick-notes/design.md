## Context

工具箱已有 20 個工具，透過 tool-registry 自動註冊。快速筆記是純本地 CRUD 工具，不需要網路 API 或額外套件。使用 SharedPreferences + JSON 序列化即可完成持久化。

## Goals / Non-Goals

**Goals:**

- 提供快速建立、編輯、刪除筆記的功能
- 筆記清單支援搜尋過濾
- 每則筆記自動記錄建立與更新時間
- 使用 SharedPreferences 持久化（JSON 序列化）
- 刪除前需確認（防止誤刪）
- 完整 i18n + widget test

**Non-Goals:**

- 不做 Markdown 格式支援
- 不做筆記分類/標籤
- 不做雲端同步
- 不做富文本編輯器
- 不做圖片/附件插入

## Decisions

### 資料模型

使用簡單的 `Note` class：
- `id`: UUID 字串（使用 `DateTime.now().millisecondsSinceEpoch.toString()` 產生）
- `title`: 可選標題
- `content`: 筆記內容
- `createdAt`: 建立時間
- `updatedAt`: 更新時間

**理由**：不引入 uuid 套件，用時間戳即可滿足唯一性。

### 持久化策略

使用 SharedPreferences 存儲 JSON 陣列字串（key: `quick_notes_list`）。每次增刪改後完整覆寫。

**理由**：筆記數量預期在百則以內，完整覆寫的效能開銷可忽略。避免引入 SQLite 等重量級方案。

### UI 架構

兩頁式設計：
1. **列表頁**（QuickNotesPage）：顯示所有筆記卡片 + 搜尋欄 + FAB 新增按鈕
2. **編輯頁**（NoteEditPage）：標題 + 內容 TextField，push 進入，pop 返回時自動儲存

**理由**：兩頁式比 dialog 形式更適合手機端文字輸入，也符合 Flutter 的導航慣例。

### 搜尋實作

在列表頁使用 TextField 做即時過濾，比對標題和內容（case-insensitive）。

## Risks / Trade-offs

- [SharedPreferences 效能] 筆記過多（100+）時完整覆寫可能稍慢 → 短期可接受，未來可遷移至 SQLite
- [資料遺失] SharedPreferences 無 transaction 保證 → 對工具箱定位的筆記而言風險可接受
