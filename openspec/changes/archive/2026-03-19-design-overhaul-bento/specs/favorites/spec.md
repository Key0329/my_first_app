## MODIFIED Requirements

### Requirement: Add and remove favorites

Users SHALL be able to add a tool to favorites by long-pressing its card on the home page. A long press on a favorited tool SHALL remove it from favorites. The favorites list SHALL persist across app restarts using shared_preferences. When a tool is added to favorites, it SHALL be promoted to a large card in the Bento Grid layout on the home page. When removed from favorites, it SHALL return to medium or small size.

#### Scenario: User adds a tool to favorites

- **WHEN** user long-presses a tool card that is not in favorites
- **THEN** the tool SHALL be added to favorites and its card SHALL be promoted to large size in the Bento Grid

#### Scenario: User removes a tool from favorites

- **WHEN** user long-presses a tool card that is in favorites
- **THEN** the tool SHALL be removed from favorites and its card SHALL return to medium or small size in the Bento Grid
