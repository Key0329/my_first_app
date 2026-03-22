## MODIFIED Requirements

### Requirement: Color value display

The tool SHALL display the picked color with its HEX, RGB, and HSL values. Users SHALL be able to copy any color value to the clipboard. The HSL format SHALL show Hue (0-360), Saturation (0-100%), and Lightness (0-100%).

#### Scenario: Color values show all three formats

- **WHEN** a color is selected or picked
- **THEN** HEX, RGB, and HSL values SHALL all be displayed

### Requirement: Color history palette

The color pick history SHALL persist across app sessions using SharedPreferences. The history SHALL load on page entry and save on every addition or clear operation. The maximum history size SHALL be 20 entries.

#### Scenario: History persists after leaving and returning

- **WHEN** user picks colors, leaves the page, and returns
- **THEN** the previously picked colors SHALL still appear in the history palette
