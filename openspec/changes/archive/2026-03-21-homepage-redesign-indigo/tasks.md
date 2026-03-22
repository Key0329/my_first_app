## 1. 主題系統 — 靛紫品牌色 + Dark mode 配色

- [x] [P] 1.1 修改 `AppTheme`，實作 Decision: 品牌色使用 ColorScheme.fromSeed 搭配靛紫 seed：將 seed color 從 teal 改為 `Color(0xFF6C5CE7)`（indigo brand color seed），更新 app entry point and root widget
- [x] [P] 1.2 實作 Decision: Dark mode 使用自訂 surface 配色覆蓋 M3 預設：dark mode 背景 `#1A1A2E`、卡片 `#16213E`（dark mode deep indigo surface colors），light mode uses standard Material 3 surfaces

## 2. Model 擴充 — ToolCategory 分類

- [x] 2.1 在 `ToolItem` model 新增 `ToolCategory` enum 與 `category` 欄位（ToolItem category field），實作 Decision: 分類 Tab 使用 enum ToolCategory + FilterChip 列：為所有 15 個工具指定分類，移除 `BentoSize` enum

## 3. 首頁卡片重做

- [x] 3.1 重寫 `ToolCard` widget，實作 Decision: 卡片風格使用圓角方塊 icon 容器（tool card with colored rounded-square icon）：白底/深藍底 + 彩色圓角方塊白 icon + 工具名稱，保留 Hero tag

## 4. 首頁佈局重建

- [x] 4.1 重寫 `HomePage`，實作 Decision: 拆除 BentoGrid 改用標準 GridView（uniform two-column grid layout）：使用 `GridView.builder` 均勻 2 欄，對應 tool list displayed as grid
- [x] 4.2 實作首頁分類 Tab（category tab filtering）：在標題下方加入 FilterChip 列，支援全部/計算/測量/生活篩選
- [x] 4.3 實作 Decision: AppBar 改為品牌標題 + 副標 + 搜尋按鈕（title area with app name and subtitle）：「工具箱」大字 + 「N 個工具，隨手可用」副標
- [x] 4.4 適配 staggered fade-in animation on home page：確保交錯淡入動畫在新 GridView 佈局正常運作，animation does not replay on tab switch

## 5. AppScaffold + 收藏頁同步

- [x] [P] 5.1 更新 `AppScaffold`（bottom navigation with three tabs）：標題改為「工具箱」，底部導航配色同步靛紫 color scheme
- [x] [P] 5.2 更新 `FavoritesPage`：同步新卡片風格（ToolCard 重寫後自動生效），確認 GridView 佈局

## 6. 清理 Bento Grid 遺留

- [x] 6.1 移除 Bento Grid layout with variable card sizes、tool cards with gradient backgrounds、search bar filters Bento Grid、mini preview on large cards：清理 `lib/widgets/bento_grid.dart` 及相關 BentoSize 引用

## 7. 驗證

- [x] 7.1 驗證 light/dark mode 全頁面一致性，確認 app uses indigo color scheme 和 dark mode uses deep indigo background
- [x] 7.2 執行 `flutter analyze` 確認無靜態分析錯誤
- [x] 7.3 執行 `flutter test` 確認既有測試通過
