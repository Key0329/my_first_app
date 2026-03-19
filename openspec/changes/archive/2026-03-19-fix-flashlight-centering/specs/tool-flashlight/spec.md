## MODIFIED Requirements

### Requirement: Flashlight toggle

The flashlight SHALL provide a prominent on/off toggle button that is horizontally centered on the page. The device camera flash LED SHALL turn on when activated and off when deactivated. All UI elements (toggle button, status text, SOS button) SHALL be horizontally centered within the page.

#### Scenario: User turns on the flashlight

- **WHEN** user taps the flashlight toggle button
- **THEN** the device flash LED SHALL turn on

#### Scenario: User turns off the flashlight

- **WHEN** user taps the toggle button while the flashlight is on
- **THEN** the device flash LED SHALL turn off

#### Scenario: UI elements are horizontally centered

- **WHEN** the flashlight page is displayed on any screen size
- **THEN** the toggle button, status text, and SOS button SHALL be horizontally centered within the viewport
