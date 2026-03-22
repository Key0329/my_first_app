## Context

計算機工具目前使用 `List<CalculationEntry> _history` 作為 in-memory 歷史。`CalculationEntry` 有 `expression`、`result`、`timestamp` 三個欄位。歷史紀錄在頁面底部以 `ListView` 展示，有清除按鈕。

## Goals / Non-Goals

**Goals:**

- 歷史紀錄在 App 重啟後仍然保留
- 上限 100 筆，超過時移除最舊的
- 支援搜尋歷史（模糊匹配 expression 或 result）

**Non-Goals:**

- 不做雲端同步（留給 Phase 6 Pro+）
- 不做歷史紀錄的匯出功能
- 不改變現有的歷史 UI 佈局

## Decisions

### 獨立 CalculatorHistoryService 封裝持久化邏輯

建立 `CalculatorHistoryService`，在 `calculator_logic.dart` 同目錄下，負責 `SharedPreferences` 的讀寫。`calculator_page.dart` 在 `initState` 時載入歷史、計算後儲存。

**替代方案**：直接在 page state 中操作 SharedPreferences → 混合 UI 和持久化邏輯，不利測試。

### 使用 JSON 字串列表儲存歷史

將 `List<CalculationEntry>` 序列化為 `List<String>`（每項是 JSON 字串），存入 `SharedPreferences.setStringList()`。

**替代方案**：SQLite → 100 筆上限用 SharedPreferences 已足夠，不需引入新依賴。

### 搜尋使用本地篩選而非索引

搜尋功能在 100 筆上限內直接用 `where()` 篩選，不建立額外索引。

## Risks / Trade-offs

- **[風險] SharedPreferences 有大小限制** → 100 筆 CalculationEntry（每筆約 100 bytes JSON）≈ 10KB，遠低於限制
- **[取捨] 搜尋只做 contains 模糊匹配** → 對 100 筆資料足夠，不需全文搜尋引擎
