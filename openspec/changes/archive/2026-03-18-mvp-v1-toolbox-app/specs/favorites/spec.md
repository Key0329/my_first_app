## ADDED Requirements

### Requirement: Add and remove favorites

Users SHALL be able to add a tool to favorites by long-pressing its card on the home page. A long press on a favorited tool SHALL remove it from favorites. The favorites list SHALL persist across app restarts using shared_preferences.

#### Scenario: User adds a tool to favorites

- **WHEN** user long-presses a tool card that is not in favorites
- **THEN** the tool SHALL be added to favorites and a visual indicator SHALL confirm the action

#### Scenario: User removes a tool from favorites

- **WHEN** user long-presses a tool card that is already in favorites
- **THEN** the tool SHALL be removed from favorites

### Requirement: Favorites page

The Favorites tab SHALL display all favorited tools in a grid layout identical to the home page. If no tools are favorited, a placeholder message SHALL be displayed.

#### Scenario: User views favorites

- **WHEN** user navigates to the Favorites tab
- **THEN** all favorited tools SHALL be displayed in a grid layout

#### Scenario: No favorites exist

- **WHEN** user navigates to the Favorites tab with no favorited tools
- **THEN** a placeholder message SHALL be displayed suggesting the user to add favorites

### Requirement: Favorites persistence

The favorites list SHALL be stored using shared_preferences and SHALL persist across app restarts.

#### Scenario: Favorites persist after restart

- **WHEN** user has favorited tools and restarts the app
- **THEN** the favorites list SHALL be restored from local storage
