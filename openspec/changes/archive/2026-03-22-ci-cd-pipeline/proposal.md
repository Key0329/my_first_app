## Why

目前專案沒有任何自動化 CI/CD。每次 push 後的靜態分析、測試、格式化都依賴開發者手動執行，容易遺漏。隨著 Backlog 加速推進，需要 GitHub Actions 自動把關程式碼品質，並在 PR 流程中提供覆蓋率報告。

## What Changes

- 新增 GitHub Actions workflow：push / PR 時自動執行 `flutter analyze`、`flutter test`、`dart format --set-exit-if-changed`
- 測試產出 lcov 覆蓋率報告，上傳為 workflow artifact
- 設定覆蓋率門檻，低於門檻時 workflow 失敗

## Capabilities

### New Capabilities

- `ci-cd-pipeline`: GitHub Actions CI workflow — 靜態分析、測試、格式化檢查、覆蓋率報告

### Modified Capabilities

(none)

## Impact

- 新增檔案：`.github/workflows/ci.yml`
- 無既有程式碼變更
- 無依賴變更
