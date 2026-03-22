## Why

目前 AA 分帳只支援等分模式，無法處理不同消費比例的情境。此外缺少小費計算和多項目拆分功能，是使用者常見的需求場景（如聚餐各人點不同餐、加小費等）。

## What Changes

- 不等分模式：按自訂比例分帳，每人可設定不同比例
- 小費百分比選項：提供 0%/5%/10%/15%/20% 快捷按鈕，小費加入總額後再分帳
- 多項目拆分：新增項目列表，每個項目可設金額和參與人數，各項目分開計算再彙總

## Capabilities

### New Capabilities

- `enhance-split-bill`: 分帳增強 — 不等分模式、小費百分比、多項目拆分

### Modified Capabilities

- `tool-split-bill`: 分帳核心計算邏輯擴展（支援比例分帳和小費）

## Impact

- 影響的 spec：`tool-split-bill`（修改），新增 `enhance-split-bill`
- 影響的程式碼：`lib/tools/split_bill/split_bill_page.dart`
- 新增 ARB key（l10n）
