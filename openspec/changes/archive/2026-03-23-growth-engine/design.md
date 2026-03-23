## Context

工具箱已有分享功能（`ShareCardTemplate` + `ShareCardGenerator` + `ShareButton`），但分享文案是泛用的。首頁（`home_page.dart`）有「最近使用」區塊和工具搜尋。`UserPreferencesService` 管理最近使用的工具和 onboarding 狀態。

需要在不大幅改動架構的前提下，加入成長與留存功能。

## Goals / Non-Goals

**Goals:**

- 分享卡片加入工具專屬的比較鉤子文案
- 首頁新增每日推薦工具卡片（隨機選擇使用者不常用的工具）
- 追蹤使用 Streak（連續天數），持久化到 SharedPreferences
- Streak 顯示在首頁（火焰圖示 + 天數）
- 完整 i18n

**Non-Goals:**

- 不做推播通知（智慧通知留待後續 change）
- 不做社群排行榜
- 不做成就系統
- 不做伺服端分析

## Decisions

### 分享文案鉤子

在 `ShareButton` 或各工具的分享邏輯中，傳入工具專屬的 `shareHook` 文案字串。例如 BMI 工具分享時帶上「我的 BMI 是 {value}，你呢？」。

文案透過 i18n 系統管理，每個需要鉤子的工具新增對應的 ARB key。

**理由**：不修改 `ShareCardTemplate` 的渲染邏輯，只在分享時附帶文案，影響最小。

### 每日推薦工具

在 `UserPreferencesService` 新增 `getDailyRecommendation()` 方法：
- 取今日日期字串作為 seed，確保同一天推薦同一工具
- 從 `allTools` 中排除最近使用的前 5 個工具
- 用日期 hash 選擇一個推薦工具
- 若所有工具都常用，則隨機選一個

首頁在「最近使用」區塊上方顯示推薦卡片。

**理由**：純本地計算，無需網路。日期做 seed 確保每天只推薦一個，不會每次開啟都不同。

### Streak 追蹤

在 `UserPreferencesService` 新增：
- `_streakCount`: 連續天數
- `_lastActiveDate`: 上次使用日期
- `recordDailyUsage()`: 在 `addRecentTool()` 時呼叫，檢查是否是新的一天，是則 streak +1 或重置

持久化到 SharedPreferences（`streak_count` + `streak_last_date`）。

**理由**：最簡單的 streak 邏輯 — 每天只要使用一次任意工具就算活躍。

## Risks / Trade-offs

- [推薦品質] 簡單的排除+hash 選擇無法做到「智慧推薦」 → 對工具箱而言足夠，先驗證留存效果再優化
- [Streak 時區] 使用本地時間判斷日期，不同時區可能影響 → 對個人工具箱而言可接受
