## 1. API 與快取層增強

- [x] 1.1 [P] 修改 `currency_api.dart` 實現 API timeout 設定（API request timeout）— http.get 加入 10 秒 timeout，timeout 時拋出 CurrencyApiException。這同時強化 currency conversion with live rates 的網路健壯性
- [x] 1.2 [P] 新增 ARB key（zh + en）：多幣別模式標籤、快取過期警告文字、timeout 錯誤訊息。執行 `flutter gen-l10n`

## 2. UI 增強

- [x] 2.1 修改 `currency_converter_page.dart` 實現常用幣別置頂排序 — favorite currencies pinned at top（TWD、USD、JPY、EUR），幣別選擇器分兩段（置頂 + 分隔線 + 字母排序）
- [x] 2.2 修改 `currency_converter_page.dart` 實現快取過期警告機制 — cache expiry warning，快取超過 24h 時顯示 amber warning + refresh 按鈕
- [x] 2.3 修改 `currency_converter_page.dart` 新增 multi-currency comparison mode — 一對多換算模式，SegmentedButton 切換，多目標幣別同時顯示換算結果

## 3. 驗證

- [x] 3.1 [P] 執行 `flutter analyze` 確認零 warning/error
- [x] 3.2 [P] 執行 `flutter test` 確認所有測試通過
