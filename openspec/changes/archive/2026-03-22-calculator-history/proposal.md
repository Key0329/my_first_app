## Why

目前計算機的歷史紀錄（`_history`）是 in-memory 的 `List<CalculationEntry>`，App 關閉後所有紀錄消失。使用者算完後無法回溯之前的計算結果，這是計算機工具最常被反映的缺失。持久化歷史紀錄可減少重複計算的摩擦，提升計算機工具的留存價值。

## What Changes

- `CalculationEntry` 新增 JSON 序列化方法（`toJson` / `fromJson`）
- 新增 `CalculatorHistoryService`，使用 `SharedPreferences` 持久化歷史紀錄，上限 100 筆
- `calculator_page.dart` 改用 `CalculatorHistoryService` 管理歷史，啟動時載入、計算後儲存
- 歷史列表支援搜尋功能（根據 expression 或 result 篩選）

## Capabilities

### New Capabilities

- `calculator-history`: 計算機歷史紀錄的持久化儲存、上限管理與搜尋功能

### Modified Capabilities

（無）

## Impact

- 受影響程式碼：
  - `lib/tools/calculator/calculator_logic.dart` — `CalculationEntry` 新增序列化
  - `lib/tools/calculator/calculator_page.dart` — 歷史管理改用 service、新增搜尋 UI
- 新增檔案：
  - `lib/tools/calculator/calculator_history_service.dart`
- 受影響測試：需新增歷史持久化測試
