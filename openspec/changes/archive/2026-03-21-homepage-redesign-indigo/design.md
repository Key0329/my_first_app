## Context

「工具箱」app 目前有 15 個工具，首頁使用 Bento Grid 混搭排版（大小不等卡片）搭配 teal 品牌色。根據新的概念設計圖，需要全面重設計首頁風格為靛紫品牌色 + 均勻 Grid + 分類 Tab。

現有架構：
- 路由：GoRouter，ShellRoute（底部導航）+ 獨立 GoRoute（工具全螢幕）
- 主題：`AppTheme.light()` / `AppTheme.dark()`，seed color 為 teal
- 首頁：`HomePage` 使用 `BentoGrid` + `ToolCard`（漸層背景）
- Model：`ToolItem` 包含 id、nameKey、fallbackName、icon、color、routePath、defaultBentoSize

概念設計圖的關鍵視覺元素：
- 品牌色靛紫 `#6C5CE7`
- 卡片：白底/深藍底 + 彩色圓角方塊 icon（白色線條圖標）+ 工具名稱
- 分類 Tab：全部、計算、測量、生活
- Dark mode：背景 `#1A1A2E`、卡片 `#16213E`
- 標題：「工具箱」+ 副標「N 個工具，隨手可用」

## Goals / Non-Goals

**Goals:**

- 首頁視覺完全對齊概念設計圖
- 品牌色系統從 teal 遷移至靛紫
- Dark mode 使用專屬配色（深靛藍）而非 M3 預設暗色
- ToolItem 支援分類，供 Tab 篩選使用
- 保持首頁進場動畫（交錯淡入）

**Non-Goals:**

- 不改動任何工具內頁（ImmersiveToolScaffold 保留原樣）
- 不新增工具或功能
- 不實作 PRO 標記/付費機制（概念圖中的 PRO badge 先不做）
- 不改動底部導航的功能邏輯（只改配色）

## Decisions

### Decision: 品牌色使用 ColorScheme.fromSeed 搭配靛紫 seed

用 `ColorScheme.fromSeed(seedColor: Color(0xFF6C5CE7))` 產生完整 M3 色彩系統。

**替代方案：**
- 手動定義完整 ColorScheme — 精確控制但維護成本高
- 僅改 primary — 其他色彩不協調

選擇 fromSeed 因為：M3 會自動產生和諧的 secondary、tertiary、surface 等色彩，且概念設計的整體色調與 fromSeed 產生的結果相符。

### Decision: Dark mode 使用自訂 surface 配色覆蓋 M3 預設

Dark mode 需要深靛藍背景 `#1A1A2E` 和卡片 `#16213E`，而非 M3 自動產生的暗色。透過 `ColorScheme.fromSeed(...).copyWith()` 覆蓋 `surface`、`surfaceContainerLow`、`surfaceContainer` 等色值。

**替代方案：**
- 完全自訂 ColorScheme — 太脆弱，容易漏掉某些 M3 元件的色彩
- 使用 ThemeExtension — 過度工程，只需覆蓋幾個 surface 色即可

### Decision: 分類 Tab 使用 enum ToolCategory + FilterChip 列

在 `ToolItem` model 新增 `ToolCategory` enum（all、calculate、measure、life），每個工具指定一個分類。首頁頂部使用橫向 `FilterChip`（或 `ChoiceChip`）列，風格對齊概念設計的膠囊形 Tab。

**替代方案：**
- TabBar — 太死板，不像概念圖的膠囊風格
- SegmentedButton — 寬度固定，4 個選項會太擠

15 個工具的分類：
- 計算：calculator、unit_converter、bmi_calculator、split_bill
- 測量：level、compass、protractor、screen_ruler、noise_meter
- 生活：flashlight、stopwatch_timer、password_generator、color_picker、qr_generator、random_wheel

### Decision: 卡片風格使用圓角方塊 icon 容器

概念設計的卡片結構：
```
┌──────────────────┐
│                  │
│    ┌────────┐    │
│    │  白 icon │   │  ← 圓角方塊，背景為工具色
│    └────────┘    │
│                  │
│    工具名稱       │
└──────────────────┘
```

卡片本身：白底（light）/ `#16213E`（dark），圓角 16px。
Icon 容器：工具色背景，圓角 12px，白色線條 icon。
不再使用漸層背景。

### Decision: 拆除 BentoGrid 改用標準 GridView

首頁回歸 `GridView.builder` + `SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)`。移除 `BentoSize` enum 和 `BentoGrid` widget（首頁不再需要）。

`ToolCard` 完全重寫為新的卡片風格。由於工具內頁仍使用 Hero 動畫，`ToolCard` 繼續包裹 `Hero(tag: 'tool_hero_${tool.id}')`。

### Decision: AppBar 改為品牌標題 + 副標 + 搜尋按鈕

概念設計的 AppBar：
- 左側：大字「工具箱」+ 副標「N 個工具，隨手可用」
- 右側：搜尋 icon button
- 無標準 AppBar 背景色，融入頁面

用自訂的 `SliverAppBar` 或在頁面頂部直接建構標題區域，不使用 Scaffold 的 appBar 參數。

## Risks / Trade-offs

- **[風險] 品牌色變更影響工具內頁** → ImmersiveToolScaffold 的 AppBar 文字色會跟著 M3 ColorScheme 變化，但漸層背景用的是各工具自己的 `toolColor`，不受影響。需驗證透明 AppBar 在新 ColorScheme 下的前景色是否正確。
- **[風險] Dark mode 自訂 surface 可能與某些 M3 元件衝突** → 只覆蓋最外層的 surface 色，不覆蓋 container variants 以外的色彩，讓 M3 自動處理其餘部分。
- **[取捨] 移除 BentoGrid 代表之前的工作被丟棄** → Bento 相關檔案（`bento_grid.dart`）可以刪除，因為新設計不需要。程式碼已在 git 歷史中保留。
- **[取捨] 不做 PRO badge** → 概念圖有但先不實作，避免範圍膨脹。日後可在 ToolItem 加 `isPro` flag。
