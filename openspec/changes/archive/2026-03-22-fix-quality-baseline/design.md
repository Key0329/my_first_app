## Context

Spectra 工具箱 App 有 18 個工具頁面，共用 `ImmersiveToolScaffold` 作為佈局框架。目前存在以下品質問題：

1. **匯率換算靜默 fallback**：`CurrencyApi.convert()` 在找不到幣別匯率時使用 `?? 1.0` fallback，導致錯誤結果無提示
2. **dart:io 平台限制**：`timer_notification_service.dart` 直接 import `dart:io` 使用 `Platform.isAndroid`，Web build 無法編譯
3. **toolColor 不一致**：12 個工具頁面硬編碼 `toolColor`，與 `design_tokens.dart` 中 `toolGradients` 定義的色彩不匹配
4. **OverlayEntry 洩漏**：Random Wheel 的結果覆蓋層在頁面 dispose 時未清理
5. **暗色模式對比度**：`darkSubtitle` 和 `darkNavInactive` 未達 WCAG AA 4.5:1 標準

## Goals / Non-Goals

**Goals:**

- 消除所有已知的高風險 Bug，確保核心工具（匯率換算）結果正確
- 使 Web 平台可正常編譯執行
- 統一首頁卡片與工具頁面的色彩，消除視覺斷裂
- 暗色模式文字對比度達到 WCAG AA 標準
- 修正 OverlayEntry 生命週期管理

**Non-Goals:**

- 不重構 CurrencyApi 的整體架構（留給 Phase 4 `enhance-currency-converter`）
- 不全面處理 Accessibility（留給 Phase 7 `design-system-v2`）
- 不修改 toolGradients 本身的色彩定義

## Decisions

### 匯率 fallback 改為拋出 ArgumentError

將 `rates[fromCurrency] ?? 1.0` 改為明確檢查並拋出 `ArgumentError`。UI 層在 catch 時顯示錯誤提示。

**替代方案**：回傳 `null` 讓 UI 判斷 → 需要改動更多上層程式碼，不適合此次小修。

### dart:io 改用 Foundation 的 defaultTargetPlatform

移除 `import 'dart:io'`，改用 Flutter 的 `foundation.dart` 中的 `defaultTargetPlatform` 和 `kIsWeb`。這是 Flutter 官方推薦的跨平台判斷方式，已在專案中的 `platform_check.dart` 有範例。

**替代方案**：conditional import（`stub` + `real` 檔案）→ 過度複雜，此處只有 1 處使用。

### toolColor 統一從 ToolItem.color 取值

在各工具頁面中，將硬編碼的 `toolColor: const Color(0xXXXXXX)` 改為從 `ToolItem.color`（即 `toolGradients[id]?.first`）取值。具體做法：

1. 使用 `_toolColor` 變數的頁面（如 `split_bill_page.dart`）已經是正確模式，不需修改
2. 硬編碼 `toolColor` 的 12 個頁面需逐一修正
3. 各頁面需 import `tool_item.dart` 並查找對應的 `ToolItem`

**替代方案**：將 toolColor 作為路由參數傳入 → 改動量更大，且路由層不應承擔色彩邏輯。

### OverlayEntry 在 dispose 中移除

在 `_RandomWheelPageState.dispose()` 中加入 `_overlayEntry?.remove(); _overlayEntry = null;`，確保頁面銷毀時覆蓋層被清理。

### 暗色模式色值調整

| Token | 現值 | 新值 | 背景色 | 現對比度 | 新對比度 |
|-------|------|------|--------|---------|---------|
| `darkSubtitle` | `#7777A0` | `#9999BB` | `#1A1A2E` | 3.2:1 | ~4.7:1 |
| `darkNavInactive` | `#555577` | `#8888AA` | `#16213E` | 2.1:1 | ~4.5:1 |

## Risks / Trade-offs

- **[風險] 匯率 throw 可能造成未處理的例外** → UI 層的 try-catch 必須同步更新，確保顯示友善錯誤訊息
- **[風險] toolColor 統一後視覺變化** → 部分工具原有的硬編碼色彩可能是設計師刻意選擇 → 此次統一為 toolGradients 第一色，若後續需要微調可在 toolGradients 中修改
- **[取捨] 暗色對比度提升可能降低視覺層次感** → 選擇 WCAG AA 合規優先，微調幅度最小化
