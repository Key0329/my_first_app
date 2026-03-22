## Context

目前工具箱 App 擁有 15 個工具，其中 7 個工具（compass、color_picker、flashlight、level、noise_meter、protractor、screen_ruler）完全沒有測試覆蓋。QA 審查同時發現無障礙支援不足、Design Token 不完整、破壞性操作缺少確認對話框、錯誤狀態顯示不一致、以及 NumberPicker controller 未正確 dispose 等問題。

## Goals / Non-Goals

**Goals:**

- 為 7 個缺少測試的工具建立單元測試，覆蓋純邏輯函數
- 為關鍵互動元素加入 Semantics 無障礙標註
- 補全 Design Token 系統（Motion Token、Opacity Token）
- 統一破壞性操作的確認對話框模式
- 統一錯誤狀態顯示
- 修復 NumberPicker controller 生命週期問題

**Non-Goals:**

- 不進行 UI 視覺重新設計
- 不增加新工具功能
- 不進行 Widget 測試或整合測試（本次僅補純邏輯單元測試）
- 不處理 i18n 翻譯品質問題

## Decisions

### 補測試策略

為 7 個無測試工具抽出可測試的純邏輯函數，建立對應的 `_logic.dart` 檔案（如已內嵌於 page 中的計算邏輯），並在 `test/tools/` 下撰寫單元測試。

測試目標函數：
- **compass**：角度轉方位文字（degreeToDirection）
- **color_picker**：RGB/HSL/Hex 互轉函數
- **flashlight**：無純邏輯（僅硬體 API 呼叫），測試 SOS 頻率計算
- **level**：加速度值轉傾斜角度、水平判定閾值
- **noise_meter**：dB 值轉顏色映射、dB 等級分類
- **protractor**：兩點間角度計算、角度正規化
- **screen_ruler**：PPI 計算、像素轉公分/英吋

**替代方案考量**：也考慮過直接寫 Widget 測試，但純邏輯測試執行速度快、維護成本低，且能驗證核心計算正確性，優先於 Widget 測試。

### 無障礙 Semantics 策略

在以下元素加入 `Semantics` widget：
- **計算機按鈕**：每個按鈕加入 `label`（如「加法」「等於」）與 `button: true`
- **噪音計數值**：加入 `value` 與 `liveRegion: true` 使螢幕閱讀器即時播報
- **指南針方位**：加入方位文字 `label`（如「北偏東 45 度」）
- **量角器角度**：加入角度 `value`（如「45 度」）

不為純裝飾性元素（漸層背景、分隔線）加入 Semantics。

**替代方案考量**：也考慮過使用 `tooltip` 屬性，但 `Semantics` widget 是 Flutter 官方推薦的無障礙方案，對螢幕閱讀器支援更完整。

### Design Token 補全

在 `DT` 類中新增：

**Motion Token：**
- `durationFast = Duration(milliseconds: 150)` — 按鈕回饋、微互動
- `durationMedium = Duration(milliseconds: 300)` — 頁面轉場、展開收合
- `durationSlow = Duration(milliseconds: 500)` — 複雜動畫、首次載入

**Opacity Token：**
- `opacityDisabled = 0.38` — 停用狀態
- `opacityOverlay = 0.08` — 按壓覆蓋層
- `opacityHover = 0.04` — 懸停覆蓋層

這些常數取代目前程式碼中散落的 magic number。

**替代方案考量**：也考慮過用 `ThemeExtension` 管理 Token，但既有的 `DT` 抽象類模式已在專案中廣泛使用且運作良好，保持一致性優先。

### 確認對話框統一模式

建立共用的 `ConfirmDialog` widget，套用於：
- **計算機清除歷史**：確認後清空計算歷史記錄
- **碼錶重設**：確認後歸零計時器與圈數記錄
- **隨機轉盤刪除選項**：確認後移除指定選項

對話框統一使用 `showAdaptiveDialog` + `AlertDialog.adaptive`，確認按鈕使用 `colorScheme.error` 色彩表示破壞性操作。

**替代方案考量**：也考慮過 Snackbar undo 模式，但確認對話框對於不可逆操作更安全，也更符合 Material Design 指引。

### 錯誤狀態統一

定義標準錯誤狀態顯示模式：
- 使用 `colorScheme.error` 作為錯誤文字與圖示色彩
- 使用 `Icons.error_outline` 作為標準錯誤圖示
- 錯誤訊息居中顯示於 `ToolSectionCard` 內
- 提供可選的「重試」按鈕

此模式套用於感測器初始化失敗（噪音計、指南針、水平儀）與網路錯誤（發票對獎）等場景。

**替代方案考量**：也考慮過用 Banner 式錯誤提示，但 ToolSectionCard 內嵌模式與現有 UI 架構一致，不需要額外的 overlay 管理。

### NumberPicker controller 生命週期修復

在使用 `NumberPicker` 或類似有 controller 的元件（如 `TextEditingController`、`ScrollController`）的頁面中，確保：
- 在 `initState` 中建立 controller
- 在 `dispose` 中呼叫 `controller.dispose()`
- 不在 `build` 中重複建立 controller

主要修復目標為 `random_wheel_page.dart` 中的 NumberPicker 相關 controller。

**替代方案考量**：也考慮過使用 `useTextEditingController` hook（flutter_hooks），但專案目前未使用 hooks，引入新依賴不符合本次補強目標。

## Risks / Trade-offs

- [風險] 抽出純邏輯函數可能需要小幅重構現有 page 檔案 → 緩解：僅抽出計算函數，不改變 UI 結構
- [風險] Semantics 標註可能影響現有測試的 finder → 緩解：現有 Widget 測試數量有限，影響可控
- [風險] 確認對話框增加操作步驟，影響使用體驗 → 緩解：僅在破壞性操作加入，日常操作不受影響
- [取捨] 本次僅補純邏輯測試，不含 Widget 測試 → 後續可在專屬 change 中補強 Widget 測試覆蓋
