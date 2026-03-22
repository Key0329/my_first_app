## Why

目前 App 已具備 12+ 工具，但用戶最常反映缺少幾項核心實用功能：QR Code 掃描、匯率換算、日期計算。此外，計時器完成時缺乏音效與通知提醒，導致用戶必須盯著螢幕等待。補齊這些功能缺口將大幅提升 App 的實用性與日常使用頻率。

## What Changes

1. **QR Code 掃描功能** — 新增 QR Code 掃描與解碼工具，利用現有 `mobile_scanner` 依賴，讓用戶可直接掃描 QR Code 並處理結果（開啟連結、複製文字等）
2. **計時器完成音效與本地通知** — 修改現有計時器工具，在倒數計時歸零時播放音效並發送本地推播通知，即使 App 在背景也能提醒用戶
3. **匯率即時換算工具** — 新增匯率換算工具，串接免費匯率 API，支援多幣別即時換算與離線快取
4. **日期計算器** — 新增日期計算工具，支援兩日期間隔計算、N 天後日期推算、工作日計算

## Capabilities

### New Capabilities

- `tool-qr-scanner-live`: QR Code 即時掃描與解碼，包含相機預覽、掃描結果處理（開啟連結、複製文字）
- `tool-currency-converter`: 匯率即時換算工具，串接免費 API 取得匯率、支援多幣別切換與離線快取
- `tool-date-calculator`: 日期計算工具，支援兩日期間隔、加減天數、工作日計算

### Modified Capabilities

- `tool-stopwatch-timer`: 新增計時器完成音效播放與背景本地通知功能

## Impact

- **新增依賴**：`audioplayers`（音效播放）、`flutter_local_notifications`（本地通知）、`http`（API 請求）
- **受影響的程式碼**：
  - `lib/tools/stopwatch_timer/` — 修改計時器頁面，加入音效與通知
  - `lib/tools/` — 新增 `qr_scanner_live/`、`currency_converter/`、`date_calculator/` 目錄
  - `lib/models/tool_item.dart` — 註冊新工具
  - `lib/app.dart` — 新增路由
  - `lib/l10n/` — 新增多語系字串
  - `pubspec.yaml` — 新增依賴套件
- **受影響的 specs**：3 個新 spec + 1 個 delta spec
