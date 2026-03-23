## Context

目前 `ToolItem` 使用 `ToolCategory` enum（calculate/measure/life）作為單一分類。首頁 tab 用 `== category` 過濾。佈局固定 2 欄 `SliverGrid`。導航使用 `NavigationBar`（底部）。App shell 在 `app.dart` 中用 `Scaffold` + `NavigationBar`。

## Goals / Non-Goals

**Goals:**

- ToolItem 支援多標籤（1-3 個 tag）
- 首頁 tab 改為 tag-based 篩選
- Grid 欄數隨裝置寬度自適應
- 工具頁面 body 在寬螢幕置中限寬
- 寬螢幕切換為 NavigationRail

**Non-Goals:**

- 不做 tag 自訂（用戶不能建立自己的 tag）
- 不做 master-detail 雙欄佈局（iPad 左側列表 + 右側工具）
- 不移除 ToolCategory enum（保留向下相容）

## Decisions

### 多標籤 Tag 系統

新增 `ToolTag` enum，值比 `ToolCategory` 更細：

| Tag | 說明 | 對應工具 |
|-----|------|---------|
| `calculate` | 數學/運算 | 計算機、單位換算、BMI、分帳、日期 |
| `measure` | 測量/感測 | 水平儀、指南針、量角器、尺規、噪音計 |
| `life` | 日常生活 | 手電筒、碼錶、密碼、色彩、QR、隨機轉盤 |
| `productivity` | 生產力/工作 | 番茄鐘、筆記、文字計數、密碼、匯率 |
| `finance` | 財務相關 | 計算機、分帳、匯率 |

`ToolItem` 新增 `tags` 欄位（`Set<ToolTag>`），`category` 變為 getter 回傳 `tags.first`。

首頁 tab 過濾邏輯從 `tool.category == selected` 改為 `tool.tags.contains(selectedTag)`。

### 響應式 Grid 欄數

使用 `LayoutBuilder` 取得可用寬度，套用斷點：

| 寬度 | 欄數 | 場景 |
|------|------|------|
| < 600dp | 2 | 手機（直向） |
| 600-900dp | 3 | 手機（橫向）、小平板 |
| > 900dp | 4 | iPad、大平板 |

在 `SliverGrid` 的 `crossAxisCount` 動態設定。`childAspectRatio` 保持 1.2。

### 工具頁面 maxWidth 限寬

在 `ImmersiveToolScaffold` 的 body 區域外層加 `Center` + `ConstrainedBox(maxWidth: 600)`。Header 保持全寬。

### NavigationRail 切換策略

在 `app.dart` 的 `Scaffold` 中使用 `LayoutBuilder`：
- 寬度 ≤ 900dp：現有 `NavigationBar`（底部）
- 寬度 > 900dp：`NavigationRail`（左側）+ `Expanded(child: body)`

使用 `Row` 包裝 `NavigationRail` + 內容區域。

## Risks / Trade-offs

- **[Tag 資料遷移]** → `allTools` 清單需要逐一加 tags。一次改完，用既有 category 對應。
- **[NavigationRail 視覺差異]** → 需要設定正確的 icon/label 樣式，確保與 NavigationBar 一致。
- **[Grid 欄數變化時的動畫]** → 裝置旋轉時 Grid 會重建，可能閃爍。使用 `AnimatedSwitcher` 或直接允許重建。
