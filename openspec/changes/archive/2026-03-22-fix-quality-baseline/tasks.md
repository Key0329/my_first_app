## 1. 匯率 fallback 改為拋出 ArgumentError（Currency conversion with live rates）

- [x] [P] 1.1 修正 Currency conversion with live rates 的 fallback 改為拋出 ArgumentError — 將 `CurrencyApi.convert()` 中 `rates[fromCurrency] ?? 1.0` 和 `rates[toCurrency] ?? 1.0` 改為明確檢查 key 是否存在，不存在時拋出 `ArgumentError`
- [x] [P] 1.2 更新 `currency_converter_page.dart` UI 層 try-catch — 捕捉 `ArgumentError` 並顯示「不支援的幣別」錯誤訊息
- [x] 1.3 更新匯率換算相關測試 — 新增 Unknown currency selected 測試場景，驗證 `ArgumentError` 拋出行為

## 2. dart:io 改用 Foundation 的 defaultTargetPlatform

- [x] [P] 2.1 修正 `timer_notification_service.dart` — 移除 `import 'dart:io'`，改用 `foundation.dart` 的 `defaultTargetPlatform` 和 `kIsWeb` 做平台判斷
- [x] 2.2 更新 timer notification 相關測試 — 確保現有測試在移除 dart:io 後仍通過

## 3. toolColor 統一從 ToolItem.color 取值

- [x] [P] 3.1 統一所有工具頁面的 toolColor — 修正 calculator、compass、color_picker、stopwatch_timer、flashlight、noise_meter、qr_generator、password_generator、level、protractor、unit_converter 共 11 個頁面的硬編碼 toolColor，改從 ToolItem.color 取值
- [x] 3.2 驗證首頁卡片漸層色與工具頁面 header 色彩一致

## 4. OverlayEntry 在 dispose 中移除

- [x] [P] 4.1 在 `_RandomWheelPageState.dispose()` 中加入 OverlayEntry 清理 — 確保 `_overlayEntry?.remove(); _overlayEntry = null;`

## 5. 暗色模式色值調整（Dark mode deep indigo surface colors）

- [x] [P] 5.1 修正 Dark mode deep indigo surface colors 的 darkSubtitle 色值至 #9999BB — 確保對比度達 WCAG AA 4.5:1
- [x] [P] 5.2 調整 `design_tokens.dart` 中 darkNavInactive 色值至 #8888AA — 確保對比度達 WCAG AA 4.5:1
- [x] 5.3 更新 design_tokens 相關測試 — 驗證新色值正確

## 6. 驗證

- [x] 6.1 執行 `flutter analyze` 確認零 warning/error
- [x] 6.2 執行 `flutter test` 確認所有測試通過
