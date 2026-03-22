## 1. 資料模型序列化

- [x] [P] 1.1 為 `CalculationEntry` 新增 `toJson()` / `fromJson()` 方法 — 支援 JSON 序列化以實現 Persistent calculator history

## 2. 歷史持久化 Service（獨立 CalculatorHistoryService 封裝持久化邏輯）

- [x] 2.1 建立 `lib/tools/calculator/calculator_history_service.dart` — 使用 JSON 字串列表儲存歷史至 SharedPreferences，封裝 load/save/add/clear 操作，上限 100 筆

## 3. 頁面整合

- [x] 3.1 修改 `calculator_page.dart` 改用 `CalculatorHistoryService` 管理歷史 — initState 載入、計算後儲存、清除時同步清除持久化資料
- [x] 3.2 在歷史列表上方新增搜尋欄位，實作 Calculator history search — 搜尋使用本地篩選而非索引，即時篩選 expression/result（case-insensitive）

## 4. 測試

- [x] [P] 4.1 新增 `CalculationEntry` 序列化測試 — 驗證 toJson/fromJson 往返一致性
- [x] [P] 4.2 新增 `CalculatorHistoryService` 單元測試 — 驗證持久化載入/儲存、100 筆上限、清除功能

## 5. 驗證

- [x] 5.1 執行 `flutter analyze` 確認零 warning/error
- [x] 5.2 執行 `flutter test` 確認所有測試通過
