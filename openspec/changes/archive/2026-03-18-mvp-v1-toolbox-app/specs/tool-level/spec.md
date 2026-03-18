## ADDED Requirements

### Requirement: Level detection

The level SHALL use the device accelerometer to detect horizontal and vertical orientation. The level SHALL display the current angle in degrees.

#### Scenario: Device is placed on a flat surface

- **WHEN** the device is on a perfectly flat surface
- **THEN** the level SHALL display 0° and indicate the surface is level

#### Scenario: Device is tilted

- **WHEN** the device is tilted at an angle
- **THEN** the level SHALL display the tilt angle and visually indicate the direction of tilt

### Requirement: Vibration feedback

The level SHALL provide haptic feedback when the device reaches a perfectly level position (0°).

#### Scenario: Device reaches level position

- **WHEN** the device angle reaches 0° (within ±0.5° tolerance)
- **THEN** the device SHALL vibrate briefly to indicate level
