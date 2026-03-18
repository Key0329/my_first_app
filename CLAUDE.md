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
