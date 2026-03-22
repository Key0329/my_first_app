## Why

匯率換算是高頻使用工具，但目前的幣別選擇器沒有優先排序，使用者需要在長列表中尋找 TWD、USD 等常用幣別。此外缺少一對多比較功能、API timeout 設定、以及快取過期提醒，影響使用體驗。

## What Changes

- 常用幣別置頂：TWD、USD、JPY、EUR 排在幣別選單頂部，與其餘幣別用分隔線區隔
- 多幣別同時顯示：新增「一對多」模式，輸入一個幣別金額同時顯示多個目標幣別的換算結果
- API timeout 設定：http request 加入 10 秒 timeout，避免永久等待
- 快取過期機制：快取超過 24 小時時在 UI 顯示過期警告提示

## Capabilities

### New Capabilities

- `enhance-currency-converter`: 匯率換算器增強 — 常用幣別置頂、一對多換算、timeout、快取過期警告

### Modified Capabilities

- `tool-currency-converter`: 匯率換算核心行為變更（幣別排序、timeout、過期顯示）

## Impact

- 影響的 spec：`tool-currency-converter`（修改）、新增 `enhance-currency-converter`
- 影響的程式碼：`lib/tools/currency_converter/currency_converter_page.dart`、`lib/tools/currency_converter/currency_api.dart`
- 新增 ARB key（l10n）
