## 1. `ToolItem` 加入 `pageBuilder` 欄位

- [x] 1.1 [P] 修改 `ToolItem` class 實現 `ToolItem` 加入 `pageBuilder` 欄位，型別為 `Widget Function()`，讓 ToolItem carries pageBuilder。將 import 集中到 `tool_item.dart`，import 所有 18 個工具頁面，更新 `allTools` 列表中每個 ToolItem 加入對應的 pageBuilder（如 `() => const CalculatorPage()`），確保 pageBuilder is lazy 只在呼叫時建構

## 2. 路由從 `allTools` 自動生成

- [x] 2.1 修改 `app.dart` 實現路由從 `allTools` 自動生成，tool routes auto-generated from allTools — 移除 18 個工具頁面 import，將手動 GoRoute 替換為 `allTools.map()` 自動生成路由，實現 single-point tool registration。同時更新 routes for new tools 的方式為自動生成

## 3. 驗證

- [x] 3.1 [P] 執行 `flutter analyze` 確認零 warning/error
- [x] 3.2 [P] 執行 `flutter test` 確認所有既有測試通過
