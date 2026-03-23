## Context

首頁（`home_page.dart`）使用 `SliverGrid` 顯示工具卡片，順序來自 `allTools` 列表。`ThemeService` 管理 ThemeMode 和 Locale，`UserPreferencesService` 管理 recent tools 和 streak。品牌色目前硬編碼在 `DT.brandPrimary`（`#6C5CE7`）。

## Goals / Non-Goals

**Goals:**

- 首頁工具 Grid 支援長按拖曳排序
- 自訂排序持久化到 SharedPreferences
- 設定頁新增品牌色選項（6 種預設色）
- 品牌色持久化，App 重啟後生效
- 完整 i18n + 測試

**Non-Goals:**

- 不做自訂 App Icon（需 native 層，複雜度高）
- 不做完全自由的色彩選擇器（只提供預設色）
- 不做工具隱藏/顯示功能

## Decisions

### 拖曳排序實作

使用 Flutter 內建的 `ReorderableListView` 或在 `SliverGrid` 上使用長按拖曳（透過儲存工具 ID 排序列表）。

具體做法：在 `UserPreferencesService` 新增 `_toolOrder: List<String>`，存儲工具 ID 的排序。首頁根據此排序重新排列 `allTools`。若某些工具不在排序列表中（新增的），附加到尾部。

**理由**：只儲存 ID 列表，不複製 ToolItem，維護成本低。使用 `ReorderableGridView` 第三方套件太重，改用簡單的長按觸發排序 modal（底部彈出的可拖曳列表）。

### 品牌色主題

在 `ThemeService` 新增 `_accentColor: Color`，提供 6 種預設色：
- 紫色（預設）: `#6C5CE7`
- 藍色: `#3B82F6`
- 綠色: `#10B981`
- 紅色: `#EF4444`
- 橘色: `#F59E0B`
- 粉色: `#EC4899`

`app_theme.dart` 讀取 `ThemeService.accentColor` 生成 `ColorScheme`。設定頁以色彩圓點列表呈現。

**理由**：預設色方案比自由選色更安全（確保對比度和協調性），且實作成本低。

### 排序 UI 方式

在首頁標題區新增一個「排序」按鈕（Icons.sort），點擊後彈出底部 Sheet，顯示可拖曳的工具列表（`ReorderableListView`），拖曳完成後自動儲存。

**理由**：在 Grid 上直接拖曳的 UX 不佳（容易誤觸），底部 Sheet + ReorderableListView 的體驗更好。

## Risks / Trade-offs

- [排序遷移] 新增工具後舊的排序列表不包含新工具 → 設計中已考慮：不在列表中的工具附加到尾部
- [品牌色影響範圍] 改變品牌色可能影響工具卡片的漸層色 → 工具各自有獨立的 toolGradients，品牌色只影響全域元素（AppBar、Tab、按鈕等）
