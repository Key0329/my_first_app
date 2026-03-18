## ADDED Requirements

### Requirement: Compass heading display

The compass SHALL use the device magnetometer to display the current heading in degrees (0-360°). The compass SHALL display a rotating compass dial that points to magnetic north.

#### Scenario: User faces north

- **WHEN** user points the device toward magnetic north
- **THEN** the compass SHALL display approximately 0° / 360° and the dial SHALL indicate north

### Requirement: Cardinal direction display

The compass SHALL display the current cardinal direction (N, NE, E, SE, S, SW, W, NW) based on the heading.

#### Scenario: User faces east

- **WHEN** the heading is approximately 90°
- **THEN** the compass SHALL display "E" as the cardinal direction
