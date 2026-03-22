## 1. 依賴安裝

- [x] [P] 1.1 新增 `in_app_review` 套件至 `pubspec.yaml` 並執行 `flutter pub get`

## 2. ReviewService 實作

- [x] [P] 2.1 建立 `lib/services/review_service.dart` 實作 In-app review prompt after tool usage threshold — 獨立 ReviewService 而非嵌入 AppSettings，使用累計工具使用次數（非不同工具數量）追蹤 tool_use_count，達到閾值 3 時觸發原生評分對話框，觸發後標記永不再觸發（review_prompted = true）
- [x] 2.2 在工具開啟流程中接入 ReviewService — 於 `home_page.dart` 的 `_openTool()` 中 `addRecentTool()` 之後呼叫 `ReviewService.instance.recordToolUseAndPrompt()`

## 3. 測試

- [x] 3.1 新增 `test/services/review_service_test.dart` — 驗證計數、閾值觸發、不重複觸發、跨重啟持久化

## 4. 驗證

- [x] 4.1 執行 `flutter analyze` 確認零 warning/error
- [x] 4.2 執行 `flutter test` 確認所有測試通過
