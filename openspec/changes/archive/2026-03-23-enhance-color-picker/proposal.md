## Why

色彩擷取工具目前只能從相機即時取色，無法從既有圖片取色。設計師和開發者常需要從截圖或參考圖中提取色彩。此外只顯示 HEX 和 RGB，缺少 HSL 格式，而且色彩歷史記錄在離開頁面後就會消失。

## What Changes

- 從相簿選圖取色：新增圖片選擇器，從相簿選圖後可在圖上點擊取色
- 色彩歷史持久化：將歷史記錄保存到 SharedPreferences，下次進入保留
- 色碼格式切換：新增 HSL 顯示格式，可在 HEX/RGB/HSL 之間切換

## Capabilities

### New Capabilities

- `enhance-color-picker`: 色彩擷取增強 — 相簿取色、歷史持久化、HSL 格式

### Modified Capabilities

- `tool-color-picker`: 色彩擷取核心行為變更（新增圖片取色、持久化歷史、HSL）

## Impact

- 影響的 spec：`tool-color-picker`（修改），新增 `enhance-color-picker`
- 影響的程式碼：`lib/tools/color_picker/color_picker_page.dart`
- 新增依賴：`image_picker`（從相簿選圖）
- 新增 ARB key（l10n）
