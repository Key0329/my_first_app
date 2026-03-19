## 1. 基礎設施 — 主題與模型擴充

- [x] [P] 1.1 擴充 `AppTheme` (app entry point and root widget)：在 `lib/theme/app_theme.dart` 加入透明 AppBar 樣式、surface container 色彩配置、支援 gradient 背景的 card theme
- [x] [P] 1.2 擴充 `ToolItem` model，實作 Decision: 卡片尺寸分為三種 — large / medium / small：在 `lib/models/tool_item.dart` 新增 `BentoSize` enum 與預設尺寸屬性

## 2. 共用元件 — ImmersiveToolScaffold

- [x] 2.1 建立 `ImmersiveToolScaffold` widget (ImmersiveToolScaffold shared base widget)，實作 Decision: 沉浸式工具頁使用共用 ImmersiveToolScaffold：包含漸層背景、透明 AppBar、圓角分隔的上下兩區佈局，支援 configurable header and body flex ratios 與 rounded corner separator between sections
- [x] 2.2 實作 tool-specific gradient colors，套用 Decision: 漸層色彩系統：在 ImmersiveToolScaffold 中根據 toolColor 計算 light/dark mode 漸層，gradient adapts to dark mode

## 3. 首頁 Bento Grid 佈局

- [x] 3.1 實作自訂 `BentoSliverGridDelegate`，套用 Decision: Bento Grid 使用 SliverGrid + 自訂 SliverGridDelegate：建立 `lib/widgets/bento_grid.dart`，支援 Bento Grid layout with variable card sizes 的自動排版
- [x] 3.2 重新設計 `ToolCard` widget (tool cards with gradient backgrounds)：改為漸層背景卡片，支援三種尺寸，大卡片支援 mini preview on large cards
- [x] 3.3 重寫 `HomePage` (tool list displayed as grid)：使用 CustomScrollView + BentoSliverGridDelegate，整合 search bar filters Bento Grid 功能
- [x] [P] 3.4 更新 `FavoritesPage` (add and remove favorites)：同步 Bento Grid 風格卡片，favorited tools display as large cards

## 4. 動畫系統

- [x] 4.1 實作 Decision: 首頁卡片交錯淡入動畫，對應 staggered fade-in animation on home page：在 HomePage 加入交錯淡入動畫，animation does not replay on tab switch
- [x] 4.2 實作 Decision: Hero 動畫連接首頁卡片與工具內頁，對應 Hero transition between home card and tool page：在 GoRouter 路由配置中使用 CustomTransitionPage，卡片展開/收合動畫 (tool pages open in full screen)
- [x] [P] 4.3 實作 interactive micro-animations (button press shows scale bounce)：建立 `lib/widgets/bouncing_button.dart` 共用微動效元件，支援 calculator result animates on change

## 5. 工具內頁改造 — 套用 ImmersiveToolScaffold

- [x] [P] 5.1 改造計算機頁面 (calculator page shows green gradient)：將 `calculator_page.dart` 的顯示區移至 headerChild、按鈕區移至 bodyChild
- [x] [P] 5.2 改造手電筒頁面 (flashlight page shows amber gradient)：將開關按鈕移至 headerChild、SOS 控制移至 bodyChild
- [x] [P] 5.3 改造指南針頁面：將羅盤盤面移至 headerChild、度數/方位顯示移至 bodyChild
- [x] [P] 5.4 改造碼錶/計時器頁面：將時間顯示移至 headerChild、控制按鈕移至 bodyChild
- [x] [P] 5.5 改造單位換算頁面：將結果顯示移至 headerChild、輸入區移至 bodyChild
- [x] [P] 5.6 改造 QR Code 產生器頁面：將 QR 碼預覽移至 headerChild、輸入區移至 bodyChild
- [x] [P] 5.7 改造密碼產生器頁面：將產生的密碼顯示移至 headerChild、選項控制移至 bodyChild
- [x] [P] 5.8 改造色彩擷取頁面：將色彩預覽移至 headerChild、色彩值/調整區移至 bodyChild
- [x] [P] 5.9 改造水平儀頁面：將水平儀視覺化移至 headerChild、數值顯示移至 bodyChild
- [x] [P] 5.10 改造噪音計頁面：將分貝儀表移至 headerChild、歷史紀錄移至 bodyChild
- [x] [P] 5.11 改造量角器頁面：將量角器視覺化移至 headerChild、角度顯示移至 bodyChild
- [x] [P] 5.12 改造發票對獎頁面：將對獎結果移至 headerChild、輸入區移至 bodyChild

## 6. 整合與驗證

- [x] 6.1 更新路由配置 `app.dart`：所有工具路由改用 CustomTransitionPage 支援 Hero 動畫
- [x] 6.2 驗證 light/dark mode 全頁面一致性
- [x] 6.3 執行 `flutter analyze` 確認無靜態分析錯誤
- [x] 6.4 執行 `flutter test` 確認既有測試通過
