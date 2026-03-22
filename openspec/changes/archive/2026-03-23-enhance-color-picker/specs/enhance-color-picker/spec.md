## ADDED Requirements

### Requirement: Pick color from gallery image

The tool SHALL allow users to select an image from the device gallery and pick colors by tapping on the image. A camera/gallery toggle button SHALL switch between live camera mode and gallery image mode.

#### Scenario: User picks color from gallery image

- **WHEN** user selects a gallery image and taps on a position in the image
- **THEN** the color at that position SHALL be extracted and added to the history

### Requirement: Persistent color history

The color pick history SHALL persist across app sessions using SharedPreferences. The history SHALL load on page entry and save on every change (add/clear).

#### Scenario: History persists after leaving and returning

- **WHEN** user picks colors, leaves the page, and returns
- **THEN** the previously picked colors SHALL still appear in the history

### Requirement: HSL color format display

The tool SHALL display the HSL (Hue, Saturation, Lightness) values alongside HEX and RGB for each picked color.

#### Scenario: Color values show all three formats

- **WHEN** a color is selected or picked
- **THEN** HEX, RGB, and HSL values SHALL all be displayed
