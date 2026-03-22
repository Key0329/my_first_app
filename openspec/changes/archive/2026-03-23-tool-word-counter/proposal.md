## Why

工具箱目前以計算和測量工具為主，缺少文字處理類的實用工具。文字計數器是寫作者、學生、社群經營者的日常需求（字數限制、閱讀時間估算），也是低開發成本、高使用頻率的工具，能擴展工具箱的使用場景並提升用戶留存。

## What Changes

- 新增「文字計數器」工具頁面，提供即時文字分析功能
- 支援字元數、字數（中/英分開計數）、行數、段落數統計
- 提供預估閱讀時間（基於中文 300 字/分鐘、英文 200 字/分鐘）
- 在 tool registry（`allTools`）中註冊新工具，自動產生路由
- 新增對應的 i18n 字串（zh + en）
- 歸類為「生活」分類

## Capabilities

### New Capabilities

- `tool-word-counter`: 文字計數器工具頁面，提供即時字元數、字數、行數、段落數統計與閱讀時間預估

### Modified Capabilities

（無）

## Impact

- 受影響程式碼：
  - `lib/models/tool_item.dart` — 新增 word_counter 工具註冊
  - `lib/tools/word_counter/word_counter_page.dart` — 新增工具頁面（新檔案）
  - `lib/l10n/app_zh.arb` — 新增中文字串
  - `lib/l10n/app_en.arb` — 新增英文字串
  - `test/tools/word_counter_test.dart` — 新增測試（新檔案）
