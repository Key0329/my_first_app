## Why

目前「工具箱 Pro」的 UI 採用純 Material 3 預設樣式，首頁為 2 欄等大 grid，所有工具內頁共用相同的白底 AppBar 模式，視覺上單調且缺乏品牌辨識度。為了讓 app 更活潑、更有記憶點、吸引更多用戶，需要全面重新設計首頁與所有 12 個工具內頁的視覺風格。

## What Changes

- 首頁改為 Bento Grid 混搭排版，卡片大小交替，常用/收藏工具佔更大面積
- 卡片背景改用工具專屬色彩漸層，取代目前的白底小圖示
- 部分卡片加入迷你預覽（如計算機顯示上次計算結果、指南針顯示方位）
- 所有 12 個工具內頁改為沉浸式色彩主題：上半部工具色漸層背景 + 下半部圓角操作區
- AppBar 改為透明，融入工具色背景
- 新增動畫系統：首頁卡片交錯淡入、Hero 展開/收合轉場、互動微動效（按鈕 bounce、數字滾動）
- 建立共用的沉浸式工具頁面基底元件，統一風格但透過色彩區分個性

## Capabilities

### New Capabilities

- `bento-home`: 首頁 Bento Grid 混搭排版系統，包含大小交替卡片、動態佈局、迷你預覽
- `immersive-tool-theme`: 工具內頁沉浸式色彩主題系統，包含漸層背景、透明 AppBar、圓角操作區分層佈局
- `app-animations`: 全域動畫系統，包含首頁交錯淡入、Hero 轉場、互動微動效

### Modified Capabilities

- `app-shell`: 主題系統需支援動態工具色彩、透明 AppBar 樣式
- `favorites`: 收藏工具在 Bento Grid 中佔更大卡片面積

## Impact

- 受影響的 specs：`app-shell`、`favorites`、以及所有 12 個 `tool-*` specs 的 UI 呈現
- 受影響的程式碼：
  - `lib/theme/app_theme.dart` — 主題擴充
  - `lib/widgets/tool_card.dart` — 重新設計為 Bento 卡片
  - `lib/pages/home_page.dart` — Bento Grid 佈局
  - `lib/pages/favorites_page.dart` — 同步 Bento 風格
  - `lib/widgets/app_scaffold.dart` — 支援透明 AppBar
  - `lib/models/tool_item.dart` — 可能新增卡片尺寸屬性
  - 所有 12 個 `lib/tools/*/` 內頁 — 套用沉浸式主題
- 無新增外部依賴（純 Flutter 動畫與佈局）
