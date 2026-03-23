## 1. 多標籤 Tag 系統

- [x] 1.1 新增 ToolTag enum（calculate/measure/life/productivity/finance）+ l10n 標籤名稱 — 對應 ToolTag enum with five categories requirement
- [x] 1.2 ToolItem 加入 tags 欄位（Set<ToolTag>），allTools 全部指定 tags，category getter 回傳 tags.first — 對應 ToolItem supports multiple tags requirement + 多標籤 Tag 系統
- [x] 1.3 首頁 tab 改為 Tag-based filtering（tab 列改為 ToolTag 篩選）— 對應 Tag-based filtering on home page requirement + Uniform two-column grid layout requirement

## 2. 響應式 Grid 佈局

- [x] 2.1 首頁 SliverGrid 響應式 Grid 欄數改為 LayoutBuilder（Responsive grid column count：< 600 → 2 欄、600-900 → 3 欄、> 900 → 4 欄）— 對應 Responsive grid column count requirement + Uniform two-column grid layout requirement
- [x] 2.2 ImmersiveToolScaffold 工具頁面 maxWidth 限寬 body 加 maxWidth 600dp（Tool page body max width constraint）— 對應 Tool page body max width constraint requirement

## 3. NavigationRail 寬螢幕適配

- [x] 3.1 app.dart 加入 LayoutBuilder，> 900dp 時切換為 NavigationRail on wide screens — 對應 NavigationRail on wide screens requirement + NavigationRail 切換策略
