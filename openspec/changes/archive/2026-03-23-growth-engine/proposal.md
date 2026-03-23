## Why

工具箱已有 21 個工具和分享卡片功能，但缺乏主動的成長與留存機制。目前使用者開啟 App 後只會用到自己已知的工具，沒有動機每天回來或推薦給朋友。需要加入病毒傳播鉤子和留存機制，在不增加新工具的前提下提升 DAU 和自然傳播率。

## What Changes

**病毒傳播：**
- 優化分享卡片文案，加入「比較鉤子」（如：「我的 BMI 是 22.5，你呢？」）
- 噪音計加入「挑戰模式」文案（「我測到 78 dB，你的環境有多吵？」）
- 分帳結果卡片加入趣味語氣

**留存機制：**
- 首頁新增「每日推薦工具」卡片，每天隨機推薦一個使用者未常用的工具
- 使用連續天數 Streak 追蹤（連續使用 N 天，顯示火焰圖示）
- Streak 資料持久化到 SharedPreferences

## Capabilities

### New Capabilities

- `growth-viral-sharing`: 分享卡片文案優化與比較鉤子機制
- `growth-retention`: 每日推薦工具卡片與使用 Streak 追蹤

### Modified Capabilities

（無）

## Impact

- 受影響程式碼：
  - `lib/widgets/share_card_template.dart` — 分享卡片文案優化
  - `lib/pages/home_page.dart` — 新增每日推薦卡片和 Streak 顯示
  - `lib/services/user_preferences_service.dart` — 新增 Streak 追蹤邏輯
  - `lib/l10n/app_zh.arb` / `app_en.arb` — 新增 i18n 字串
  - `test/` — 新增對應測試
