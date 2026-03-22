## 1. 基礎設施

- [x] [P] 1.1 建立 `lib/widgets/share_card_generator.dart` — 實作 Share card image generation，使用 RepaintBoundary + toImage 截取 Widget 為 PNG，儲存至暫存目錄回傳 XFile
- [x] [P] 1.2 建立 `lib/widgets/share_card_template.dart` — 實作 Branded share card template（通用 ShareCardTemplate widget），漸層邊框 + 工具名稱 + 結果 Widget + 「Spectra 工具箱」水印

## 2. Tool-specific share cards 整合（圖片存到暫存目錄後透過 ShareButton 分享）

- [x] [P] 2.1 修改 `split_bill_page.dart` — 分帳分享改用 Tool-specific share cards 的 ShareCardTemplate 生成卡片圖片
- [x] [P] 2.2 修改 `bmi_calculator_page.dart` — BMI 分享改用 ShareCardTemplate 生成卡片圖片
- [x] [P] 2.3 修改 `random_wheel_page.dart` — 轉盤結果分享改用 ShareCardTemplate 生成卡片圖片
- [x] [P] 2.4 修改 `date_calculator_page.dart` — 日期計算分享改用 ShareCardTemplate 生成卡片圖片

## 3. 驗證

- [x] 3.1 執行 `flutter analyze` 確認零 warning/error
- [x] 3.2 執行 `flutter test` 確認所有測試通過
