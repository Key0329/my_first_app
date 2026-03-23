## Why

目前的 Design Token 系統（`DT` class）在多次迭代後已有間距、圓角、色彩、動畫時間等 token，但存在幾個結構性問題：字體只有零散的尺寸常數，缺乏完整的 Typography Scale（Display/Headline/Title/Body/Caption）；陰影/高度無任何 token，元件一律 `elevation: 0`；色彩是 light/dark 兩層硬編碼，缺少語義層（success/error/warning）；動畫有 duration 但沒有 Curve token；Accessibility 方面，全 App 幾乎沒有 `Semantics` 標註、`liveRegion`、或 Slider `semanticFormatterCallback`。這些缺失讓 App 在視覺一致性和無障礙使用上難以達到上架品質。

## What Changes

- 建立完整 Typography Scale token（display/headline/title/body/caption 各 large/medium/small）
- 新增 Shadow/Elevation token（none/sm/md/lg），並套用到卡片與工具頁面元件
- 將色彩系統升級為三層架構：Primitive → Semantic（success/error/warning/info）→ Component
- 新增 Animation Curve token（easeIn/easeOut/easeInOut/spring）
- 統一 Iconography 尺寸規範（xs/sm/md/lg/xl 五級）
- 全工具頁面補齊 `Semantics` 標註（label/hint/liveRegion）
- 數值變化元件加入 `liveRegion` 播報
- Slider 加入 `semanticFormatterCallback`
- 全面驗證暗色/亮色模式色彩對比度 ≥ 4.5:1

## Capabilities

### New Capabilities

- `design-tokens-v2`: 完整的 Typography Scale、Shadow/Elevation、Semantic Color、Animation Curve、Iconography 尺寸 token 系統
- `accessibility-v2`: 全 App Semantics 標註、liveRegion 播報、Slider 格式化回調、對比度合規

### Modified Capabilities

- `immersive-tool-theme`: 工具頁面元件套用新的 shadow/elevation token 和 semantic color
- `accessibility-support`: 擴充現有 accessibility 規範，加入全工具 Semantics 覆蓋要求

## Impact

- Affected specs: `design-tokens-v2`（新）、`accessibility-v2`（新）、`immersive-tool-theme`（修改）、`accessibility-support`（修改）
- Affected code:
  - `lib/theme/design_tokens.dart` — 大幅擴充 token 定義
  - `lib/theme/app_theme.dart` — 套用新 token 到 ThemeData
  - `lib/widgets/immersive_tool_scaffold.dart` — 套用 shadow/elevation
  - `lib/widgets/tool_section_card.dart` — 套用 semantic color + shadow
  - `lib/tools/*/` — 所有工具頁面補 Semantics 標註
  - `lib/pages/home_page.dart` — 首頁元件套用新 typography + shadow
  - `lib/pages/settings_page.dart` — 設定頁套用新 typography
