## Context

專案使用 Flutter 3.41.4，託管於 GitHub。目前沒有任何 CI/CD workflow。測試共 544 個，執行約 7 秒。需要一個輕量的 CI pipeline 在每次 push 和 PR 時自動檢查品質。

## Goals / Non-Goals

**Goals:**

- push 到任何分支 / 開 PR 時自動執行靜態分析 + 測試 + 格式化檢查
- 產出 lcov 覆蓋率報告並上傳為 workflow artifact
- 覆蓋率低於門檻時 CI 失敗

**Non-Goals:**

- 不做自動建構 APK/IPA（Fastlane）— 留給未來獨立 change
- 不做自動部署到 App Store / Google Play
- 不整合第三方覆蓋率服務（Codecov 等）

## Decisions

### 單一 workflow 檔案 ci.yml

使用一個 `.github/workflows/ci.yml`，包含三個 job：`analyze`、`format`、`test`。三個 job 平行執行以加速 CI。

### Flutter 版本鎖定策略

使用 `subosito/flutter-action` 搭配 `channel: stable` + 專案的 `.flutter-version` 或 `pubspec.yaml` constraints。不硬編碼版本號，讓 stable channel 自動對齊。

### 覆蓋率門檻設定

在 test job 中用 `flutter test --coverage` 產出 `coverage/lcov.info`，再用簡單的 shell script 解析行覆蓋率百分比。門檻初始設定為 30%（目前專案為初期階段），可在 workflow 中調整。

### 覆蓋率報告上傳

用 `actions/upload-artifact` 上傳 `coverage/lcov.info`，開發者可下載查看。不整合外部服務以保持簡單。

## Risks / Trade-offs

**[Flutter 安裝時間較長]** → `subosito/flutter-action` 有內建快取，首次約 2-3 分鐘，後續有快取約 30 秒。三個 job 平行執行，整體 CI 時間約 3-4 分鐘。

**[覆蓋率門檻太低]** → 初始 30% 是起步值，隨測試增加逐步調高。
