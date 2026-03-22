## Problem

App 中存在 4 個影響核心體驗和穩定性的問題：

1. **計時器精度漂移**：`_TimerTabState._startTimer()` 使用 `Timer.periodic(100ms)` 每次減去固定 100ms，但 Timer.periodic 的實際觸發間隔不保證精確，長時間運行後產生累積誤差
2. **計算機按鈕雙重觸發**：計算機按鈕同時被 `BouncingButton(onTap: onPressed)` 和 `FilledButton(onPressed: onPressed)` 包裹，每次按下觸發兩次回呼，導致重複輸入
3. **搜尋按鈕是裝飾品**：首頁搜尋圖示是一個純 `Container`，沒有點擊事件，用戶點擊無反應，損害信任
4. **跨平台崩潰**：水平儀、指南針使用 `sensors_plus`，手電筒使用 `torch_light`，這些套件在 Web/桌面平台（macOS/Linux/Windows）上不可用，會拋出 `MissingPluginException` 或直接崩潰

## Root Cause

1. 計時器使用固定累減而非基於實際時間戳計算剩餘時間
2. Bento 風格改造時 BouncingButton 包裹了整個 FilledButton（含其 onPressed），但兩者都綁定了同一個回呼
3. 搜尋按鈕 UI 在首頁重設計時建立，但搜尋邏輯從未實作
4. 工具頁面未加入平台判斷，假設所有平台都支援硬體感測器

## Proposed Solution

1. **計時器**：改用 `Stopwatch` 記錄已經過時間，Timer.periodic 僅用於觸發 UI 更新，剩餘時間 = 總時間 - Stopwatch.elapsed
2. **計算機**：移除 BouncingButton 的 `onTap`，僅保留 `onTapDown`/`onTapUp` 的縮放動畫，讓 FilledButton 的 `onPressed` 單獨處理事件
3. **搜尋**：實作即時搜尋功能，點擊搜尋圖示展開 TextField overlay，輸入時即時過濾工具列表
4. **跨平台**：在使用感測器/硬體的工具頁面加入平台判斷（`kIsWeb` + `Platform.isAndroid/isIOS`），不支援時顯示友善的 fallback UI

## Success Criteria

1. 計時器設定 10 分鐘後實際結束時間誤差 < 1 秒
2. 計算機按 1 次按鈕只觸發 1 次輸入
3. 搜尋按鈕可點擊，輸入文字可即時過濾工具
4. 在 Web/macOS 上開啟水平儀、指南針、手電筒不會崩潰，顯示「此功能需要行動裝置」提示

## Impact

- 影響的程式碼：
  - `lib/tools/stopwatch_timer/stopwatch_timer_page.dart` — 計時器精度修復
  - `lib/tools/calculator/calculator_page.dart` — 移除雙重觸發
  - `lib/pages/home_page.dart` — 搜尋功能實作
  - `lib/tools/level/level_page.dart` — 平台判斷
  - `lib/tools/compass/compass_page.dart` — 平台判斷
  - `lib/tools/flashlight/flashlight_page.dart` — 平台判斷
  - `lib/tools/noise_meter/noise_meter_page.dart` — 平台判斷（麥克風）
  - `lib/tools/color_picker/color_picker_page.dart` — 平台判斷（相機）
  - `lib/tools/screen_ruler/screen_ruler_page.dart` — 平台判斷（校準依賴觸控）
