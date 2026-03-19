## Context

目前 QR Code 產生器（`_GeneratorTab`）在使用者輸入文字並按下「產生 QR Code」後，僅顯示一個固定的 `Icons.qr_code_2` Material icon 作為 placeholder。程式碼中留有 TODO 註解標示此處尚未實作。spec 明確要求「a QR Code encoding the input text SHALL be displayed」，但當前實作不符合此規格。

## Goals / Non-Goals

**Goals:**

- 使 QR Code 產生器能根據使用者輸入的文字渲染出對應的 QR Code 圖像
- 保持現有 UI 佈局與互動流程不變

**Non-Goals:**

- 不處理 QR Code 圖片儲存/分享功能（未來再做）
- 不變更掃描功能（`_ScannerTab`）
- 不加入 QR Code 樣式自訂（顏色、logo 嵌入等）

## Decisions

### 使用 qr_flutter 套件渲染 QR Code

選擇 `qr_flutter` 套件作為 QR Code 渲染方案。

**替代方案考量：**
- `pretty_qr_code`：支援更多樣式自訂，但 API 較複雜，目前不需要進階樣式
- 自行用 `CustomPainter` 實作：工作量大，無必要性

**選擇原因：** `qr_flutter` 是純 Dart 實作、零原生依賴、API 最簡單（一個 `QrImageView` widget 即可）、Flutter 社群廣泛使用。

### 替換 placeholder 為 QrImageView widget

將 `_GeneratorTab` build 方法中第 399-426 行的 placeholder `Container`（包含 `Icons.qr_code_2`）替換為 `QrImageView(data: _generatedText!)`，保持外層 Container 的白色背景與圓角樣式。

## Risks / Trade-offs

- [風險] `qr_flutter` 套件未來可能停止維護 → 該套件為純 Dart 實作且 API 穩定，即使停止維護也能繼續使用；如有需要可輕易替換為其他方案
- [取捨] 不做輸入長度驗證 → QR Code 有內容長度上限，但 `qr_flutter` 會自動處理錯誤容量的情況，目前不需額外處理
