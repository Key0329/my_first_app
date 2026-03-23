## Summary

建立品牌視覺識別：自訂 App Icon（品牌漸層稜鏡）、品牌化 Splash Screen、Onboarding 頁面動畫升級。

## Motivation

目前 App 使用 Flutter 預設 icon（藍色方塊），Splash Screen 是白底無品牌元素，Onboarding 頁面是靜態文字佈局。這些是用戶對 App 的第一印象觸點，直接影響下載轉換率和品牌記憶度。上架前需要建立一致的品牌視覺。

## Proposed Solution

1. **App Icon** — 使用 `flutter_launcher_icons`（已安裝）生成品牌 icon。用 `CustomPainter` 程式化繪製品牌漸層稜鏡圖案，export 為 PNG，設定 adaptive icon。
2. **Splash Screen** — 使用 `flutter_native_splash` 設定品牌色背景 + 中心 icon 的原生 splash screen，確保冷啟動時就顯示品牌元素。
3. **Onboarding 動畫升級** — 在現有三頁式 Onboarding 中加入純 Flutter 動畫：歡迎頁 icon 彈入、功能介紹頁交錯淡入、開始頁火箭上升動畫。不引入第三方動畫套件。

## Impact

- Affected specs: `brand-splash-screen`（新）、`brand-onboarding-animation`（新）、`onboarding-flow`（修改）
- Affected code:
  - `assets/icon/app_icon.png` — 新增品牌 icon 圖檔
  - `pubspec.yaml` — 加入 flutter_native_splash 依賴和設定
  - `lib/pages/onboarding_page.dart` — 加入頁面進場動畫
  - Android/iOS 原生 splash 設定檔
