## Summary

移除 QR Code 掃描功能，只保留 QR Code 產生器，並將工具重新命名為「QR Code 產生器」。

## Motivation

現代手機（iOS / Android）的原生相機已內建 QR Code 掃描功能，app 內的掃描 tab 沒有額外價值。相對地，QR Code 產生功能是手機原生不提供的實用功能。移除掃描可以簡化程式碼、移除 `mobile_scanner` 依賴（需要相機權限），並讓工具名稱更準確反映其用途。

## Proposed Solution

- 移除 `_ScannerTab`、`_ScanResultCard`、`_PermissionDeniedView` 等掃描相關 widget
- 移除 `TabBar` / `TabBarView` 結構，改為只顯示產生器內容
- 將頁面改名為 `QrGeneratorPage`（檔案搬移至 `lib/tools/qr_generator/`）
- 更新路由、工具清單、i18n 字串（`toolQrScanner` → `toolQrGenerator`，中文「QR 掃描」→「QR Code 產生器」，英文「QR Scanner」→「QR Generator」）
- 移除 `mobile_scanner` 套件依賴
- 移除 Android/iOS 的相機權限宣告（如確認無其他功能使用）

## Impact

- 受影響的 specs：`tool-qr-scanner`（掃描需求移除、相機權限需求移除、產生需求保留，spec 應重新命名為 `tool-qr-generator`）
- 受影響的程式碼：
  - `lib/tools/qr_scanner/qr_scanner_page.dart`（重構並搬移）
  - `lib/app.dart`（路由更新）
  - `lib/models/tool_item.dart`（工具定義更新）
  - `lib/l10n/app_en.arb`、`lib/l10n/app_zh.arb`（i18n 字串更新）
  - `pubspec.yaml`（移除 `mobile_scanner` 依賴）
  - `android/app/src/main/AndroidManifest.xml`（移除相機權限）
  - `ios/Runner/Info.plist`（移除相機使用說明）

## Capabilities

### New Capabilities

（無）

### Modified Capabilities

- `tool-qr-scanner`：移除掃描和相機權限需求，僅保留 QR Code 產生需求
