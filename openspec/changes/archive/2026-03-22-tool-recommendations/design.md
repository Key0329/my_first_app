## Context

所有 18 個工具頁面使用 `ImmersiveToolScaffold` 作為共用佈局（上方漸層 header + 下方圓角 body）。body 區域由各工具頁面自行填充內容。工具資料定義在 `allTools`（`tool_item.dart`），每個 `ToolItem` 有 `id`、`category`、`routePath` 等欄位。

## Goals / Non-Goals

**Goals:**

- 在工具頁面底部展示 1-2 個相關工具推薦
- 點擊推薦可直接導航到該工具
- 推薦邏輯基於靜態關聯圖譜（手動策展）

**Non-Goals:**

- 不做基於使用行為的動態推薦（留給 Phase 5 growth-engine）
- 不做 AI/ML 推薦
- 不在首頁加推薦區塊（此處只處理工具頁面內的推薦）

## Decisions

### 靜態關聯圖譜而非演算法推薦

定義 `Map<String, List<String>> toolRelations`，手動策展每個工具的 1-2 個推薦。這是最簡單、可控、無副作用的方式。

策展邏輯：
- 同場景關聯：計算機 → 單位換算、匯率 → 分帳
- 互補關聯：QR 產生 → QR 掃描、密碼產生器 → QR 產生（產生 QR 分享密碼）
- 同類別 fallback：找不到明確關聯時推薦同 category 的其他工具

### 在 ImmersiveToolScaffold 內建推薦列

在 `ImmersiveToolScaffold` 加入可選的 `toolId` 參數。若提供，在 body 底部自動渲染 `ToolRecommendationBar`。這樣所有工具頁面只需加一個參數即可啟用推薦，不需逐一修改 body 佈局。

### 推薦卡片使用 Chip 樣式

推薦卡片以水平排列的小型 Chip 呈現（工具 icon + 名稱），視覺輕量不搶占主要操作區域。點擊後透過 `context.push()` 導航。

## Risks / Trade-offs

- **[風險] 推薦列佔用 body 空間** → 使用固定高度（48dp）的緊湊 Chip 設計，不影響工具主要操作區
- **[取捨] 靜態策展需要手動維護** → 18 個工具的關聯只需定義一次，新增工具時更新圖譜即可
