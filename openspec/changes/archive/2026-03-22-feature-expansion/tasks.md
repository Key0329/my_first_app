## 1. 專案設定與依賴安裝

- [x] [P] 1.1 在 `pubspec.yaml` 新增 `audioplayers`、`flutter_local_notifications`、`http` 依賴並執行 `flutter pub get`
- [x] [P] 1.2 新增音效資源檔案至 `assets/sounds/` 目錄並在 `pubspec.yaml` 中註冊 assets
- [x] [P] 1.3 設定 Android/iOS 平台本地通知權限設定檔（AndroidManifest.xml、Info.plist）

## 2. QR Code 即時掃描工具（QR 掃描 UI 設計）

- [x] 2.1 建立 `lib/tools/qr_scanner_live/qr_scanner_live_page.dart`，實作 Camera permission handling — 開啟頁面時請求相機權限，權限被拒絕時顯示引導訊息與系統設定按鈕
- [x] 2.2 實作 QR Code live scanning — 使用 `mobile_scanner` 顯示即時相機預覽與掃描框動畫，自動偵測並解碼 QR Code
- [x] 2.3 實作 QR scan result handling — 自動辨識掃描結果類型（URL、純文字），提供「開啟瀏覽器」與「複製到剪貼簿」操作按鈕
- [x] 2.4 在 `lib/l10n/app_en.arb` 與 `lib/l10n/app_zh.arb` 新增 QR 掃描工具多語系字串

## 3. 匯率即時換算工具（匯率 API 選型）

- [x] 3.1 建立 `lib/tools/currency_converter/currency_api.dart`，實作 Currency conversion with live rates — 串接 `frankfurter.app` API 取得即時匯率資料
- [x] 3.2 實作 Offline cache for exchange rates — 使用 `shared_preferences` 快取匯率資料與時間戳記，無網路時顯示離線模式指示
- [x] 3.3 建立 `lib/tools/currency_converter/currency_converter_page.dart`，實作匯率換算 UI 含幣別選擇器、金額輸入與即時換算結果顯示
- [x] 3.4 實作 Currency swap — 新增幣別交換按鈕，點擊後互換來源與目標幣別並即時更新結果
- [x] 3.5 在 `lib/l10n/app_en.arb` 與 `lib/l10n/app_zh.arb` 新增匯率換算工具多語系字串

## 4. 日期計算器工具（日期計算器功能範圍）

- [x] 4.1 建立 `lib/tools/date_calculator/date_calculator_page.dart`，實作三種計算模式的 Tab 切換 UI
- [x] 4.2 實作 Date interval calculation — 兩日期間隔計算，使用 `showDatePicker` 選擇日期，顯示天數、週數、月數差異
- [x] 4.3 實作 Add or subtract days from date — 輸入基準日期與天數，計算並顯示目標日期
- [x] 4.4 實作 Business days calculation — 計算兩日期間排除週末的工作日數
- [x] 4.5 在 `lib/l10n/app_en.arb` 與 `lib/l10n/app_zh.arb` 新增日期計算器多語系字串

## 5. 計時器音效與通知（計時器音效實作）

- [x] 5.1 修改 `lib/tools/stopwatch_timer/stopwatch_timer_page.dart`，在 Countdown timer 歸零時播放音效 — 使用 `audioplayers` 播放 bundled asset 提示音
- [x] 5.2 實作 Timer notification scheduling — 啟動倒數時透過 `flutter_local_notifications` 預先排程通知，取消計時器時同步取消排程通知

## 6. 路由與工具註冊

- [x] [P] 6.1 在 `lib/models/tool_item.dart` 註冊 QR 掃描、匯率換算、日期計算三個新工具項目
- [x] [P] 6.2 在 `lib/app.dart` 新增三個工具頁面的 `go_router` 路由定義

## 7. 測試

- [x] [P] 7.1 撰寫 QR 掃描工具 widget 測試（`test/tools/qr_scanner_live_test.dart`）
- [x] [P] 7.2 撰寫匯率換算工具單元測試與 widget 測試（`test/tools/currency_converter_test.dart`）
- [x] [P] 7.3 撰寫日期計算器單元測試（`test/tools/date_calculator_test.dart`）
- [x] [P] 7.4 撰寫計時器音效與通知功能測試（`test/tools/stopwatch_timer_notification_test.dart`）
