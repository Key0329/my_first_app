## ADDED Requirements

### Requirement: Tool relation graph

The app SHALL maintain a static map of tool relationships where each tool ID maps to an ordered list of 1-2 recommended related tool IDs. The relation graph SHALL cover all tools defined in the app. If a tool has no explicitly defined relations, the system SHALL fall back to recommending tools from the same category.

#### Scenario: Tool has explicit relations

- **WHEN** the relation graph is queried for tool "calculator"
- **THEN** it SHALL return the defined related tool IDs (e.g., "unit_converter", "currency_converter")

#### Scenario: Tool falls back to same category

- **WHEN** a tool has no explicitly defined relations in the graph
- **THEN** the system SHALL return up to 2 other tools from the same category

### Requirement: Recommendation bar in tool pages

The `ImmersiveToolScaffold` SHALL accept an optional `toolId` parameter. When provided, the scaffold SHALL render a `ToolRecommendationBar` at the bottom of the body area displaying recommended tools from the relation graph. Each recommendation SHALL show the tool icon and name as a tappable chip. Tapping a recommendation chip SHALL navigate to the corresponding tool page.

#### Scenario: Tool page shows recommendations

- **WHEN** a tool page provides its `toolId` to the scaffold
- **THEN** the scaffold SHALL display a recommendation bar at the bottom with 1-2 related tool chips

#### Scenario: User taps a recommendation chip

- **WHEN** the user taps a recommended tool chip
- **THEN** the app SHALL navigate to that tool's page

#### Scenario: No toolId provided

- **WHEN** a tool page does not provide `toolId` to the scaffold
- **THEN** no recommendation bar SHALL be displayed
