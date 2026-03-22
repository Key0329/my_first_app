## Why

目前 15 個工具頁面的 body 區域使用原生 Material 預設風格，與首頁精心設計的 Bento Grid 風格存在明顯的視覺斷裂。首頁有統一的 Design Tokens、交錯淡入動畫、品牌漸層色系統，但進入工具頁面後，這些設計語言完全消失——間距隨意混用、按鈕缺乏微動效、色彩直接寫死、視覺層次扁平。此次改造旨在將首頁的 Bento 設計語言延伸至所有工具頁面，建立一致的產品設計感。

## What Changes

- **Body 區域 Bento 卡片化**：將工具頁面的操作區控件分組為圓角卡片區塊，使用淡色填充無邊框風格（`brandPrimaryBgLight` / `brandPrimaryBgDark`），圓角 16dp
- **微動效系統全面應用**：所有按鈕套用 `BouncingButton`（縮放 0.95 + elasticOut 回彈），數值變動加入 `AnimatedSwitcher` 上滑淡入，body 區塊進場使用交錯淡入動畫
- **品牌漸層色融入**：主要操作按鈕使用工具專屬漸層色（`toolGradients`），結果數值使用工具色強調，輸入框 focus 使用品牌色
- **Design Token 統一**：擴展 `DT` 類別加入工具頁面專用 Token（body 邊距、區塊間距、按鈕圓角、字體大小），所有工具頁面統一引用
- **4 種佈局模式標準化**：依據工具特性分為「輸入→結果」「網格操作」「單一焦點」「即時畫布」四種模式，各自有對應的 Bento 區塊組織方式
- 涵蓋全部 15 個工具頁面的改造

## Capabilities

### New Capabilities

- `tool-body-bento-style`: 工具頁面 body 區域的 Bento 卡片區塊系統，包含共用元件（ToolSectionCard、ToolGradientButton）、Design Token 擴展、4 種佈局模式規範

### Modified Capabilities

- `app-animations`: 新增工具頁面微動效需求——所有按鈕 BouncingButton、數值 AnimatedSwitcher、body 區塊交錯淡入
- `immersive-tool-theme`: 擴展 body 區域的設計規範——Bento 卡片分組、品牌色融入、漸層按鈕

## Impact

- 影響的核心檔案：
  - `lib/theme/design_tokens.dart` — 擴展工具頁面 Token
  - `lib/widgets/immersive_tool_scaffold.dart` — 可能微調 body 區域樣式
  - `lib/widgets/bouncing_button.dart` — 確認 API 便於套用
- 新增共用元件：
  - `lib/widgets/tool_section_card.dart` — Bento 區塊卡片
  - `lib/widgets/tool_gradient_button.dart` — 漸層操作按鈕
- 影響的工具頁面（15 個）：
  - `lib/tools/calculator/calculator_page.dart`
  - `lib/tools/unit_converter/unit_converter_page.dart`
  - `lib/tools/bmi_calculator/bmi_calculator_page.dart`
  - `lib/tools/split_bill/split_bill_page.dart`
  - `lib/tools/level/level_page.dart`
  - `lib/tools/compass/compass_page.dart`
  - `lib/tools/protractor/protractor_page.dart`
  - `lib/tools/screen_ruler/screen_ruler_page.dart`
  - `lib/tools/noise_meter/noise_meter_page.dart`
  - `lib/tools/flashlight/flashlight_page.dart`
  - `lib/tools/stopwatch_timer/stopwatch_timer_page.dart`
  - `lib/tools/password_generator/password_generator_page.dart`
  - `lib/tools/color_picker/color_picker_page.dart`
  - `lib/tools/qr_generator/qr_generator_page.dart`
  - `lib/tools/random_wheel/random_wheel_page.dart`
