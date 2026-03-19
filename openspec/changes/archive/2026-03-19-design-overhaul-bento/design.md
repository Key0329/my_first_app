## Context

「工具箱 Pro」是一個包含 12 個實用工具的 Flutter 多合一 app。目前 UI 使用 Material 3 預設樣式，首頁為 2 欄等大 GridView，工具內頁皆為標準 Scaffold + AppBar 模式。每個工具在 `ToolItem` model 中已定義專屬色彩（`Color`），但目前僅用於首頁卡片的 56px 圓形 icon 背景，進入工具頁後完全消失。

現有架構：
- 路由：GoRouter，ShellRoute（底部導航）+ 獨立 GoRoute（工具全螢幕）
- 主題：`AppTheme.light()` / `AppTheme.dark()`，seed color 為 teal
- 狀態：`AppSettings` (ChangeNotifier) 管理主題、語言、收藏
- 卡片：`ToolCard` widget，所有工具相同大小與佈局

## Goals / Non-Goals

**Goals:**

- 首頁改為 Bento Grid 混搭排版，打破均勻格子的單調感
- 每個工具內頁套用沉浸式色彩主題（上半部漸層 + 下半部操作區）
- 加入動畫系統提升互動感（交錯淡入、Hero 轉場、微動效）
- 建立可複用的設計元件（BentoGrid、ImmersiveToolScaffold）
- 同時支援 light / dark mode

**Non-Goals:**

- 不改變任何工具的功能邏輯
- 不新增外部動畫套件（僅用 Flutter 內建動畫）
- 不改變路由結構（GoRouter + ShellRoute 維持不變）
- 不做工具圖示的客製化（繼續使用 Material Icons）
- 不改變資料模型核心結構

## Decisions

### Decision: Bento Grid 使用 SliverGrid + 自訂 SliverGridDelegate

使用 `CustomScrollView` + `SliverGrid` 搭配自訂 `SliverGridDelegate` 來實現不等高卡片佈局。

**替代方案：**
- `flutter_staggered_grid_view` 套件 — 功能完善但增加外部依賴
- `Wrap` widget — 不支援懶載入，12 個卡片問題不大但擴展性差
- `GridView` + `StaggeredTile` — 需要第三方

選擇自訂 delegate 因為：卡片數量固定（12 個），佈局邏輯可預測（大/中/小三種尺寸），不需要瀑布流的動態高度計算。

### Decision: 卡片尺寸分為三種 — large / medium / small

在 `ToolItem` model 新增 `BentoSize` 屬性：
- `large`：橫跨 2 欄，高度 1.5x（用於收藏的工具或「最近使用」）
- `medium`：佔 1 欄，高度 1.2x（標準尺寸）
- `small`：佔 1 欄，高度 1x（緊湊尺寸）

收藏的工具自動升級為 large，其餘依預設排列。Bento layout 會根據可用卡片動態排列組合。

### Decision: 沉浸式工具頁使用共用 ImmersiveToolScaffold

建立 `ImmersiveToolScaffold` widget，所有 12 個工具頁使用此基底：

```
┌────────────────────────┐
│  透明 AppBar + 返回鍵    │
│  ▼ 漸層背景區（工具色）   │  ← 上半部：flex 比例由各工具自訂
│  ▼ 核心顯示內容          │
├────── 圓角分隔 ──────────┤
│                        │  ← 下半部：圓角容器
│  操作區域               │     surface color
│                        │
└────────────────────────┘
```

參數：
- `toolColor`: 工具專屬色彩
- `title`: 工具名稱
- `headerChild`: 上半部自訂內容（顯示區）
- `bodyChild`: 下半部自訂內容（操作區）
- `headerFlex` / `bodyFlex`: 上下比例

**替代方案：**
- 各工具頁各自實作 — 一致性難維護，12 個頁面重複代碼
- Theme overlay — 只能改顏色，無法控制佈局結構

### Decision: Hero 動畫連接首頁卡片與工具內頁

使用 Flutter 內建 `Hero` widget，tag 為 `tool_hero_${tool.id}`。首頁卡片的漸層背景會平滑展開成工具內頁的漸層背景。

需要配合 GoRouter 的 `CustomTransitionPage` 來控制轉場：
- 進入：卡片 Hero expand + fade-in body
- 離開：reverse Hero + fade-out body

### Decision: 漸層色彩系統

每個工具已有一個 `Color`，漸層規則統一為：
- Light mode：`[toolColor.withOpacity(0.8), toolColor.withOpacity(0.4)]`，從上到下
- Dark mode：`[toolColor.withOpacity(0.5), toolColor.withOpacity(0.2)]`，從上到下
- 卡片背景：使用更淡的版本 `[toolColor.withOpacity(0.3), toolColor.withOpacity(0.1)]`

不引入額外色彩定義，所有衍生色皆由單一 `toolColor` 透過 opacity 計算。

### Decision: 首頁卡片交錯淡入動畫

使用 `AnimationController` + `Interval` 實現交錯效果：
- 每張卡片延遲 50ms 開始
- 動畫：從下方 20px 處 slide up + fade in
- 總時長約 600ms（12 張卡片）
- 僅在首次進入頁面時播放

## Risks / Trade-offs

- **[風險] 12 個工具頁面改動量大** → 先建好 `ImmersiveToolScaffold` 元件，各工具頁只需將內容包入即可，實際改動為機械式替換
- **[風險] Hero 動畫與 GoRouter 相容性** → GoRouter 支援 `pageBuilder` + `CustomTransitionPage`，已有社群驗證的實作方式
- **[風險] Bento Grid 排版在不同螢幕尺寸可能跑版** → 使用 `LayoutBuilder` 根據螢幕寬度決定欄數（手機 2 欄、平板 3-4 欄）
- **[取捨] 自訂 SliverGridDelegate 開發成本 vs 第三方套件** → 接受稍高開發成本換取零外部依賴
- **[取捨] 首次動畫 vs 每次動畫** → 僅首次進入播放，避免重複動畫造成疲勞
