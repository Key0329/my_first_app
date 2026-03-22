## Context

`AppSettings.addRecentTool()` 在用戶每次進入工具頁面時被呼叫（`home_page.dart` 的 `_openTool`），內部使用 `SharedPreferences` 持久化最近使用列表。此處是接入評分邏輯的最佳切入點，因為它代表「用戶實際使用了一個工具」這個有意義的事件。

`in_app_review` 套件提供 `InAppReview.instance.requestReview()` 方法，會調用 iOS 的 `SKStoreReviewController` 和 Android 的 `ReviewManager API`。平台層會自行控制顯示頻率（iOS 每年最多 3 次、Android 有內部頻率限制），因此我們只需在 App 層控制「是否應該嘗試觸發」即可。

## Goals / Non-Goals

**Goals:**

- 在用戶感受到 App 價值後自然觸發評分（第 3 次工具使用）
- 每位用戶只嘗試觸發一次（避免騷擾）
- 獨立的 `ReviewService` 封裝，不侵入現有 `AppSettings` 邏輯

**Non-Goals:**

- 不自建評分 UI（使用原生彈窗）
- 不做 A/B 測試不同觸發時機（後續可透過 Remote Config 調整）
- 不處理用戶拒絕評分後的重試邏輯（平台層自行處理）

## Decisions

### 獨立 ReviewService 而非嵌入 AppSettings

建立獨立的 `ReviewService` singleton，持有自己的 `SharedPreferences` key（`review_prompted`、`tool_use_count`）。在 `addRecentTool()` 呼叫後由呼叫端觸發 `ReviewService.checkAndPrompt()`。

**替代方案**：直接在 `AppSettings.addRecentTool()` 中呼叫 → 違反單一職責，且 `AppSettings` 不應依賴 `in_app_review`。

### 使用累計工具使用次數（非不同工具數量）

追蹤 `tool_use_count`（每次 `addRecentTool` +1），達到 3 時觸發。這比追蹤「不同工具數量」更簡單，且用戶連續使用同一工具 3 次也代表他們覺得 App 有價值。

### 觸發後標記永不再觸發

`review_prompted = true` 後永不再嘗試。平台的原生 API 本身有頻率控制，我們在 App 層只做「是否曾經嘗試過」的 gate。

## Risks / Trade-offs

- **[風險] `requestReview()` 不保證顯示** → 這是平台的設計，我們無法控制。但只要呼叫了，平台會在適當時機顯示。不需處理。
- **[風險] 測試環境中 `in_app_review` 無法真實觸發** → 測試中 mock `InAppReview.instance`，只驗證邏輯層（計數 + 觸發條件）。
- **[取捨] 3 次可能太早或太晚** → 選擇 3 作為平衡點：太少（1-2）用戶還沒感受到價值，太多（5+）會錯過最佳窗口。可透過常數輕鬆調整。
