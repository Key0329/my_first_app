## Summary

將工具分類從單一 enum 升級為多標籤 tag 系統，並加入 iPad/Tablet 響應式佈局。

## Motivation

目前每個工具只有一個 `ToolCategory`（calculate/measure/life），但許多工具跨分類（如「匯率換算」既是計算也是生活；「噪音計」既是測量也是生活）。單分類讓用戶在非主分類 tab 下找不到相關工具。此外，App 在 iPad 和平板上使用手機佈局（2 欄），浪費大量螢幕空間，影響平板用戶體驗。

## Proposed Solution

**分類系統升級：**
- `ToolItem` 的 `category` 改為 `tags`（`Set<ToolTag>`），每個工具可有 1-3 個 tag
- 定義 `ToolTag` enum：calculate、measure、life、productivity、utility
- 首頁 tab 篩選改為「工具包含該 tag 就顯示」
- 向下相容：保留 `category` getter 回傳主要 tag

**iPad / Tablet 適配：**
- 首頁使用 `LayoutBuilder` 根據寬度動態調整欄數：< 600dp → 2 欄、600-900dp → 3 欄、> 900dp → 4 欄
- 工具頁面 body 區域在寬螢幕加 `maxWidth` 限制（600dp），置中顯示
- 導航列在 > 900dp 時切換為 NavigationRail（左側直式）

## Impact

- Affected specs: `multi-tag-classification`（新）、`responsive-layout`（新）、`homepage-grid`（修改）
- Affected code:
  - `lib/models/tool_item.dart` — ToolTag enum + tags 欄位 + allTools 更新
  - `lib/pages/home_page.dart` — tag 篩選邏輯 + 響應式 Grid 欄數
  - `lib/widgets/immersive_tool_scaffold.dart` — maxWidth 限制
  - `lib/app.dart` — NavigationRail 判斷
  - `lib/l10n/app_zh.arb` + `app_en.arb` — 新 tag 標籤名稱
