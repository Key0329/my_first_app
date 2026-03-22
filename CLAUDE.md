<!-- SPECTRA:START v1.0.1 -->

# Spectra Instructions

This project uses Spectra for Spec-Driven Development(SDD). Specs live in `openspec/specs/`, change proposals in `openspec/changes/`.

## Use `/spectra:*` skills when:

- A discussion needs structure before coding → `/spectra:discuss`
- User wants to plan, propose, or design a change → `/spectra:propose`
- Tasks are ready to implement → `/spectra:apply`
- There's an in-progress change to continue → `/spectra:ingest`
- User asks about specs or how something works → `/spectra:ask`
- Implementation is done → `/spectra:archive`

## Workflow

discuss? → propose → apply ⇄ ingest → archive

- `discuss` is optional — skip if requirements are clear
- Requirements change mid-work? Plan mode → `ingest` → resume `apply`

## Parked Changes

Changes can be parked（暫存）— temporarily moved out of `openspec/changes/`. Parked changes won't appear in `spectra list` but can be found with `spectra list --parked`. To restore: `spectra unpark <name>`. The `/spectra:apply` and `/spectra:ingest` skills handle parked changes automatically.

<!-- SPECTRA:END -->

## Code Review 規則

當執行 `/spectra:apply` 時，每完成一個 task 後，必須根據變更內容啟動對應的 review。所有 review 均使用 Agent tool 啟動 subagent 以避免佔用主 context。

### 必要 Review（每個 task 完成後都要跑）

| Review | Subagent / 工具 | 用途 |
|--------|-----------------|------|
| **Code Quality** | Agent（subagent_type: `feature-dev:code-reviewer`） | 檢查 bug、邏輯錯誤、安全漏洞、程式碼品質 |
| **Static Analysis** | `flutter analyze` | Dart/Flutter 靜態分析，確保零 warning/error |

### 條件式 Review（依變更內容判斷是否需要）

| 條件 | Review | Subagent / 工具 | 用途 |
|------|--------|-----------------|------|
| 新增或修改測試檔案 | **Test Runner** | Agent（subagent_type: `flutter-tester`） | 執行相關 unit/widget test，確認測試通過 |
| 修改 UI/Widget 程式碼 | **Test Runner** | Agent（subagent_type: `flutter-tester`） | 執行相關 widget test，確認 UI 行為正確 |
| 有 App 在模擬器上執行中 | **MCP UI Testing** | Skill `flutter-mcp-testing` | 透過 dart-tooling + mobile-mcp 進行 UI 自動化測試 |

### 判斷流程

1. **完成 task** → 一律跑 Code Quality review + Static Analysis
2. **有新增/修改測試？有修改 UI？** → 加跑 flutter-tester
3. **有模擬器/裝置正在跑 App？** → 加跑 flutter-mcp-testing
4. 若任一 review 發現問題 → 修正 → 重新跑該 review，直到無重大問題
5. 所有 review 通過 → 繼續下一個 task

### 平行執行

獨立的 review 應盡量平行派發（一次送出多個 Agent tool call），減少等待時間。例如 Code Quality + flutter-tester 可同時啟動。

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 專案概述

Flutter 應用程式專案，目前為初始模板（計數器範例）。使用 Material Design，支援 Android、iOS、Web、macOS、Linux、Windows 多平台。

- **Flutter**: 3.41.4 (stable channel)
- **Dart SDK**: ^3.11.1
- **Lint 規則**: `package:flutter_lints/flutter.yaml`

## 常用指令

```bash
# 執行應用（開發模式）
flutter run

# 靜態分析
flutter analyze

# 執行所有測試
flutter test

# 執行單一測試檔案
flutter test test/widget_test.dart

# 安裝依賴
flutter pub get

# 建構發行版
flutter build apk          # Android
flutter build ios           # iOS
flutter build web           # Web
flutter build macos         # macOS
```

## 程式碼架構

目前為單檔案結構（`lib/main.dart`），所有 widget 集中於此。隨功能擴展，應採用 Flutter 官方建議的分層架構：

- `lib/` — Dart 原始碼入口
- `test/` — Widget 測試（使用 `flutter_test`）
- 各平台目錄（`android/`, `ios/`, `web/`, `macos/`, `linux/`, `windows/`）— 平台特定配置

## Flutter Skills

專案已安裝完整的 Flutter 技能集（`.agents/skills/flutter-*/`），涵蓋表單、HTTP、導航、狀態管理、動畫、主題、測試、本地化等。開發對應功能時可觸發相關 skill。
