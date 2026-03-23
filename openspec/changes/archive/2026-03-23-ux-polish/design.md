## Context

首頁目前使用 `ListView` + `GridView.count(crossAxisCount: 2)` 佈局，搜尋是 40x40 圓形 GestureDetector，Tab 是 `Row` of `GestureDetector` chips，最近使用區塊在所有 tab 顯示。Hero 動畫僅包裝 tool icon，未延伸到整個 header。收藏按鈕有 ScaleTransition 但無粒子效果。

## Goals / Non-Goals

**Goals:**

- 首頁搜尋欄從 icon button 升級為 placeholder 搜尋欄
- Tab 切換有平滑過渡動畫
- 最近使用只在「全部」tab 出現
- 標題區隨滾動收起（SliverAppBar 風格）
- Hero 動畫從 tool card icon 展開到 tool page header
- 收藏加 confetti 粒子回饋
- 首頁載入有 Shimmer 骨架屏
- 工具結果有 Hero Moment 強調動畫

**Non-Goals:**

- 不改動工具頁面內部邏輯
- 不改動 ToolItem model 結構
- 不引入第三方動畫套件（如 lottie、rive），純 Flutter 實現
- 不做「常用工具置頂大卡片 + 3 欄小格」混合佈局（保持統一 2 欄，避免過度複雜）

## Decisions

### SliverAppBar 滾動縮小架構

將首頁 `ListView` 改為 `CustomScrollView`，使用 `SliverAppBar` 包裝標題區（App 名稱 + 搜尋欄）。設定 `floating: true, snap: true` 讓標題在向上滾動時收起、向下滑動時快速彈出。搜尋欄放在 `SliverAppBar.bottom` 中。Tab 欄和工具格子放在 `SliverList` / `SliverGrid` 中。

### Placeholder 搜尋欄

用一個 `GestureDetector` 包裝的 `Container` 模擬搜尋欄外觀（圓角、搜尋 icon + hint text），點擊觸發 `showSearch(delegate: ToolSearchDelegate)`。不是真的 `TextField`，避免鍵盤自動彈出的 UX 問題。

### Tab 過渡動畫

用 `AnimatedSwitcher` 包裝 Grid 內容區，`duration: DT.durationMedium`，`switchInCurve / switchOutCurve` 使用 `DT.curveDecelerate / DT.curveAccelerate`。切換時舊內容 fadeOut + slideLeft，新內容 fadeIn + slideRight。為 AnimatedSwitcher 提供 `ValueKey(selectedTab)` 確保正確觸發。

### 最近使用條件顯示

在 `_buildRecentTools()` 外加 `if (_selectedTab == 0)` 條件判斷。`_selectedTab == 0` 代表「全部」tab。

### Hero 動畫優化

1. 在 `ToolCard` 中用 `Hero(tag: 'tool_hero_${tool.id}')` 包裝整個 icon 容器（含漸層背景圓）
2. 在 `ImmersiveToolScaffold` 中用相同 tag 的 `Hero` 包裝 header 漸層區域
3. 設定 `Hero.flightShuttleBuilder` 自訂飛行中間態：圓形 icon 容器平滑展開為矩形 header

### Confetti 粒子效果

建立 `ConfettiEffect` widget，使用 `CustomPainter` + `AnimationController` 繪製 15-20 個彩色小圓點從收藏按鈕位置向外擴散。動畫持續 600ms（`DT.durationSlow` + 100ms），使用 `DT.curveDecelerate`。粒子使用品牌色系（紫、藍、粉、橘）。

### Shimmer 骨架屏

建立 `ShimmerLoading` widget，用 `LinearGradient` + `AnimationController` 產生左到右的光澤掃過效果。提供 `ShimmerToolGrid` 預設佈局（2x4 圓角矩形模擬工具卡片）。在 `_hasAnimated == false` 時短暫顯示（200ms），然後交叉淡入真實內容。

### Hero Moment 結果動畫

建立 `HeroMoment` widget，用 `ScaleTransition` + `FadeTransition` 組合。當結果數值更新時，結果 Text 先縮小到 0.8x → 彈到 1.05x → 回到 1.0x（overshoot spring 效果），配合 opacity 從 0.5 → 1.0。使用 `DT.curveSpring` 和 `DT.durationMedium`。

## Risks / Trade-offs

- **[SliverAppBar 重構影響大]** → 首頁佈局從 ListView 改為 CustomScrollView，需要調整所有子 widget 的嵌套方式。逐步遷移，先確保基本佈局正確再加動畫。
- **[Hero flightShuttleBuilder 複雜]** → 圓形→矩形的過渡需要仔細處理 BorderRadius 動畫。如果效果不理想，可退回到簡單的 icon-only Hero。
- **[Confetti 效能]** → CustomPainter 繪製 20 個粒子在低端裝置可能卡頓。限制粒子數量並使用 `RepaintBoundary` 隔離重繪範圍。
- **[Shimmer 閃爍感]** → 如果顯示時間太短（< 200ms）會感覺閃爍。設定最小顯示時間或在已有快取時直接跳過。
