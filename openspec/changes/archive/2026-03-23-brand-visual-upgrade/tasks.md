## 1. App Icon 生成

- [x] 1.1 用 Dart 程式生成 1024x1024 品牌 App Icon PNG（品牌漸層背景 + 白色工具 icon）並存入 assets/icon/app_icon.png — 對應 App Icon 生成策略
- [x] 1.2 執行 flutter_launcher_icons 生成各平台尺寸 icon — 對應 App Icon 生成策略

## 2. Splash Screen 設定

- [x] 2.1 加入 flutter_native_splash 依賴並在 pubspec.yaml 設定 Native splash screen with brand identity（品牌色背景 + 居中 icon）— 對應 Native splash screen with brand identity requirement + Splash Screen 設定
- [x] 2.2 執行 flutter_native_splash:create 生成原生 splash 檔案 — 對應 Native splash screen with brand identity requirement

## 3. Onboarding 動畫升級

- [x] 3.1 Onboarding Welcome page entrance animation（歡迎頁 logo ScaleTransition + 文字 SlideTransition）— 對應 Welcome page entrance animation requirement + Onboarding 動畫策略
- [x] 3.2 Onboarding Features page staggered entrance（功能頁三行交錯 SlideTransition + FadeTransition）— 對應 Features page staggered entrance requirement + Onboarding 動畫策略
- [x] 3.3 Onboarding Get started page entrance animation（開始頁火箭 SlideTransition + 按鈕 FadeTransition）— 對應 Get started page entrance animation requirement + Onboarding 動畫策略 + Three-page onboarding flow requirement
