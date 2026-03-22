## Context

專案使用 Flutter 內建 gen-l10n，ARB 檔案在 `lib/l10n/`。目前 `app_zh.arb` 有 79 個 key，但約 180-260 個字串仍硬編碼。支援 zh（繁體中文）和 en（英文）兩個 locale。

## Goals / Non-Goals

**Goals:**

- 所有使用者可見的 UI 文字接入 AppLocalizations
- `app_zh.arb` 和 `app_en.arb` 同步新增所有 key
- 執行 `flutter gen-l10n` 更新生成的 Dart 檔案

**Non-Goals:**

- 不新增第三個語系
- 不改變 gen-l10n 設定（l10n.yaml）
- 不移除 `ToolItem.fallbackName`（無 context 時的 fallback 仍需要）
- 不提取純註解中的中文

## Decisions

### ARB key 命名慣例

按頁面/工具分組，使用 camelCase：
- 頁面：`settingsThemeLight`、`onboardingWelcomeTitle`
- 工具：`calculatorTitle`、`bmiResultUnderweight`
- 共用：`commonCancel`、`commonConfirm`

### 分批替換策略

按影響範圍分批：
1. ARB 檔案先統一新增所有 key（一次性）
2. 頁面層（4 檔）先替換
3. 工具頁面（18 檔）分三批替換（計算類、測量類、生活類）
4. 共用 widgets 最後替換

### ToolCategory label 處理

`ToolCategory.label` 目前是 `const` 中文字串。改為在有 context 的地方用 AppLocalizations 取得翻譯，`label` 欄位保留作為 key identifier。

## Risks / Trade-offs

**[大量檔案變動]** → 拆成多個 task 逐步替換，每批完成後跑 analyze 確保無遺漏。

**[ARB 檔案過大]** → 可接受。Flutter 官方範例也是單檔 ARB。未來可拆分但不在此次範圍。
