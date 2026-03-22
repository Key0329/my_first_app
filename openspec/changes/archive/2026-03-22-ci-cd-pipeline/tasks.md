## 1. 建立單一 workflow 檔案 ci.yml

- [x] 1.1 建立 `.github/workflows/ci.yml`，設定 CI workflow triggers on push and pull request。採用 Flutter 版本鎖定策略（subosito/flutter-action + stable channel）。包含三個平行 job：analyze（static analysis check 執行 `flutter analyze`）、format（format check 執行 `dart format --set-exit-if-changed .`）、test（test execution with coverage 執行 `flutter test --coverage`，實現覆蓋率門檻設定初始 30%，coverage threshold enforcement 低於門檻失敗，以及 coverage report artifact upload 覆蓋率報告上傳為 GitHub Actions artifact）
