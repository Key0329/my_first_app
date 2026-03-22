## Why

PM 分析指出，用戶完成一個工具後回到首頁，沒有任何引導去嘗試其他工具，導致人均工具使用數僅 1.5 個。在工具結果頁底部顯示「你可能也需要」推薦卡片，可建立工具間的關聯性，預估將人均使用數從 1.5 提升至 3+，同時提升用戶對 App 多元工具的認知。

## What Changes

- 建立工具關聯圖譜（`tool_relations.dart`），定義每個工具的推薦關聯
- 新增 `ToolRecommendationBar` widget，在 `ImmersiveToolScaffold` 的 body 底部顯示 1-2 個相關工具推薦
- `ImmersiveToolScaffold` 新增可選的 `toolId` 參數，傳入後自動渲染推薦列

## Capabilities

### New Capabilities

- `tool-recommendations`: 工具完成後顯示相關工具推薦卡片，引導用戶探索更多工具

### Modified Capabilities

（無）

## Impact

- 新增檔案：
  - `lib/models/tool_relations.dart` — 工具關聯圖譜
  - `lib/widgets/tool_recommendation_bar.dart` — 推薦 UI 元件
- 受影響程式碼：
  - `lib/widgets/immersive_tool_scaffold.dart` — 新增 `toolId` 參數與推薦列渲染
- 受影響測試：需新增關聯圖譜測試與 widget 測試
