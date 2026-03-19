## Context

手電筒工具頁面（`FlashlightPage`）的 `build` 方法使用 `Column` 來垂直排列主要元件（開關按鈕、狀態文字、SOS 按鈕）。目前 `Column` 未明確設定 `crossAxisAlignment`，在模擬器上呈現所有元件偏左的效果。

## Goals / Non-Goals

**Goals:**

- 修正手電筒頁面所有元件的水平置中對齊

**Non-Goals:**

- 不調整垂直方向的間距或比例
- 不變更功能邏輯

## Decisions

### 明確設定 crossAxisAlignment

在 `Column` 加上 `crossAxisAlignment: CrossAxisAlignment.center`。雖然 Flutter 文件指出 `Column` 預設值即為 `center`，但實際渲染結果偏左，明確設定可確保行為一致。

**替代方案：** 使用 `Center` widget 包裹每個子元件——但這會增加不必要的 widget 層級，且 `crossAxisAlignment` 已足夠解決問題。

## Risks / Trade-offs

- [Risk] 修改後其他裝置上的顯示可能不同 → 修正後應在多種螢幕尺寸上驗證
