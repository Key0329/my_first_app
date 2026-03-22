## 1. 計時器改用 Stopwatch 計算剩餘時間 — Countdown timer accuracy

- [x] 1.1 修復 Countdown timer accuracy 精度漂移：改用 Stopwatch 計算剩餘時間（`_TimerTabState` 新增 `_stopwatch` 欄位，`_startTimer` 用 `_totalDuration - _stopwatch.elapsed` 計算剩餘），處理暫停/繼續時記錄 `_pausedRemaining` 並重設 Stopwatch
- [x] 1.2 為計時器精度寫測試：驗證計時器狀態轉換正確

## 2. 計算機 BouncingButton 移除 onTap — Calculator button single event firing

- [x] 2.1 修復 Calculator button single event firing：移除 `_buildButton` 中 BouncingButton 的 `onTap` 參數，僅保留縮放動畫，FilledButton 的 `onPressed` 為唯一事件處理器
- [x] 2.2 為計算機按鈕單次觸發寫測試：驗證按下按鈕只觸發一次回呼

## 3. 搜尋功能使用 showSearch + SearchDelegate — Home page tool search

- [x] 3.1 實作 Home page tool search ToolSearchDelegate：建立 `lib/pages/tool_search_delegate.dart`，使用 SearchDelegate 實作，匹配工具名稱（中英文）和分類名稱，結果使用 ToolCard 顯示
- [x] 3.2 將首頁搜尋 Container 改為可點擊：在 `home_page.dart` 中將搜尋 Container 包裹 GestureDetector，點擊觸發 `showSearch()`
- [x] 3.3 為搜尋功能寫測試：驗證搜尋匹配、無結果顯示、點擊結果導航

## 4. 跨平台防護使用共用 PlatformCheck 工具 — Platform capability guard for hardware-dependent tools

- [x] 4.1 建立 Platform capability guard for hardware-dependent tools：建立 `lib/utils/platform_check.dart`，提供 `isMobilePlatform()` 函式和 `PlatformUnsupportedView` fallback widget
- [x] [P] 4.2 水平儀加入平台判斷：`level_page.dart` 在 `initState` 前檢查平台，不支援時顯示 PlatformUnsupportedView
- [x] [P] 4.3 指南針加入平台判斷：`compass_page.dart` 加入平台檢查
- [x] [P] 4.4 手電筒加入平台判斷：`flashlight_page.dart` 加入平台檢查
- [x] [P] 4.5 噪音計加入平台判斷：`noise_meter_page.dart` 加入平台檢查
- [x] [P] 4.6 色彩擷取加入平台判斷：`color_picker_page.dart` 加入平台檢查
- [x] [P] 4.7 螢幕尺規加入平台判斷：`screen_ruler_page.dart` 加入平台檢查
- [x] 4.8 為 Platform capability guard 寫測試：驗證 `isMobilePlatform()` 函式和 PlatformUnsupportedView 渲染

## 5. 驗證

- [x] 5.1 執行 `flutter analyze` 確認無靜態分析錯誤
- [x] 5.2 執行 `flutter test` 確認全部測試通過
