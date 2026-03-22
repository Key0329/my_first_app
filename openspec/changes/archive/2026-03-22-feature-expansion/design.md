## Context

工具箱 Pro 目前擁有 12+ 工具，採用 ImmersiveToolScaffold 架構搭配 Bento Grid 首頁。現有依賴已包含 `mobile_scanner`（用於 QR 產生器頁面的相機權限），但尚未有真正的掃描功能。計時器工具已有倒數計時功能但缺乏完成提醒。App 使用 `go_router` 進行路由管理、`shared_preferences` 進行本地儲存、`flutter_localizations` + `intl` 進行多語系支援。

## Goals / Non-Goals

**Goals:**

- 新增 3 個獨立工具頁面（QR 掃描、匯率換算、日期計算），遵循現有 ImmersiveToolScaffold 架構
- 為計時器完成事件加入音效播放與本地推播通知
- 所有新功能支援中英文雙語
- 匯率資料支援離線快取，確保無網路時仍可使用

**Non-Goals:**

- 不重新設計首頁佈局或導航架構
- 不實作 QR Code 產生功能（已有 tool-qr-scanner 處理）
- 不建立後端服務，僅使用免費第三方 API
- 不支援自訂通知鈴聲

## Decisions

### QR 掃描 UI 設計

利用現有 `mobile_scanner` 依賴實作即時相機掃描介面。掃描頁面採用 ImmersiveToolScaffold 架構，上方為相機預覽區域搭配掃描框動畫，下方為掃描結果顯示區。掃描成功後自動辨識結果類型（URL、純文字、WiFi 等），提供對應操作按鈕（開啟瀏覽器、複製到剪貼簿）。選擇此方案而非使用獨立掃描套件，是因為 `mobile_scanner` 已在專案中且支援 Android/iOS 雙平台。

### 匯率 API 選型

使用 `frankfurter.app` 免費 API 作為匯率資料來源。此 API 無需 API Key、無請求次數限制、回傳 JSON 格式簡潔。替代方案 `exchangerate.host` 近期已改為付費模式，故不採用。離線快取策略使用 `shared_preferences` 儲存最近一次成功取得的匯率資料與時間戳記，當網路不可用時自動使用快取資料並顯示「離線模式」提示。HTTP 請求使用 `http` 套件。

### 日期計算器功能範圍

提供三種計算模式：（1）兩日期間隔計算 — 輸入起始與結束日期，顯示相差天數、週數、月數；（2）加減天數 — 輸入基準日期與天數，計算目標日期；（3）工作日計算 — 計算兩日期間的工作日數（排除週末）。使用 Flutter 內建 `DateTime` 處理日期運算，無需額外依賴。日期選擇使用 Material `showDatePicker`。

### 計時器音效實作

使用 `audioplayers` 套件播放計時器完成音效。音效檔案使用內建短促提示音（bundled asset）。搭配 `flutter_local_notifications` 在計時器歸零時發送本地推播通知，確保 App 在背景時用戶也能收到提醒。選擇 `audioplayers` 而非 `just_audio` 是因為前者 API 更簡潔、專案無需串流播放功能。通知僅在 App 進入背景時觸發，前景時僅播放音效。

## Risks / Trade-offs

- **[匯率 API 不穩定]** → 實作離線快取機制作為降級方案，快取過期前（24 小時內）可正常使用
- **[相機權限被拒絕]** → 在 QR 掃描頁面加入權限請求流程與引導提示，若被拒絕則顯示手動輸入替代方案
- **[背景通知在 iOS 受限]** → 使用 `flutter_local_notifications` 的 scheduled notification 功能，在計時器啟動時預先排程通知時間
- **[新增 3 個依賴增加包體積]** → `audioplayers`、`flutter_local_notifications`、`http` 皆為輕量套件，預估增加 < 2MB
