## ADDED Requirements

### Requirement: Camera color picking

The color picker SHALL use the device camera to capture colors in real-time. A crosshair indicator SHALL show the target pixel, and the color at that pixel SHALL be displayed.

#### Scenario: User picks a color from camera

- **WHEN** user points the camera at a colored surface
- **THEN** the color at the crosshair position SHALL be displayed with its HEX and RGB values

### Requirement: Color value display

The color picker SHALL display the selected color in both HEX (e.g., #FF5733) and RGB (e.g., 255, 87, 51) formats. Users SHALL be able to copy either format with one tap.

#### Scenario: User copies color value

- **WHEN** user taps the HEX or RGB value
- **THEN** the value SHALL be copied to the clipboard with a confirmation message

### Requirement: Color history palette

The color picker SHALL maintain a history of recently picked colors (up to 20 entries). Users SHALL be able to tap a history entry to view its details.

#### Scenario: User picks multiple colors

- **WHEN** user picks a new color
- **THEN** the color SHALL be added to the history palette

#### Scenario: User views a color from history

- **WHEN** user taps a color in the history palette
- **THEN** the color details (HEX, RGB) SHALL be displayed
