## Context

工具箱已有 19 個工具，透過 tool-registry 自動註冊路由。專案已整合 `audioplayers` 與 `flutter_local_notifications`，碼錶工具的 `TimerNotificationService` 提供了通知與音效的模式可參考。

番茄鐘需要獨立的計時邏輯（與碼錶不同：自動循環工作/休息、階段切換），以及白噪音的持續播放功能。

## Goals / Non-Goals

**Goals:**

- 提供標準番茄鐘計時（預設 25 分鐘工作 / 5 分鐘短休息 / 15 分鐘長休息）
- 支援自訂工作與休息時間長度
- 工作/休息自動切換，每 4 個番茄後進入長休息
- 階段結束時播放提示音 + 本地通知
- 內建 3 種白噪音（雨聲、咖啡廳、森林），可在計時中播放/停止
- 今日專注統計（完成番茄數 + 累計分鐘數），持久化到 SharedPreferences
- 完整 i18n + widget test

**Non-Goals:**

- 不做跨日歷史趨勢圖表
- 不做任務管理（標記正在做什麼任務）
- 不做雲端同步
- 不做自訂音效上傳
- 不做背景持續計時（頁面退出即暫停）

## Decisions

### 計時器架構

使用 `dart:async` 的 `Timer.periodic` 每秒更新，搭配 `ChangeNotifier` 模式讓 UI 響應變化。邏輯封裝在 `PomodoroTimer` 類別中。

**理由**：番茄鐘需要精確的秒級倒數和狀態管理（工作中/休息中/暫停/閒置），`ChangeNotifier` 與 Flutter widget 體系契合。

### 白噪音播放

使用現有的 `audioplayers` 套件。白噪音音檔（3 個 .mp3）放在 `assets/audio/` 目錄，透過 `AudioPlayer` 循環播放（`setReleaseMode(ReleaseMode.loop)`）。

白噪音播放與番茄鐘計時獨立 — 使用者可在不啟動番茄鐘的情況下播放白噪音，反之亦然。

**理由**：復用現有套件，零新增依賴。循環播放和獨立控制提供最佳 UX。

### 專注統計持久化

使用 SharedPreferences 存儲：
- `pomodoro_today_date`：今日日期字串（YYYY-MM-DD）
- `pomodoro_today_count`：今日完成番茄數
- `pomodoro_today_minutes`：今日專注分鐘數

每次完成一個番茄時更新。若日期已過期則歸零重計。

**理由**：簡單的每日統計不需要 SQLite，SharedPreferences 足夠。

### 階段通知

復用 `TimerNotificationService` 的通知初始化流程，但番茄鐘使用獨立的 notification ID 和音效。

**理由**：避免與碼錶的通知衝突。

### UI 佈局

- 頂部：圓形倒數進度環（顯示剩餘時間）
- 中部：階段指示（第 N 個番茄 / 工作中 / 休息中）
- 控制按鈕：開始、暫停、重設、跳過當前階段
- 底部：白噪音選擇器（3 個 ChoiceChip）+ 音量滑桿
- 統計區：今日番茄數 + 累計分鐘
- 設定區：工作/休息時長滑桿

## Risks / Trade-offs

- [音檔體積] 3 個白噪音 MP3 約 300KB-1MB 每個，會增加 APK 大小 → 可接受範圍，未來可改用網路串流
- [背景限制] 頁面退出時番茄鐘暫停 → 明確標示為 Non-Goal，避免複雜的背景服務邏輯
- [AudioPlayer 衝突] 若碼錶的提示音與白噪音同時存在，需使用獨立的 AudioPlayer instance → 設計中已使用獨立 player
