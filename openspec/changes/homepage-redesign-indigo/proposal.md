## Why

目前首頁使用 Bento Grid 混搭排版搭配 teal 品牌色，視覺上偏碎且缺乏統一品牌感。根據新的概念設計，需要將首頁全面重設計為靛紫品牌色 (#6C5CE7)、均勻 2 欄 Grid、分類 Tab 篩選、深靛藍 Dark mode 配色，建立更精緻且有辨識度的視覺風格。此次範圍僅限首頁，工具內頁之後逐一調整。

## What Changes

- **BREAKING** 品牌色從 teal 換為靛紫 `#6C5CE7`，`ColorScheme.fromSeed(seedColor: Color(0xFF6C5CE7))`
- **BREAKING** 拆除 Bento Grid 佈局，改為均勻 2 欄 GridView
- 卡片風格全面重做：白底（light）/ 深藍底 `#16213E`（dark），中央放彩色圓角方塊 icon（白色線條圖標），下方工具名稱
- 搜尋列移除，改為頂部分類 Tab（全部 / 計算 / 測量 / 生活）
- Dark mode 背景改為深靛藍 `#1A1A2E`（非純黑），卡片用 `#16213E`
- 標題從「工具箱 Pro」改為「工具箱」+ 副標題「N 個工具，隨手可用」
- ToolItem model 新增 `category` 欄位（計算 / 測量 / 生活），用於分類 Tab 篩選
- 底部導航視覺同步新配色
- 移除 BentoSize enum 及相關 Bento Grid 元件（首頁不再使用）

## Capabilities

### New Capabilities

- `homepage-grid`: 首頁均勻 2 欄 Grid 佈局、分類 Tab 篩選系統、新卡片風格（彩色圓角方塊 icon）
- `indigo-theme`: 靛紫品牌色主題系統，包含 light/dark mode 專屬配色（深靛藍背景、深藍卡片）

### Modified Capabilities

- `app-shell`: 品牌色從 teal 改為靛紫、AppBar 標題改為「工具箱」+ 副標題、Dark mode surface 配色
- `bento-home`: **移除** — Bento Grid 首頁佈局由 homepage-grid 取代
- `app-animations`: 交錯淡入動畫保留但適配新 Grid 佈局，移除 Bento 相關動畫邏輯

## Impact

- 受影響的程式碼：
  - `lib/theme/app_theme.dart` — seed color 及 dark mode 配色全面修改
  - `lib/models/tool_item.dart` — 新增 category 欄位、移除 BentoSize enum
  - `lib/widgets/tool_card.dart` — 全面重做卡片風格
  - `lib/pages/home_page.dart` — 拆除 BentoGrid、改用 GridView + 分類 Tab
  - `lib/pages/favorites_page.dart` — 同步新卡片風格
  - `lib/widgets/app_scaffold.dart` — 標題、副標題、配色同步
  - `lib/widgets/bento_grid.dart` — 可能移除或保留備用
  - `lib/widgets/staggered_fade_in.dart` — 適配新 Grid
  - `lib/app.dart` — seed color 更新
