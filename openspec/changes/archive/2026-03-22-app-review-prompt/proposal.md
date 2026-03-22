## Why

App Store / Google Play 的評分數量是 ASO 排名的核心因子，差異可達 2-3 倍曝光。目前 App 完全沒有任何引導用戶評分的機制。使用 `in_app_review` 套件可在用戶感受到 App 價值後（第 3 次使用工具），於自然的正向情緒高點觸發原生評分彈窗，最大化好評概率。

## What Changes

- 新增 `in_app_review` 套件依賴
- 新增 `ReviewService`，封裝評分觸發邏輯：追蹤累計使用工具次數，達到 3 次時請求原生評分對話框
- 在 `AppSettings.addRecentTool()` 流程中接入 `ReviewService`，每次使用工具時累加計數
- 使用 `SharedPreferences` 持久化已觸發狀態，確保每位用戶只觸發一次

## Capabilities

### New Capabilities

- `app-review-prompt`: 在用戶累計使用 3 個不同工具後，觸發原生 App Store / Google Play 評分對話框

### Modified Capabilities

（無）

## Impact

- 新增依賴：`in_app_review` 套件
- 新增檔案：`lib/services/review_service.dart`
- 受影響程式碼：`lib/services/settings_service.dart`（addRecentTool 流程中接入 ReviewService）、`pubspec.yaml`
- 受影響測試：需新增 `test/services/review_service_test.dart`
