## Context

現有 `ShareButton` 支援 `shareText`（純文字）和 `shareFiles`（XFile 列表）。`share_plus` 套件已安裝。分帳、BMI、轉盤、日期計算機都已有分享按鈕但只分享純文字。品牌色為 `#6C5CE7`，每個工具有獨立漸層色（`toolGradients`）。

## Goals / Non-Goals

**Goals:**

- 建立通用的分享卡片生成機制，可被任何工具複用
- 卡片包含品牌漸層邊框、工具結果、App 名稱水印
- 優先為分帳、BMI、轉盤、日期計算實作卡片
- 生成的圖片適合 Instagram Story / LINE 分享

**Non-Goals:**

- 不自訂卡片尺寸選擇（固定 1080x1080 方形）
- 不做即時預覽（直接生成並分享）
- 不在此次為所有 18 個工具都做卡片

## Decisions

### 使用 RepaintBoundary + toImage 截取 Widget

Flutter 內建的 `RepaintBoundary` 可將任何 Widget 截取為 `dart:ui.Image`，再轉為 PNG bytes 寫入暫存檔案。這是零依賴的方案。

**替代方案**：`screenshot` 套件 → 多一個依賴但功能相同，不必要。

### 通用 ShareCardTemplate widget

建立 `ShareCardTemplate`，接收 `toolName`、`toolColor`、`resultWidget`（任意 Widget），外包品牌漸層邊框和底部水印。各工具只需傳入自己的結果 Widget 即可。

### 圖片存到暫存目錄後透過 ShareButton 分享

使用 `getTemporaryDirectory()` 存放生成的 PNG，檔名帶時間戳避免衝突。透過 `ShareButton` 的 `shareFiles` 參數傳入 `XFile`。

## Risks / Trade-offs

- **[風險] toImage 在某些低階裝置上可能較慢** → 截取的 Widget 面積固定且不複雜，效能影響可忽略
- **[風險] 暫存檔案累積** → 使用 `getTemporaryDirectory()`，系統會自動清理
- **[取捨] 固定方形比例** → 方形（1:1）在 Instagram、LINE、FB 都通用，是最安全的選擇
