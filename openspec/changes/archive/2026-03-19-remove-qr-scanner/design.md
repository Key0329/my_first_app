## Context

目前 `QrScannerPage` 包含兩個 tab：掃描（`_ScannerTab`）和產生（`_GeneratorTab`）。掃描功能依賴 `mobile_scanner` 套件，需要相機權限。由於手機原生相機已內建 QR Code 掃描，掃描 tab 缺乏實用價值，決定移除。

相關檔案：
- `lib/tools/qr_scanner/qr_scanner_page.dart` — 主頁面
- `lib/app.dart` — 路由定義
- `lib/models/tool_item.dart` — 工具清單
- `lib/l10n/app_en.arb`、`lib/l10n/app_zh.arb` — i18n 字串

## Goals / Non-Goals

**Goals:**

- 移除掃描 tab 及所有掃描相關程式碼
- 移除 `mobile_scanner` 依賴及相機權限宣告
- 將工具重新命名為「QR Code 產生器」（中文）/ 「QR Generator」（英文）
- 將檔案從 `qr_scanner/` 搬移至 `qr_generator/`，class 重新命名

**Non-Goals:**

- 不增加新的產生器功能（如儲存、分享 QR Code）
- 不重新設計產生器 UI

## Decisions

### 將檔案搬移至 qr_generator 目錄

將 `lib/tools/qr_scanner/qr_scanner_page.dart` 搬移至 `lib/tools/qr_generator/qr_generator_page.dart`，class 從 `QrScannerPage` 重新命名為 `QrGeneratorPage`。

**替代方案：** 原地重新命名檔案但不搬移目錄 — 不選擇此方案，因為目錄名稱應與功能一致。

### 移除 mobile_scanner 依賴

掃描功能是 `mobile_scanner` 的唯一使用者，移除掃描後此套件不再需要。同時移除 Android/iOS 的相機權限宣告。

**替代方案：** 保留依賴以備未來使用 — 不選擇此方案，遵循 YAGNI 原則，不需要的依賴不應保留。

### 移除 TabBar 改為單頁佈局

移除 `DefaultTabController` / `TabBar` / `TabBarView` 結構，直接在 `Scaffold.body` 中渲染產生器內容。

## Risks / Trade-offs

- [風險] 移除相機權限可能影響其他功能 → 檢查 `AndroidManifest.xml` 和 `Info.plist` 確認僅掃描使用相機
- [取捨] spec 目錄名稱 `tool-qr-scanner` 與新的 `tool-qr-generator` 不一致 → archive 時透過 delta spec RENAMED 處理
