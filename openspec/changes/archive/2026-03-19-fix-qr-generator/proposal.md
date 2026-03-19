## Why

QR Code 產生器目前只顯示一個固定的 Material icon (`Icons.qr_code_2`)，無論使用者輸入什麼內容，畫面都一模一樣。這使得「產生 QR Code」功能形同虛設，無法實際使用。需要引入 QR Code 圖像產生套件，讓產生器能根據輸入內容渲染出真正的 QR Code。

## What Changes

- 新增 `qr_flutter` 套件依賴，用於在 Flutter widget 中渲染 QR Code 圖像
- 將 `_GeneratorTab` 中的 placeholder icon 替換為 `QrImageView` widget，根據使用者輸入的文字即時產生對應的 QR Code 圖片
- 移除原本的 TODO 註解（`// TODO: 使用 qr_flutter 或類似套件產生實際 QR Code 圖片`）

## Capabilities

### New Capabilities

（無）

### Modified Capabilities

- `tool-qr-scanner`: QR Code 產生器需要能根據輸入內容渲染出實際的 QR Code 圖像，而非僅顯示 placeholder

## Impact

- 受影響的程式碼：`lib/tools/qr_scanner/qr_scanner_page.dart`（`_GeneratorTab` widget）
- 新增依賴：`qr_flutter` 套件（`pubspec.yaml`、`pubspec.lock`）
