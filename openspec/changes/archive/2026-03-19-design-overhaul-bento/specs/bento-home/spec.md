## ADDED Requirements

### Requirement: Bento Grid layout with variable card sizes

The home page SHALL display tools in a Bento Grid layout using a CustomScrollView with SliverGrid. Cards SHALL have three possible sizes: large (spanning 2 columns, 1.5x height), medium (1 column, 1.2x height), and small (1 column, 1x height). The layout SHALL dynamically arrange cards based on available sizes to fill rows without gaps.

#### Scenario: Home page displays Bento Grid layout

- **WHEN** user navigates to the Tools tab
- **THEN** tools SHALL be displayed in a Bento Grid with variable-sized cards instead of a uniform 2-column grid

#### Scenario: Favorited tools display as large cards

- **WHEN** a tool is marked as favorite
- **THEN** that tool's card SHALL be displayed at large size (spanning 2 columns)

#### Scenario: Non-favorited tools display as medium or small cards

- **WHEN** a tool is not marked as favorite
- **THEN** that tool's card SHALL be displayed at medium or small size based on the Bento layout algorithm

### Requirement: Tool cards with gradient backgrounds

Each tool card on the home page SHALL display a gradient background using the tool's designated color. In light mode, the gradient SHALL use the tool color at 30% opacity transitioning to 10% opacity. In dark mode, the gradient SHALL use 40% opacity transitioning to 15% opacity. The card SHALL display the tool icon and name over the gradient background.

#### Scenario: Tool card displays gradient in light mode

- **WHEN** the app is in light mode
- **THEN** each tool card SHALL show a top-to-bottom gradient from toolColor at 0.3 opacity to toolColor at 0.1 opacity

#### Scenario: Tool card displays gradient in dark mode

- **WHEN** the app is in dark mode
- **THEN** each tool card SHALL show a top-to-bottom gradient from toolColor at 0.4 opacity to toolColor at 0.15 opacity

### Requirement: Search bar filters Bento Grid

The search bar SHALL remain at the top of the home page. When the user types a search query, the Bento Grid SHALL filter to show only matching tools. The Bento layout SHALL recalculate card sizes for the filtered set.

#### Scenario: User searches and Bento Grid updates

- **WHEN** user types a query in the search bar
- **THEN** the Bento Grid SHALL display only tools whose name contains the query, with the layout recalculated for the filtered set

### Requirement: Mini preview on large cards

Large cards (favorited tools) SHALL display a mini preview relevant to the tool's function when space permits. The mini preview SHALL be lightweight and non-interactive.

#### Scenario: Large calculator card shows last result

- **WHEN** calculator is favorited and displayed as a large card
- **THEN** the card SHALL show a mini preview of the last calculation result if available

#### Scenario: Large compass card shows current heading

- **WHEN** compass is favorited and displayed as a large card
- **THEN** the card SHALL show a mini preview of the current compass heading if sensor data is available
