## ADDED Requirements

### Requirement: Flashlight toggle

The flashlight SHALL provide a prominent on/off toggle button. The device camera flash LED SHALL turn on when activated and off when deactivated.

#### Scenario: User turns on the flashlight

- **WHEN** user taps the flashlight toggle button
- **THEN** the device flash LED SHALL turn on

#### Scenario: User turns off the flashlight

- **WHEN** user taps the toggle button while the flashlight is on
- **THEN** the device flash LED SHALL turn off

### Requirement: SOS mode

The flashlight SHALL provide an SOS mode that blinks the flash LED in the international SOS pattern (3 short, 3 long, 3 short).

#### Scenario: User activates SOS mode

- **WHEN** user taps the SOS button
- **THEN** the flash LED SHALL blink in the SOS pattern repeatedly until deactivated
