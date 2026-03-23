## ADDED Requirements

### Requirement: Accent color selection

The system SHALL allow users to select an accent color from a set of predefined color options. The selected color SHALL be applied across the app's global UI elements.

#### Scenario: Default accent color

- **WHEN** user has not selected an accent color
- **THEN** the app SHALL use the default purple accent (#6C5CE7)

#### Scenario: Select accent color

- **WHEN** user selects a new accent color in settings
- **THEN** the app's global UI elements (AppBar, tabs, buttons) SHALL update to reflect the selected color

### Requirement: Accent color options

The system SHALL provide 6 predefined accent color options: purple (default), blue, green, red, orange, and pink.

#### Scenario: Six color options displayed

- **WHEN** user opens the accent color setting
- **THEN** 6 color circles SHALL be displayed for selection

### Requirement: Accent color persistence

The selected accent color SHALL persist across app restarts using SharedPreferences.

#### Scenario: Color persists after restart

- **WHEN** user selects an accent color and restarts the app
- **THEN** the previously selected color SHALL be applied

### Requirement: Accent color in settings page

The settings page SHALL display an accent color picker section with circular color swatches.

#### Scenario: Settings color picker

- **WHEN** user navigates to settings
- **THEN** an "Accent Color" section SHALL display with tappable color circles

#### Scenario: Selected color indicator

- **WHEN** a color is currently selected
- **THEN** the selected color circle SHALL display a check mark overlay

### Requirement: Theme color i18n

All theme color UI text SHALL support both Traditional Chinese and English.

#### Scenario: Chinese locale

- **WHEN** app locale is zh
- **THEN** accent color UI text SHALL display in Traditional Chinese

#### Scenario: English locale

- **WHEN** app locale is en
- **THEN** accent color UI text SHALL display in English
