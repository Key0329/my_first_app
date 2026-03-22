## Summary

全面提升用戶體驗：新增 Onboarding 引導流程、收藏改為可見按鈕、全域 Haptic Feedback、設定頁 Bento 風格重設計、最近使用區段、工具色彩統一、隨機轉盤結果展示重設計。

## Motivation

UX 審查發現多個痛點：

- **收藏功能不可發現**：長按觸發收藏但無任何視覺提示，新使用者根本不知道此功能存在
- **零觸覺反饋**：所有按鈕和互動操作缺乏 Haptic Feedback，體驗缺乏質感
- **設定頁品質斷裂**：設定頁使用標準 ListTile，與首頁 Bento Grid 風格不一致
- **工具色彩不一致**：`ToolItem.color` 與 `toolGradients` 的第一色對不上，導致首頁卡片與工具頁面色彩斷裂
- **新使用者無引導**：缺乏首次使用引導，使用者需要自行探索功能
- **缺少最近使用**：無法快速存取最近使用過的工具
- **轉盤結果體驗粗糙**：隨機轉盤結果使用標準 AlertDialog，缺乏動畫與視覺衝擊

## Proposed Solution

1. **Onboarding 引導**：首次啟動時展示 3 頁引導（歡迎、核心功能介紹、開始使用）
2. **收藏按鈕可見化**：在工具卡片上新增愛心圖示按鈕，點擊切換收藏狀態並顯示 SnackBar 反饋
3. **全域 Haptic Feedback**：為按鈕點擊、收藏切換、頁面切換等互動加入觸覺反饋
4. **設定頁 Bento 重設計**：將設定頁改為 Bento Grid 風格，與首頁設計語言統一
5. **最近使用區段**：擴展 AppSettings 追蹤工具使用紀錄，在首頁新增「最近使用」區段
6. **工具色彩統一**：將 `ToolItem.color` 改為使用 `toolGradients` 的第一色，確保色彩一致性
7. **轉盤結果重設計**：自訂覆蓋動畫取代 AlertDialog，加入縮放彈跳動畫與半透明背景

## Capabilities

### New Capabilities

- `onboarding-flow`：首次使用 3 頁引導流程，使用 shared_preferences 追蹤是否已完成
- `recent-tools`：最近使用工具追蹤與顯示，擴展 AppSettings 儲存使用紀錄

### Modified Capabilities

- `favorites`：收藏按鈕從長按改為可見愛心按鈕，新增 SnackBar 反饋
- `settings`：設定頁從 ListTile 改為 Bento Grid 風格
- `app-animations`：新增全域 Haptic Feedback 策略，新增轉盤結果覆蓋動畫

## Impact

- 受影響的 specs：`onboarding-flow`（新增）、`recent-tools`（新增）、`favorites`（修改）、`settings`（修改）、`app-animations`（修改）
- 受影響的程式碼：
  - `lib/pages/home_page.dart`（新增最近使用區段、收藏按鈕）
  - `lib/pages/settings_page.dart`（Bento 重設計）
  - `lib/widgets/tool_card.dart`（愛心按鈕、Haptic Feedback）
  - `lib/models/tool_item.dart`（色彩統一）
  - `lib/services/settings_service.dart`（Onboarding 狀態、使用紀錄）
  - `lib/theme/design_tokens.dart`（色彩修正）
  - `lib/tools/random_wheel/random_wheel_page.dart`（結果覆蓋動畫）
  - 新增 `lib/pages/onboarding_page.dart`
  - `lib/app.dart`（Onboarding 路由）
