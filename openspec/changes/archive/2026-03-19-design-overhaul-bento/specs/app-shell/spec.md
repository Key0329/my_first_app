## MODIFIED Requirements

### Requirement: App entry point and root widget

The app SHALL use `MaterialApp.router` with GoRouter as the routing engine. The app SHALL apply Material 3 theming with `ColorScheme.fromSeed(seedColor: Colors.teal)`. The theme SHALL include extended configuration for transparent AppBar styles, surface container colors for the immersive tool scaffold body sections, and card themes supporting gradient backgrounds.

#### Scenario: App launches with correct theme

- **WHEN** the app starts
- **THEN** the Material 3 theme with teal seed color SHALL be applied, including transparent AppBar support and extended card styling

### Requirement: Tool pages open in full screen

When a user navigates to a tool page, the app SHALL push a full-screen route that hides the bottom navigation bar. The tool page SHALL use ImmersiveToolScaffold with a transparent AppBar showing the tool name and a back button. The route transition SHALL use CustomTransitionPage to support Hero animations between the home card and tool page.

#### Scenario: User opens a tool from the list

- **WHEN** user taps a tool card on the home page
- **THEN** the tool page SHALL open in full screen with a Hero transition animation and without the bottom navigation bar

#### Scenario: User returns from a tool page

- **WHEN** user taps the back button on a tool page
- **THEN** the app SHALL return to the previous tab with its state preserved, using a reverse Hero transition animation

### Requirement: Tool list displayed as grid

The home page SHALL display all tools in a Bento Grid layout with variable-sized cards. Favorited tools SHALL be displayed as large cards spanning 2 columns. The home page SHALL include a search bar at the top to filter tools by name. When filtering, the Bento layout SHALL recalculate for the visible tools.

#### Scenario: User views the tool list

- **WHEN** user is on the Tools tab
- **THEN** all 12 tools SHALL be displayed in a Bento Grid layout with variable card sizes

#### Scenario: User searches for a tool

- **WHEN** user types a query in the search bar
- **THEN** only tools whose name contains the query SHALL be displayed in a recalculated Bento layout
