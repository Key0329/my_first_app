## Why

目前工具箱有 12 個工具，其中「發票對獎」功能偏台灣特定、維護成本最高（688 行 + 外部 API 依賴），且需要 `http` 和 `mobile_scanner` 兩個額外 package。移除它並新增四個更泛用的實用工具，可提升工具箱的整體實用性並減少 app 體積。

## What Changes

- **移除**「發票對獎」工具，包含其 spec、路由、i18n 字串，以及專屬依賴（`http`、`mobile_scanner`）
- **新增** BMI 計算機：輸入身高體重，計算 BMI 值並顯示健康分級
- **新增** AA 制分帳計算機：多人動態輸入金額，計算每人應付/應收金額
- **新增** 隨機決定器：轉盤（Wheel）UI，使用者輸入選項後旋轉動畫隨機選取結果
- **新增** 螢幕尺規：以信用卡校準螢幕 PPI 後，顯示精確的公分/英寸尺規
- 工具總數：12 → 15（-1 +4）

## Capabilities

### New Capabilities

- `tool-bmi-calculator`: BMI 身體質量指數計算機，含健康分級顯示
- `tool-split-bill`: AA 制分帳計算機，支援多人動態輸入與均分計算
- `tool-random-wheel`: 隨機決定器，轉盤動畫 UI 隨機選取結果
- `tool-screen-ruler`: 螢幕尺規，信用卡校準 PPI 後顯示真實刻度

### Modified Capabilities

- `app-shell`: 路由新增四個工具頁面、移除發票對獎路由
- `localization`: 新增四個工具的 i18n 字串、移除發票對獎字串

## Impact

- 移除檔案：`lib/tools/invoice_checker/`（3 個檔案）、`openspec/specs/tool-invoice-checker/`
- 新增檔案：`lib/tools/bmi_calculator/`、`lib/tools/split_bill/`、`lib/tools/random_wheel/`、`lib/tools/screen_ruler/`
- 修改檔案：`lib/models/tool_item.dart`、`lib/app.dart`、`lib/l10n/app_en.arb`、`lib/l10n/app_zh.arb`、`pubspec.yaml`
- 依賴變更：移除 `http`、`mobile_scanner`；不新增任何 package
