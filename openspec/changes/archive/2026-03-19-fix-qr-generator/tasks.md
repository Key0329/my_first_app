## 1. 依賴安裝

- [x] 1.1 新增 `qr_flutter` 套件至 `pubspec.yaml` 並執行 `flutter pub get`（使用 qr_flutter 套件渲染 QR Code）

## 2. 核心實作

- [x] 2.1 替換 placeholder 為 QrImageView widget — 將 `_GeneratorTab` 中的 `Icons.qr_code_2` placeholder 替換為 `QrImageView(data: _generatedText!)`，實現 QR Code generation 需求
- [x] 2.2 移除 TODO 註解（`// TODO: 使用 qr_flutter 或類似套件產生實際 QR Code 圖片`）

## 3. 測試驗證

- [x] [P] 3.1 撰寫 widget test 驗證 QR Code generation — 不同輸入內容產生不同 QR Code 圖像
- [x] [P] 3.2 執行 `flutter analyze` 確保無靜態分析警告
