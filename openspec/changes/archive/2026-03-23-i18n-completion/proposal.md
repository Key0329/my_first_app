## Summary

將所有硬編碼中文字串接入 AppLocalizations，完成全面 i18n 覆蓋。

## Motivation

目前 app 有 79 個已本地化字串，但約 180-260 個字串仍硬編碼在程式碼中。這阻擋了英文版上架和多語系擴展。主要缺口在：

- **頁面層**（settings、onboarding、home、favorites）：~33 個字串
- **18 個工具頁面**：~120-180 個字串（佔最大宗）
- **共用 widgets**：~10 個字串
- **資料模型**（ToolCategory label、fallbackName、units_data）：~30 個字串

## Proposed Solution

1. 在 `app_zh.arb` / `app_en.arb` 新增所有缺少的字串 key
2. 執行 `flutter gen-l10n` 重新生成 AppLocalizations
3. 逐一替換各頁面/widget 中的硬編碼字串為 `AppLocalizations.of(context)!.keyName`
4. `ToolCategory.label` 和 `ToolItem.fallbackName` 保留作為無 context 時的 fallback，不移除

## Impact

- 修改的 spec：`localization`
- 影響的程式碼：`lib/l10n/app_zh.arb`、`lib/l10n/app_en.arb`、`lib/pages/*.dart`（4 檔）、`lib/tools/*/\*.dart`（18 檔）、`lib/widgets/*.dart`（約 6 檔）
- 無依賴變更
