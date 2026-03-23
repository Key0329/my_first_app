## 1. Design Token 擴充

- [x] [P] 1.1 在 design_tokens.dart 新增完整 Typography Scale 架構（12 級 TextStyle getter 接受 Brightness 參數）— 對應 Complete Typography Scale requirement
- [x] [P] 1.2 在 design_tokens.dart 新增 Shadow / Elevation Token（shadowNone/Sm/Md/Lg，暗色返回空 list）— 對應 Shadow and Elevation tokens requirement
- [x] [P] 1.3 在 design_tokens.dart 新增 Semantic Color Token（success/error/warning/info 含亮暗模式）— 對應 Semantic Color tokens requirement
- [x] [P] 1.4 在 design_tokens.dart 新增 Animation Curve Token（curveStandard/Decelerate/Accelerate/Spring）— 對應 Animation Curve tokens requirement
- [x] [P] 1.5 在 design_tokens.dart 新增 Iconography 尺寸標準化 token（iconXs/Sm/Md/Lg/Xl）— 對應 Iconography size tokens requirement

## 2. Theme 整合

- [x] 2.1 在 app_theme.dart 將 Typography Scale 設定到 ThemeData.textTheme — 對應 AppTheme textTheme uses Typography Scale scenario

## 3. 元件套用新 Token

- [x] [P] 3.1 ToolSectionCard 套用 Shadow / Elevation Token（亮色 shadowMd，暗色無 shadow）— 對應 ImmersiveToolScaffold shared base widget 的 ToolSectionCard shadow requirement
- [x] [P] 3.2 全 App fontSize 硬編碼替換為 Typography Scale token — 涵蓋首頁、設定頁、工具頁面

## 4. Accessibility 策略 — 結果數值 liveRegion

- [x] [P] 4.1 BMI Calculator 結果加 Semantics liveRegion — 對應 Tool result values use liveRegion requirement
- [x] [P] 4.2 Currency Converter 結果加 Semantics liveRegion — 對應 Tool result values use liveRegion requirement
- [x] [P] 4.3 Split Bill 結果加 Semantics liveRegion — 對應 Tool result values use liveRegion requirement
- [x] [P] 4.4 Word Counter 統計加 Semantics liveRegion — 對應 Tool result values use liveRegion requirement
- [x] [P] 4.5 Date Calculator 結果加 Semantics liveRegion — 對應 Tool result values use liveRegion requirement

## 5. Accessibility — 工具特定 Semantics

- [x] [P] 5.1 Level tool 角度顯示加 Semantics liveRegion — 對應 Level tool angle semantics requirement
- [x] [P] 5.2 Flashlight toggle 加 Semantics label/hint — 對應 Flashlight toggle semantics requirement
- [x] [P] 5.3 Screen Ruler 測量值加 Semantics liveRegion — 對應 Screen ruler measurement semantics requirement
- [x] [P] 5.4 Random Wheel 結果加 Semantics liveRegion — 對應 Random wheel result semantics requirement
- [x] [P] 5.5 Stopwatch/Timer 倒計時加 Semantics value — 對應 Timer countdown semantics requirement
- [x] [P] 5.6 Password Generator 結果加 Semantics label/value — 對應 Password generator result semantics requirement
- [x] [P] 5.7 QR Scanner 結果加 Semantics liveRegion — 對應 QR code result semantics requirement

## 6. Accessibility — 互動元件與 Slider

- [x] 6.1 全 App 自訂互動元件補 Semantics label/hint — 對應 Interactive elements have semantic labels requirement（含收藏按鈕、搜尋按鈕等）
- [x] [P] 6.2 Pomodoro duration Slider 加 semanticFormatterCallback — 對應 Slider semantic formatter callback requirement
- [x] [P] 6.3 BMI height/weight Slider 加 semanticFormatterCallback — 對應 Slider semantic formatter callback requirement

## 7. Color contrast 驗證

- [x] 7.1 驗證所有文字/背景 Color contrast compliance ≥ 4.5:1（亮色 + 暗色模式）— 對應 Color contrast compliance requirement，修正不合規色彩
