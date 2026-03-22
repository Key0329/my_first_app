## Summary

全面補強程式碼品質：7 個工具補測試、無障礙 Semantics、Design Token 補全、確認對話框/空狀態/錯誤狀態統一、NumberPicker controller dispose 修復。

## Motivation

QA 審查發現以下品質問題亟需解決：

- 15 個工具中有 7 個完全沒有單元測試，純邏輯函數（PPI 計算、角度轉方位、dB 到顏色映射等）缺乏驗證
- 無障礙支援不足：計算機按鈕、噪音計數值、指南針方位、量角器角度等互動元素缺少 Semantics 標註
- Design Token 系統不完整：缺少 Motion Token（動畫時長常數）與 Opacity Token
- 破壞性操作（計算機清除歷史、碼錶重設、隨機轉盤刪除選項）缺少確認對話框
- 錯誤狀態顯示不統一，各工具各自實作
- NumberPicker controller 未在 dispose 中正確釋放，存在記憶體洩漏風險

## Proposed Solution

1. **補測試**：為 7 個缺少測試的工具抽出可測試的純邏輯函數並撰寫單元測試
2. **無障礙 Semantics**：在關鍵互動元素上加入 Semantics widget，提供 label、value、hint
3. **Design Token 補全**：在 `DT` 類中新增 Motion Token 與 Opacity Token 常數
4. **確認對話框統一**：建立共用確認對話框元件，套用於所有破壞性操作
5. **錯誤狀態統一**：建立標準錯誤狀態顯示模式，使用 `colorScheme.error` 搭配錯誤圖示
6. **Controller 生命週期修復**：修正 NumberPicker 等元件的 controller dispose 問題

## Capabilities

### New Capabilities

- `test-coverage`：測試覆蓋率要求 — 定義各工具必須具備的單元測試範圍與純邏輯函數測試標準
- `accessibility-support`：無障礙支援需求 — 定義 Semantics 標註標準與無障礙互動要求

### Modified Capabilities

- `app-animations`：新增 Motion Token（durationFast / durationMedium / durationSlow）常數定義
- `immersive-tool-theme`：新增錯誤狀態統一顯示要求，使用 colorScheme.error 色彩與錯誤圖示

## Impact

- 受影響程式碼：
  - `lib/theme/design_tokens.dart` — 新增 Motion / Opacity Token
  - `lib/tools/compass/` — 補測試、Semantics
  - `lib/tools/color_picker/` — 補測試、Semantics
  - `lib/tools/flashlight/` — 補測試
  - `lib/tools/level/` — 補測試
  - `lib/tools/noise_meter/` — 補測試、Semantics
  - `lib/tools/protractor/` — 補測試、Semantics
  - `lib/tools/screen_ruler/` — 補測試
  - `lib/tools/calculator/` — Semantics、確認對話框
  - `lib/tools/stopwatch_timer/` — 確認對話框
  - `lib/tools/random_wheel/` — 確認對話框、NumberPicker dispose 修復
  - `lib/widgets/immersive_tool_scaffold.dart` — 錯誤狀態統一
- 新增測試檔案：`test/tools/` 下新增 7 個測試檔
- 無新增外部依賴
