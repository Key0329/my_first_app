## 1. 工具關聯圖譜（Tool relation graph — 靜態關聯圖譜而非演算法推薦）

- [x] [P] 1.1 建立 `lib/models/tool_relations.dart` — 定義 `Map<String, List<String>> toolRelations`，為全部 18 個工具策展 1-2 個推薦關聯，無明確關聯時 fallback 至同 category

## 2. 推薦 UI 元件（Recommendation bar in tool pages — 推薦卡片使用 Chip 樣式）

- [x] [P] 2.1 建立 `lib/widgets/tool_recommendation_bar.dart` — 接收 `toolId`，從 `toolRelations` 取得推薦列表，渲染水平排列的 Chip（icon + 名稱），點擊 `context.push()` 導航

## 3. Scaffold 整合（在 ImmersiveToolScaffold 內建推薦列）

- [x] 3.1 修改 `ImmersiveToolScaffold` — 新增可選 `toolId` 參數，有值時在 body 底部渲染 `ToolRecommendationBar`
- [x] 3.2 為全部 18 個工具頁面加入 `toolId` 參數至 `ImmersiveToolScaffold`

## 4. 測試

- [x] [P] 4.1 新增 `test/models/tool_relations_test.dart` — 驗證 Tool relation graph 所有工具都有推薦、推薦的 ID 都存在於 allTools
- [x] [P] 4.2 新增 `test/widgets/tool_recommendation_bar_test.dart` — 驗證 Recommendation bar in tool pages 的 Chip 渲染與導航

## 5. 驗證

- [x] 5.1 執行 `flutter analyze` 確認零 warning/error
- [x] 5.2 執行 `flutter test` 確認所有測試通過
