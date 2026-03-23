## Context

App 目前使用 Flutter 預設 icon，pubspec.yaml 已配置 `flutter_launcher_icons` 但 `assets/icon/app_icon.png` 不存在。Splash screen 為平台預設。Onboarding 三頁式（歡迎、功能、開始），全部靜態無動畫。

## Goals / Non-Goals

**Goals:**

- 生成品牌漸層 App Icon PNG 並配置 flutter_launcher_icons
- 設定 flutter_native_splash 品牌色 Splash Screen
- Onboarding 三頁加入進場動畫

**Non-Goals:**

- 不引入 Lottie、Rive 等第三方動畫框架
- 不重新設計 Onboarding 頁面的內容結構
- 不做 App Store 截圖素材（屬於上架 checklist）

## Decisions

### App Icon 生成策略

用 Dart 腳本 + `dart:ui` 程式化繪製 1024x1024 品牌 icon：
- 背景：品牌漸層（DT.brandPrimary → DT.brandPrimaryLight，左上到右下）
- 前景：白色稜鏡圖形（六邊形 + 工具扳手圖案，象徵「工具箱」）
- 簡化方案：直接用品牌漸層背景 + 白色 build_rounded icon，與 Onboarding 歡迎頁一致

Export 為 `assets/icon/app_icon.png`，然後執行 `flutter pub run flutter_launcher_icons` 生成各平台尺寸。

### Splash Screen 設定

加入 `flutter_native_splash` 依賴，在 pubspec.yaml 設定：
- `color`: 品牌色 `#6C5CE7`
- `image`: 小尺寸品牌 icon（192x192），居中顯示
- Android 12+ 的 `android_12` 設定使用 adaptive icon
- `web: false`（Web 不需要原生 splash）

執行 `flutter pub run flutter_native_splash:create` 生成原生檔案。

### Onboarding 動畫策略

為每頁加入 `AnimationController` + 組合動畫，在頁面進入可視區時觸發：

**第 1 頁（歡迎）：**
- Logo 容器：`ScaleTransition` 從 0 → 1 + `FadeTransition`，搭配 `Curves.elasticOut`
- 標題和描述：延遲 200ms 後 `SlideTransition`（從下方 30dp 滑入）+ `FadeTransition`

**第 2 頁（功能介紹）：**
- 三個 `_FeatureRow` 交錯淡入：第 1 個 delay 0ms，第 2 個 200ms，第 3 個 400ms
- 每個 `SlideTransition`（從右方滑入）+ `FadeTransition`

**第 3 頁（開始使用）：**
- 火箭 icon：`SlideTransition`（從下方 50dp 上升）+ `ScaleTransition`
- 按鈕：延遲 300ms 後 `FadeTransition` + `ScaleTransition` 從 0.8 → 1.0

使用 `PageView` 的 `onPageChanged` 觸發對應頁面的動畫 controller。

## Risks / Trade-offs

- **[flutter_native_splash 生成物]** → 會修改 Android/iOS 原生檔案。已有 git 追蹤，可 revert。
- **[Icon 品質]** → 程式化生成的 icon 不如專業設計師，但足以上架使用。後續可替換。
- **[Onboarding 動畫過度]** → 動畫太多會分散注意力。保持簡約，每頁最多 2-3 個動畫元素。
