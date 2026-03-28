## MODIFIED Requirements

### Requirement: Accent color selection

The system SHALL allow users to select an accent color from a set of predefined color options only if `ProService.isPro == true`. When `isPro == false`, the accent color section SHALL display each color swatch with a lock icon overlay and a Pro badge label. Tapping any locked swatch SHALL open `PaywallScreen`. The default purple accent (#6C5CE7) SHALL remain active for free users regardless of any prior selection.

#### Scenario: Default accent color (free user)

- **WHEN** user has not purchased Pro
- **THEN** the app SHALL use the default purple accent (#6C5CE7) and color swatches SHALL show lock overlays

#### Scenario: Default accent color (no prior selection, Pro user)

- **WHEN** Pro user has not selected an accent color
- **THEN** the app SHALL use the default purple accent (#6C5CE7)

#### Scenario: Select accent color (Pro user)

- **WHEN** Pro user selects a new accent color in settings
- **THEN** the app's global UI elements (AppBar, tabs, buttons) SHALL update to reflect the selected color

#### Scenario: Free user taps locked color swatch

- **WHEN** free user taps any non-default color swatch
- **THEN** `PaywallScreen` SHALL be presented as a modal
