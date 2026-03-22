## Why

QA 審查發現 4 個高風險 Bug 及 2 個暗色模式對比度不足問題。匯率換算的靜默 fallback 會導致使用者看到完全錯誤的結果；`dart:io` 直接 import 使 Web build 無法編譯；工具頁面的 toolColor 與首頁卡片的 toolGradients 不匹配造成視覺斷裂；Random Wheel 的 OverlayEntry 在返回時可能洩漏。暗色模式下的文字對比度未達 WCAG AA 標準（4.5:1），影響可讀性與無障礙合規。這些問題必須在任何新功能開發前優先解決。

## What Changes

- **修正匯率 fallback bug**：`CurrencyApi.convert()` 中 `rates[currency] ?? 1.0` 改為明確拋出錯誤，避免靜默產生錯誤結果
- **修正 dart:io import**：`timer_notification_service.dart` 改用條件式 import 或 `kIsWeb` 檢查，使 Web 平台可編譯
- **統一 toolColor 與 toolGradients**：將硬編碼的 `toolColor` 改為從 `ToolItem.color`（取自 `toolGradients` 第一色）取值，消除首頁卡片與工具頁面的色彩不一致
- **修正 Random Wheel OverlayEntry 洩漏**：在 `dispose()` 中確保 `_overlayEntry?.remove()`
- **提升暗色模式對比度**：`darkSubtitle` 從 `#7777A0`（對比度 3.2:1）提升至 `#9999BB`（4.5:1+）；`darkNavInactive` 從 `#555577`（2.1:1）提升至 `#7777AA`（4.5:1+）

## Capabilities

### New Capabilities

（無）

### Modified Capabilities

- `tool-currency-converter`：匯率轉換函式的錯誤處理行為變更（未知幣別從靜默 fallback 改為拋出錯誤）
- `indigo-theme`：暗色模式色彩 Token 數值調整（提升對比度至 WCAG AA）

## Impact

- 受影響程式碼：
  - `lib/tools/currency_converter/currency_api.dart` — convert() fallback 邏輯
  - `lib/services/timer_notification_service.dart` — dart:io import
  - `lib/theme/design_tokens.dart` — darkSubtitle、darkNavInactive 色值
  - `lib/tools/calculator/calculator_page.dart` — toolColor 硬編碼
  - `lib/tools/compass/compass_page.dart` — toolColor 硬編碼
  - `lib/tools/color_picker/color_picker_page.dart` — toolColor 硬編碼
  - `lib/tools/stopwatch_timer/stopwatch_timer_page.dart` — toolColor 硬編碼
  - `lib/tools/flashlight/flashlight_page.dart` — toolColor 硬編碼
  - `lib/tools/noise_meter/noise_meter_page.dart` — toolColor 硬編碼
  - `lib/tools/qr_generator/qr_generator_page.dart` — toolColor 硬編碼
  - `lib/tools/password_generator/password_generator_page.dart` — toolColor 硬編碼
  - `lib/tools/level/level_page.dart` — toolColor 硬編碼
  - `lib/tools/protractor/protractor_page.dart` — toolColor 硬編碼
  - `lib/tools/unit_converter/unit_converter_page.dart` — toolColor 硬編碼
  - `lib/tools/random_wheel/random_wheel_page.dart` — OverlayEntry 生命週期
- 受影響測試：匯率換算相關 test 需更新以驗證錯誤拋出行為
- 無新增依賴
