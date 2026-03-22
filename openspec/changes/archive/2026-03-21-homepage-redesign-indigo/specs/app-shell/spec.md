## MODIFIED Requirements

### Requirement: App entry point and root widget

The app SHALL use `MaterialApp.router` with GoRouter as the routing engine. The app SHALL apply Material 3 theming with `ColorScheme.fromSeed(seedColor: Color(0xFF6C5CE7))`. In dark mode, the surface colors SHALL be overridden to use deep indigo blue (#1A1A2E for background, #16213E for containers).

#### Scenario: App launches with correct theme

- **WHEN** the app starts
- **THEN** the Material 3 theme with indigo seed color #6C5CE7 SHALL be applied

### Requirement: Bottom navigation with three tabs

The app SHALL display a bottom navigation bar with three tabs: Tools (工具), Favorites (收藏), and Settings (設定). The navigation SHALL use GoRouter ShellRoute to maintain tab state. The navigation bar colors SHALL derive from the indigo color scheme.

#### Scenario: User switches between tabs

- **WHEN** user taps a bottom navigation tab
- **THEN** the corresponding page SHALL be displayed while the bottom navigation bar remains visible

### Requirement: Tool list displayed as grid

The home page SHALL display all tools in a uniform 2-column GridView with equal-sized cards. Each tool card SHALL show a colored rounded-square icon container with a white icon and the tool name. The home page SHALL include category filter chips (全部/計算/測量/生活) below the title area to filter tools by category. The title area SHALL display "工具箱" with subtitle "N 個工具，隨手可用".

#### Scenario: User views the tool list

- **WHEN** user is on the Tools tab
- **THEN** all tools SHALL be displayed in a uniform 2-column grid layout with category chips

#### Scenario: User filters by category

- **WHEN** user taps a category chip
- **THEN** only tools belonging to that category SHALL be displayed in the grid
