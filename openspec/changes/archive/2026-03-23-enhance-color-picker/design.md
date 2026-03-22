## Context

色彩擷取工具使用 MobileScanner 的相機預覽，中心十字線取色。歷史記錄為 `_ColorEntry` list（最多 20 筆），只存在記憶體中。目前顯示 HEX 和 RGB。

## Goals / Non-Goals

**Goals:**

- 新增從相簿選圖取色功能
- 歷史記錄持久化到 SharedPreferences
- 新增 HSL 色碼格式顯示

**Non-Goals:**

- 不支援色板建立或匯出
- 不支援調色盤推薦（互補色等）
- 不改變相機取色的核心機制

## Decisions

### 從相簿選圖取色

使用 `image_picker` 套件選圖。選圖後顯示在頁面上方（取代相機預覽區），使用者點擊圖片任意位置取色。透過 `decodeImageFromList` + 讀取像素色值實現。在 header 區新增相機/相簿切換按鈕。

### 歷史記錄持久化

在 `_ColorEntry` 新增 `toJson()`/`fromJson()`。使用 SharedPreferences 存儲 JSON 列表。在 `initState` 時載入，每次新增/清除時保存。Key: `color_picker_history`。

### HSL 格式顯示

在 `_ColorEntry` 新增 `hsl` getter（使用 `HSLColor.fromColor()`）。在色值顯示區新增 HEX/RGB/HSL 三行，或使用 SegmentedButton 切換。簡單起見，直接三行都顯示。

## Risks / Trade-offs

**[image_picker 新增依賴]** → 這是 Flutter 官方維護的套件，成熟穩定，體積增量可忽略。

**[圖片取色精度]** → 使用 `ui.Image` pixel 讀取，精度與解析度相關。對大圖可能需要縮放，但不影響色彩準確度。
