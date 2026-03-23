## 1. 新增共用微互動元件

- [x] [P] 1.1 建立 ShimmerLoading widget（Shimmer loading skeleton 骨架屏元件 + ShimmerToolGrid 預設佈局）— 對應 Shimmer loading skeleton on home page + Shimmer skeleton animation timing requirement
- [x] [P] 1.2 建立 ConfettiEffect widget（confetti 粒子效果元件，15-20 彩色粒子 CustomPainter）— 對應 Confetti effect on favorite toggle requirement
- [x] [P] 1.3 建立 HeroMoment widget（Hero Moment 結果動畫，scale-bounce + fade）— 對應 Hero Moment result animation requirement

## 2. 首頁 SliverAppBar 滾動縮小架構重構

- [x] 2.1 首頁 ListView 改為 CustomScrollView + SliverAppBar（Collapsible title area，floating + snap）— 對應 Collapsible title area with SliverAppBar requirement
- [x] 2.2 搜尋按鈕改為 Placeholder 搜尋欄（Home page tool search bar，full-width 圓角容器 + hint text）— 對應 Placeholder search bar on home page + Home page tool search requirement

## 3. 首頁體驗優化

- [x] 3.1 Tab 切換加 AnimatedSwitcher Tab 過渡動畫（Tab switch transition animation，fade + slide）— 對應 Tab switch transition animation + Tab switch animation on home page requirement
- [x] 3.2 最近使用條件顯示：只在「全部」tab 顯示（Recent tools only in All tab）— 對應 Recent tools only in All tab requirement

## 4. Hero 動畫優化

- [x] 4.1 ToolCard icon 容器 + ImmersiveToolScaffold header 的 Enhanced Hero animation（flightShuttleBuilder 圓形→矩形過渡）— 對應 Enhanced Hero animation for tool navigation requirement

## 5. 收藏 + 結果動畫整合

- [x] [P] 5.1 ToolCard 收藏按鈕整合 ConfettiEffect（Confetti effect on favorite toggle，加入收藏時觸發）— 對應 Confetti effect on favorite toggle requirement
- [x] [P] 5.2 首頁整合 ShimmerLoading（Shimmer 骨架屏載入，初次載入短暫顯示後 crossfade）— 對應 Shimmer loading skeleton on home page requirement
- [x] [P] 5.3 工具結果頁整合 HeroMoment（Hero Moment 結果動畫，BMI / 匯率等結果展示）— 對應 Hero Moment result animation requirement
