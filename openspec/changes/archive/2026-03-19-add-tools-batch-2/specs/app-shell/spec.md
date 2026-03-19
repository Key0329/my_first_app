## ADDED Requirements

### Requirement: Routes for new tools

The app SHALL register four new full-screen GoRoute entries with CustomTransitionPage and FadeTransition:
- `/tools/bmi-calculator` → BmiCalculatorPage
- `/tools/split-bill` → SplitBillPage
- `/tools/random-wheel` → RandomWheelPage
- `/tools/screen-ruler` → ScreenRulerPage

#### Scenario: User navigates to a new tool

- **WHEN** user taps any of the four new tool cards on the home page
- **THEN** the corresponding tool page SHALL open in full screen with a fade transition and Hero animation

## REMOVED Requirements

### Requirement: Invoice checker route

**Reason**: The invoice checker tool is being removed from the application to reduce complexity and external dependencies.
**Migration**: No migration needed. The route `/tools/invoice-checker` SHALL no longer exist. Users who had invoice checker in favorites SHALL have the stale entry silently filtered out.

#### Scenario: User navigates to removed invoice checker route

- **WHEN** a deep link or stale reference attempts to navigate to `/tools/invoice-checker`
- **THEN** the route SHALL not exist and GoRouter SHALL handle it as an unknown route

## MODIFIED Requirements

### Requirement: Tool list displayed as grid

The home page SHALL display all tools in a Bento Grid layout with variable-sized cards. Favorited tools SHALL be displayed as large cards spanning 2 columns. The home page SHALL include a search bar at the top to filter tools by name. When filtering, the Bento layout SHALL recalculate for the visible tools. The total tool count SHALL be 15.

#### Scenario: User views the tool list

- **WHEN** user is on the Tools tab
- **THEN** all 15 tools SHALL be displayed in a Bento Grid layout with variable card sizes

#### Scenario: User searches for a tool

- **WHEN** user types a query in the search bar
- **THEN** only tools whose name contains the query SHALL be displayed in a recalculated Bento layout
