## Why

目前工具的分享功能只產生純文字內容，接收者看到的是一段乾巴巴的文字。CEO 和 Marketing 分析指出，精美的「結果卡片」圖片是成長飛輪的核心引擎 — 帶品牌水印的圖片在社群媒體上的點擊率遠高於純文字，且每張卡片都是免費的品牌曝光。設計團隊建議使用 `RepaintBoundary` + `toImage()` 動態生成精美的結果卡片。

## What Changes

- 新增 `ShareCardGenerator` 工具類別，使用 `RepaintBoundary` 截取指定 Widget 為圖片
- 新增 `ShareCardTemplate` widget，定義品牌化的分享卡片樣板（漸層邊框 + 結果內容 + App 水印）
- 優先為 4 個工具實作分享卡片：AA 分帳、BMI、隨機轉盤、日期計算機
- 修改這些工具的 `ShareButton` 使用，從純文字分享改為圖片卡片分享

## Capabilities

### New Capabilities

- `share-result-cards`: 工具結果的精美品牌化分享卡片圖片生成與分享

### Modified Capabilities

（無）

## Impact

- 新增檔案：
  - `lib/widgets/share_card_generator.dart` — 截圖邏輯
  - `lib/widgets/share_card_template.dart` — 卡片樣板 widget
- 受影響程式碼：
  - `lib/tools/split_bill/split_bill_page.dart` — 分帳分享改用卡片
  - `lib/tools/bmi_calculator/bmi_calculator_page.dart` — BMI 分享改用卡片
  - `lib/tools/random_wheel/random_wheel_page.dart` — 轉盤結果分享改用卡片
  - `lib/tools/date_calculator/date_calculator_page.dart` — 日期倒數分享改用卡片
