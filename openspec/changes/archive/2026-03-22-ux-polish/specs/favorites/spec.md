## MODIFIED Requirements

### Requirement: Add and remove favorites

Users SHALL be able to add a tool to favorites by tapping the visible heart icon button on its card on the home page. A tap on the heart icon of a favorited tool SHALL remove it from favorites. Additionally, a long press on a tool card SHALL toggle the favorite status as a secondary interaction method. The favorites list SHALL persist across app restarts using shared_preferences. When a tool is added to favorites, it SHALL be promoted to a large card in the Bento Grid layout on the home page. When removed from favorites, it SHALL return to medium or small size. When the favorite status changes, a SnackBar SHALL be displayed with the message "Added to favorites" or "Removed from favorites" respectively.

#### Scenario: User adds a tool to favorites via heart button

- **WHEN** user taps the heart icon button on a tool card that is not in favorites
- **THEN** the tool SHALL be added to favorites, the heart icon SHALL change to a filled heart with brand color, a SnackBar SHALL display "Added to favorites", and the card SHALL be promoted to large size in the Bento Grid

#### Scenario: User removes a tool from favorites via heart button

- **WHEN** user taps the heart icon button on a tool card that is in favorites
- **THEN** the tool SHALL be removed from favorites, the heart icon SHALL change to an outline heart, a SnackBar SHALL display "Removed from favorites", and the card SHALL return to medium or small size in the Bento Grid

#### Scenario: User toggles favorites via long press

- **WHEN** user long-presses a tool card
- **THEN** the favorite status SHALL be toggled with the same behavior as tapping the heart button

## ADDED Requirements

### Requirement: Visible favorite heart button on tool cards

Each tool card on the home page and favorites page SHALL display a heart icon button in the top-right corner. The heart icon SHALL be `Icons.favorite` (filled) when the tool is favorited and `Icons.favorite_border` (outline) when not favorited. The favorited heart icon SHALL use the brand color. The heart button SHALL have an AnimatedScale animation on tap (scale to 1.2 then back to 1.0).

#### Scenario: Heart button is visible on all tool cards

- **WHEN** the home page displays tool cards
- **THEN** each tool card SHALL have a visible heart icon button in the top-right corner

#### Scenario: Heart button reflects favorite status

- **WHEN** a tool is in the favorites list
- **THEN** the heart icon on its card SHALL be displayed as a filled heart with brand color

#### Scenario: Heart button animates on tap

- **WHEN** user taps the heart icon button
- **THEN** the heart icon SHALL animate with a scale-up to 1.2 and spring back to 1.0
