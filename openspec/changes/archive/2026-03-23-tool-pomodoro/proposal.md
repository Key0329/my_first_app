## Why

工具箱缺少生產力工具，番茄鐘是全球最受歡迎的時間管理方法之一。結合白噪音播放功能，能打造「專注套裝」體驗，大幅提升工具箱對學生和上班族的吸引力與使用頻率。專案已有 `audioplayers` 套件，可直接復用。

## What Changes

- 新增「番茄鐘」工具頁面，提供可自訂的番茄鐘計時功能
- 支援自訂工作/休息時間（預設 25/5 分鐘）
- 自動循環切換工作與休息階段，附帶本地通知提醒
- 內建白噪音播放（雨聲、咖啡廳、森林等音效）
- 提供專注統計（今日完成番茄數、累計專注時間）
- 在 tool registry 中註冊，歸類為「生活」
- 新增完整 i18n 字串

## Capabilities

### New Capabilities

- `tool-pomodoro`: 番茄鐘計時工具，包含自訂工作/休息時間、白噪音播放、專注統計

### Modified Capabilities

（無）

## Impact

- 受影響程式碼：
  - `lib/tools/pomodoro/pomodoro_page.dart` — 新增頁面（新檔案）
  - `lib/tools/pomodoro/pomodoro_service.dart` — 番茄鐘計時邏輯（新檔案）
  - `lib/models/tool_item.dart` — 新增 pomodoro 工具註冊
  - `lib/theme/design_tokens.dart` — 新增 pomodoro 漸層色
  - `lib/l10n/app_zh.arb` / `app_en.arb` — 新增 i18n 字串
  - `test/tools/pomodoro_test.dart` — 新增測試（新檔案）
- 依賴：復用現有 `audioplayers`，白噪音音檔放在 `assets/audio/`
