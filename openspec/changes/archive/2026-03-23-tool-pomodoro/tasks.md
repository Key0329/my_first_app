## 1. 素材與 i18n

- [x] [P] 1.1 準備白噪音音檔（rain.mp3、cafe.mp3、forest.mp3）放入 `assets/audio/`，更新 `pubspec.yaml` 的 assets 區段
- [x] [P] 1.2 在 `app_zh.arb` 和 `app_en.arb` 新增 pomodoro 相關 i18n 字串（internationalization support）

## 2. 核心邏輯

- [x] 2.1 建立 `lib/tools/pomodoro/pomodoro_timer.dart`，實作計時器架構（timer countdown、phase cycling、customizable durations）— 使用 ChangeNotifier + Timer.periodic
- [x] 2.2 實作專注統計持久化邏輯（focus statistics — increment on work completion、daily reset），使用 SharedPreferences

## 3. UI 實作

- [x] 3.1 建立 `lib/tools/pomodoro/pomodoro_page.dart`，實作 UI 佈局（pomodoro timer page）— 圓形倒數進度環 + 階段指示 + timer controls（start/pause/reset/skip）
- [x] 3.2 實作白噪音播放 UI（white noise playback — ChoiceChip 選擇器）
- [x] 3.3 實作設定區（customizable durations 滑桿）+ 統計區（focus statistics display）
- [x] 3.4 實作階段通知（phase completion notification — 音效 + 本地通知）

## 4. 工具註冊

- [x] 4.1 在 `tool_item.dart` 的 `allTools` 中新增 pomodoro 工具項目（tool registry integration），新增 design_tokens.dart gradient

## 5. 測試

- [x] [P] 5.1 撰寫 PomodoroTimer 的 unit test（timer countdown、phase cycling、customizable durations、focus statistics）
- [x] [P] 5.2 撰寫 pomodoro_page widget test（pomodoro timer page、timer controls、white noise playback）
