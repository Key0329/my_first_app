## ADDED Requirements

### Requirement: App entry point and root widget

The app SHALL use `MaterialApp.router` with GoRouter as the routing engine. The app SHALL apply Material 3 theming with `ColorScheme.fromSeed(seedColor: Colors.teal)`.

#### Scenario: App launches with correct theme

- **WHEN** the app starts
- **THEN** the Material 3 theme with teal seed color SHALL be applied

### Requirement: Bottom navigation with three tabs

The app SHALL display a bottom navigation bar with three tabs: Tools (工具), Favorites (收藏), and Settings (設定). The navigation SHALL use GoRouter ShellRoute to maintain tab state.

#### Scenario: User switches between tabs

- **WHEN** user taps a bottom navigation tab
- **THEN** the corresponding page SHALL be displayed while the bottom navigation bar remains visible

### Requirement: Tool pages open in full screen

When a user navigates to a tool page, the app SHALL push a full-screen route that hides the bottom navigation bar. The tool page SHALL display an AppBar with the tool name and a back button.

#### Scenario: User opens a tool from the list

- **WHEN** user taps a tool card on the home page
- **THEN** the tool page SHALL open in full screen without the bottom navigation bar

#### Scenario: User returns from a tool page

- **WHEN** user taps the back button on a tool page
- **THEN** the app SHALL return to the previous tab with its state preserved

### Requirement: Tool list displayed as grid

The home page SHALL display all tools in a 2-column GridView. Each tool card SHALL show an icon with a colored circular background and the tool name. The home page SHALL include a search bar at the top to filter tools by name.

#### Scenario: User views the tool list

- **WHEN** user is on the Tools tab
- **THEN** all 12 tools SHALL be displayed in a 2-column grid layout

#### Scenario: User searches for a tool

- **WHEN** user types a query in the search bar
- **THEN** only tools whose name contains the query SHALL be displayed

### Requirement: Dark mode support

The app SHALL support three theme modes: light, dark, and system default. The theme mode setting SHALL persist across app restarts using shared_preferences.

#### Scenario: User switches to dark mode

- **WHEN** user selects dark mode in settings
- **THEN** the entire app SHALL switch to the dark color scheme immediately

#### Scenario: Theme persists after restart

- **WHEN** user has set a theme mode and restarts the app
- **THEN** the previously selected theme mode SHALL be applied on launch
