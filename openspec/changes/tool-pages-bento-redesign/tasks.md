## 1. 基礎建設 — 使用 ToolSectionCard 作為 body 區塊容器、使用 ToolGradientButton 作為主要操作按鈕

- [x] 1.1 擴展 DT 加入工具頁面 Token（Design Tokens for tool page body）：在 `lib/theme/design_tokens.dart` 新增 `toolBodyPadding`、`toolSectionGap`、`toolSectionRadius`、`toolSectionPadding`、`toolButtonRadius`、`toolButtonHeight`、`fontToolResult`、`fontToolLabel`、`fontToolButton`
- [x] [P] 1.2 建立 ToolSectionCard shared container widget：建立 `lib/widgets/tool_section_card.dart`，實作淡品牌色填充背景、16dp 圓角、可選標題標籤，支援亮/暗模式（Body area Bento card organization）
- [x] [P] 1.3 建立 ToolGradientButton for primary actions（Tool gradient button replaces FilledButton for primary actions）：建立 `lib/widgets/tool_gradient_button.dart`，實作 135° 漸層背景、14dp 圓角、52dp 高度、白色文字、內建 BouncingButton 包裹

## 2. 動畫系統擴展 — 微動效全面應用策略

- [x] [P] 2.1 實作 Tool page body staggered fade-in animation：在工具頁面 body 區塊套用 StaggeredFadeIn，確保區塊交錯淡入進場且不在 widget rebuild 時重播
- [x] [P] 2.2 實作 Value change animation with AnimatedSwitcher：建立可複用的動畫數值顯示元件，200ms 上滑淡入/淡出過渡，排除高頻更新（碼錶）
- [x] 2.3 全面應用 Interactive micro-animations（BouncingButton）：確認 BouncingButton API 適用於 FilledButton、OutlinedButton、IconButton、GestureDetector

## 3. 改造四種佈局模式標準化 — 模式 A 輸入→結果（品牌色融入 body 區域 + Result section tinted background + Brand color integration in body area）

- [x] [P] 3.1 改造單位換算頁面：套用 ToolSectionCard 分組、ToolGradientButton、AnimatedSwitcher 結果動畫、DT Token 間距，實作 Brand color integration in body area，遵循 Four standardized body layout modes Mode A
- [x] [P] 3.2 改造分帳計算頁面：套用 Bento 卡片化 + Result section tinted background 結果區塊工具色底色 + 漸層按鈕
- [x] [P] 3.3 改造 BMI 計算機頁面：套用 Bento 卡片化 + AnimatedSwitcher BMI 數值 + 漸層按鈕
- [x] [P] 3.4 改造密碼產生器頁面：套用 Bento 卡片化 + 漸層產生按鈕 + BouncingButton 微動效
- [x] [P] 3.5 改造 QR Code 產生器頁面：套用 Bento 卡片化 + 漸層產生按鈕

## 4. 改造模式 B 工具頁面 — 網格操作

- [x] 4.1 改造計算機頁面：套用 ToolSectionCard 網格區塊、BouncingButton 按鈕動畫、AnimatedSwitcher 結果動畫、DT Token 統一，遵循 Four standardized body layout modes Mode B

## 5. 改造模式 C 工具頁面 — 單一焦點

- [x] [P] 5.1 改造手電筒頁面：套用 ToolSectionCard 控制區塊 + BouncingButton + DT Token
- [x] [P] 5.2 改造碼錶/計時器頁面：套用 Bento 卡片化 + ToolGradientButton 開始按鈕 + BouncingButton（排除碼錶高頻更新的 AnimatedSwitcher）
- [x] [P] 5.3 改造指南針頁面：套用 ToolSectionCard + BouncingButton + DT Token
- [x] [P] 5.4 改造水平儀頁面：套用 ToolSectionCard + DT Token 統一
- [x] [P] 5.5 改造噪音計頁面：套用 ToolSectionCard + AnimatedSwitcher 分貝數值 + DT Token

## 6. 改造模式 D 工具頁面 — 即時畫布

- [x] [P] 6.1 改造螢幕尺規頁面：套用 ToolSectionCard 控制面板 + DT Token，遵循 Four standardized body layout modes Mode D
- [x] [P] 6.2 改造量角器頁面：套用 ToolSectionCard + DT Token
- [x] [P] 6.3 改造色彩擷取頁面：套用 ToolSectionCard 色值顯示區 + DT Token
- [x] [P] 6.4 改造隨機轉盤頁面：套用 ToolSectionCard 選項面板 + ToolGradientButton 轉動按鈕 + BouncingButton

## 7. 更新 ImmersiveToolScaffold shared base widget

- [x] 7.1 更新 ImmersiveToolScaffold shared base widget：確認 body 區域支援 Body area Bento card organization 與 DT token padding，更新工具數量描述從 12 改為 15

## 8. 驗證

- [x] 8.1 執行 `flutter analyze` 確認無靜態分析錯誤
- [x] 8.2 執行 `flutter test` 確認既有測試無回歸
