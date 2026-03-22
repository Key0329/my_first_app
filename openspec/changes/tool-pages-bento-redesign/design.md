## Context

目前 15 個工具頁面共用 `ImmersiveToolScaffold` 作為骨架（漸層 header + 圓角 body），但 body 區域的內部設計各自為政。首頁已建立完整的 Bento Grid 設計語言（Design Tokens、交錯動畫、品牌漸層），需要將這套語言延伸至工具頁面的 body 區域。

現有基礎設施：
- `DT` 類別（`lib/theme/design_tokens.dart`）— 品牌色、間距、圓角、字體 Token
- `BouncingButton`（`lib/widgets/bouncing_button.dart`）— 彈性按鈕，已存在但未被工具頁面使用
- `StaggeredFadeIn`（`lib/widgets/staggered_fade_in.dart`）— 交錯淡入動畫
- `toolGradients`（`lib/theme/design_tokens.dart`）— 15 個工具的漸層色定義

## Goals / Non-Goals

**Goals:**

- 建立工具頁面 body 區域的 Bento 卡片區塊系統
- 所有互動元素統一使用微動效（BouncingButton、AnimatedSwitcher）
- 主要操作按鈕使用工具專屬漸層色
- 擴展 Design Tokens 覆蓋工具頁面所有設計決策
- 改造全部 15 個工具頁面

**Non-Goals:**

- 不改動 header 區域的漸層設計（已經是好的）
- 不改動工具的功能邏輯
- 不新增或移除工具
- 不改動首頁設計
- 不改動導航結構

## Decisions

### 使用 ToolSectionCard 作為 body 區塊容器

所有工具頁面的 body 區控件將被分組放入 `ToolSectionCard` 元件中。

**設計規格：**
- 背景色：淡品牌色填充（light: `DT.brandPrimaryBgLight`、dark: `DT.brandPrimaryBgDark`）
- 無邊框（與首頁有邊框的卡片做區分，更柔和）
- 圓角：`DT.radiusLg`（16dp）
- 內邊距：`DT.spaceLg`（16dp）
- 區塊間距：`DT.gridSpacing`（12dp）
- 可選的標題標籤（14dp 品牌色文字）

**替代方案：** 有邊框無填色（跟首頁卡片一致）→ 放棄，因用戶偏好更柔和的淡色填充風格。

### 使用 ToolGradientButton 作為主要操作按鈕

每個工具的核心 CTA 按鈕將使用工具專屬漸層色背景，取代 Material 預設的 `FilledButton`。

**設計規格：**
- 背景：`toolGradients[toolId]` 135° 漸層
- 圓角：`DT.radiusMd`（14dp）
- 高度：52dp
- 文字：白色、16dp、w600
- 自動包裹 `BouncingButton` 微動效

### 擴展 DT 加入工具頁面 Token

在 `DT` 類別新增工具頁面專用常數：

```dart
// ── 工具頁面 Body ──
static const toolBodyPadding = 16.0;
static const toolSectionGap = 12.0;
static const toolSectionRadius = 16.0;
static const toolSectionPadding = 16.0;

// ── 工具頁面按鈕 ──
static const toolButtonRadius = 14.0;
static const toolButtonHeight = 52.0;

// ── 工具頁面字體 ──
static const fontToolResult = 36.0;
static const fontToolLabel = 14.0;
static const fontToolButton = 16.0;
```

### 四種佈局模式標準化

按工具特性分為四種 body 佈局模式：

| 模式 | 工具 | 區塊組織 |
|------|------|---------|
| A. 輸入→結果 | 單位換算、分帳、BMI、密碼、QR | 輸入區塊 → 結果區塊（結果用工具色 10% 底色區分） |
| B. 網格操作 | 計算機 | 全區域按鈕網格（單一大區塊） |
| C. 單一焦點 | 手電筒、碼錶、指南針、水平儀、噪音計 | 中央互動元件 + 底部控制區塊 |
| D. 即時畫布 | 螢幕尺規、量角器、色彩擷取、隨機轉盤 | 互動畫布區 + 控制面板區塊 |

每種模式內部使用相同的 `ToolSectionCard` 組織，但區塊數量和排列不同。

### 微動效全面應用策略

| 元素 | 動畫 | 實作方式 |
|------|------|---------|
| 主要按鈕 | 縮放 0.95 + elasticOut 回彈 | 包裹 `BouncingButton` |
| 數值結果 | 上滑淡入過渡 | `AnimatedSwitcher` + `SlideTransition` |
| Body 區塊 | 交錯淡入進場 | 複用 `StaggeredFadeIn`（50ms 間隔） |
| 開關控件 | Material 3 預設動畫 | 原生 `Switch`/`SwitchListTile` |

### 品牌色融入 body 區域

- 結果區塊背景：工具色 8% 不透明度（light mode）/ 15% 不透明度（dark mode）
- 結果數值文字：工具漸層色深色端
- 輸入框 focus 邊框：`DT.brandPrimary`
- 區塊標題文字：`DT.brandPrimary`（light）/ `DT.brandPrimarySoft`（dark）

## Risks / Trade-offs

- [15 個頁面改動範圍大] → 分兩階段：先建共用元件，再逐個改造；每改完一批就執行 `flutter test` 確認無回歸
- [部分工具有特殊佈局（如計算機網格、色彩擷取相機）] → 允許模式內彈性，但確保 Token 和動畫一致
- [深色模式下淡品牌色底可能對比度不足] → 深色模式使用 `DT.brandPrimaryBgDark`（#2A2A4E）而非透明度計算，確保可讀性
- [效能影響：大量 AnimatedSwitcher] → 僅對結果數值加動畫，不對高頻更新元素（如碼錶毫秒）加動畫
