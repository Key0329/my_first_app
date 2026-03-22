## ADDED Requirements

### Requirement: Calculator button semantics

Each calculator button SHALL be wrapped in a Semantics widget with `button: true` and a descriptive `label` property. Operator buttons SHALL have labels describing their function (e.g., "addition", "subtraction", "equals", "clear"). Digit buttons SHALL have labels matching their digit value. The semantic labels SHALL be localized.

#### Scenario: Screen reader announces calculator button function

- **WHEN** a screen reader focuses on the addition operator button
- **THEN** the button SHALL be announced with its semantic label "addition" (or localized equivalent) and identified as a button

#### Scenario: Screen reader announces digit button

- **WHEN** a screen reader focuses on a digit button (e.g., "7")
- **THEN** the button SHALL be announced with its digit value and identified as a button

### Requirement: Noise meter value semantics

The noise meter's current dB reading display SHALL be wrapped in a Semantics widget with `value` set to the current dB reading including the unit, and `liveRegion: true` so screen readers announce value changes automatically. The semantic label SHALL describe the reading (e.g., "current noise level").

#### Scenario: Screen reader announces dB value changes

- **WHEN** the noise meter updates its dB reading
- **THEN** the screen reader SHALL automatically announce the new value because the Semantics widget has liveRegion set to true

#### Scenario: Noise meter value includes unit in semantics

- **WHEN** a screen reader reads the noise meter value
- **THEN** the announced value SHALL include the numeric reading and the "dB" unit

### Requirement: Compass bearing semantics

The compass display SHALL include a Semantics widget with a `label` describing the current bearing in a human-readable format (e.g., "North-East, 45 degrees"). The semantic label SHALL update as the bearing changes.

#### Scenario: Screen reader announces compass bearing

- **WHEN** a screen reader focuses on the compass display showing 45 degrees
- **THEN** it SHALL announce the bearing as the direction name and degree value

#### Scenario: Compass semantics update with rotation

- **WHEN** the device rotates and the compass bearing changes
- **THEN** the Semantics label SHALL update to reflect the new bearing direction and degree value

### Requirement: Protractor angle semantics

The protractor's angle display SHALL include a Semantics widget with a `value` property set to the current measured angle including the degree unit. The label SHALL describe the measurement (e.g., "measured angle").

#### Scenario: Screen reader announces protractor angle

- **WHEN** a screen reader focuses on the protractor angle display
- **THEN** it SHALL announce the measured angle value with the degree unit

#### Scenario: Protractor angle semantics update on measurement

- **WHEN** the user adjusts the protractor and the angle changes
- **THEN** the Semantics value SHALL update to reflect the new angle measurement
