## Why

碼錶/計時器、密碼產生器、QR 產生器是高使用率的生活工具，但目前功能較基礎。碼錶缺少快捷時間按鈕和「再來一次」功能；密碼產生器沒有歷史記錄；QR 產生器只支援純文字，不支援 WiFi、vCard 等格式。強化這些工具可提升日常使用頻率和留存率。

## What Changes

**碼錶/計時器：**
- 快捷時間按鈕（3min/5min/10min）一鍵設定計時器
- 「再來一次」按鈕，計時結束後可快速重新開始
- 分圈紀錄匯出（複製為文字）

**密碼產生器：**
- 密碼歷史記錄（加密儲存在 SharedPreferences）
- 易記密碼模式（word-based，如 correct-horse-battery-staple）

**QR 產生器：**
- 支援 WiFi、vCard、Email 等 QR 類型模板

## Capabilities

### New Capabilities

- `enhance-life-tools`: 生活工具增強 — 碼錶快捷/再來一次/匯出、密碼歷史/易記模式、QR 多類型

### Modified Capabilities

- `tool-stopwatch-timer`: 碼錶計時器增強（快捷按鈕、再來一次、分圈匯出）
- `tool-password-generator`: 密碼產生器增強（歷史、易記模式）
- `tool-qr-scanner`: QR 產生器增強（WiFi/vCard/Email 模板）— 注意：此處修改的是 QR 產生器頁面

## Impact

- 影響的 spec：`tool-stopwatch-timer`、`tool-password-generator`、`tool-qr-scanner`（修改）
- 影響的程式碼：`lib/tools/stopwatch_timer/stopwatch_timer_page.dart`、`lib/tools/password_generator/password_generator_page.dart`、`lib/tools/qr_generator/qr_generator_page.dart`
- 新增 ARB key（l10n）
