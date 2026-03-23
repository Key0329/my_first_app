## Summary

提升首頁體驗和全 App 微互動品質，讓 App 從「能用」進化為「愉悅好用」。

## Motivation

目前首頁搜尋入口是 40x40 的小按鈕，可發現性低；Tab 切換時內容瞬間替換，缺乏過渡感；最近使用區塊在所有 tab 都顯示，佔據寶貴空間；工具卡片全部等大缺乏層次。微互動方面，Hero 動畫只是基本頁面過渡，收藏沒有回饋感，首頁載入沒有骨架屏，標題區不會隨滾動收起。這些細節直接影響用戶的第一印象和使用留存。

## Proposed Solution

**首頁體驗優化：**
- 搜尋按鈕改為 placeholder 搜尋欄（點擊展開 SearchDelegate）
- Tab 切換加 AnimatedSwitcher 過渡動畫
- 「最近使用」區塊僅在「全部」tab 顯示
- 首頁改為 CustomScrollView + SliverAppBar，標題區隨滾動縮小

**微互動增強：**
- Hero 動畫優化：工具卡片 icon → 工具頁面 header 的展開過渡
- 收藏按鈕加 confetti 粒子效果
- 首頁 Shimmer 骨架屏載入動畫
- 工具計算結果加「Hero Moment」強調動畫

## Impact

- Affected specs: `homepage-ux-polish`（新）、`micro-interactions`（新）、`bento-home`（修改）、`app-animations`（修改）
- Affected code:
  - `lib/pages/home_page.dart` — 大幅重構首頁佈局（SliverAppBar + 搜尋欄 + tab 動畫）
  - `lib/widgets/tool_card.dart` — Hero 動畫 + confetti 效果
  - `lib/widgets/immersive_tool_scaffold.dart` — Hero 動畫接收端
  - `lib/widgets/staggered_fade_in.dart` — 可能調整
  - 新增 `lib/widgets/shimmer_loading.dart` — Shimmer 骨架屏元件
  - 新增 `lib/widgets/confetti_effect.dart` — 粒子效果元件
  - 新增 `lib/widgets/hero_moment.dart` — 結果展示動畫
