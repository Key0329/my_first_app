## ADDED Requirements

### Requirement: Level tool angle semantics

The level tool's angle display SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the current tilt angle including the degree unit. The label SHALL describe the measurement (e.g., "tilt angle").

#### Scenario: Screen reader announces level angle

- **WHEN** a screen reader focuses on the level tool angle display
- **THEN** it SHALL announce the tilt angle value with the degree unit

#### Scenario: Level angle updates announce automatically

- **WHEN** the device tilts and the level angle changes
- **THEN** the screen reader SHALL automatically announce the new value because the Semantics widget has liveRegion set to true

### Requirement: Flashlight toggle semantics

The flashlight toggle button SHALL include a Semantics widget with `label` describing its current state ("flashlight on" or "flashlight off") and `hint` describing the action ("double tap to toggle"). The toggled property SHALL reflect the current on/off state.

#### Scenario: Screen reader announces flashlight state

- **WHEN** a screen reader focuses on the flashlight toggle
- **THEN** it SHALL announce the current state label and the toggle hint

### Requirement: Screen ruler measurement semantics

The screen ruler's measurement display SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the current measurement including the unit (mm or inch).

#### Scenario: Screen reader announces ruler measurement

- **WHEN** the screen ruler displays a measurement of 45mm
- **THEN** the Semantics value SHALL be "45 mm" and it SHALL be announced automatically as a live region

### Requirement: Random wheel result semantics

The random wheel result overlay SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the selected result text, so screen readers announce the winner automatically.

#### Scenario: Screen reader announces wheel result

- **WHEN** the random wheel stops spinning and displays a result
- **THEN** the screen reader SHALL automatically announce the selected result text

### Requirement: Timer countdown semantics

The stopwatch/timer countdown display SHALL include a Semantics widget with a `value` property set to the remaining time in a human-readable format (e.g., "5 minutes 30 seconds remaining"). The Semantics SHALL NOT use liveRegion to avoid excessive announcements during countdown.

#### Scenario: Screen reader reads timer value

- **WHEN** a screen reader focuses on the timer countdown display showing 5:30
- **THEN** it SHALL announce "5 minutes 30 seconds remaining" (or localized equivalent)

### Requirement: Password generator result semantics

The password generator's generated password display SHALL include a Semantics widget with a `value` property set to the generated password spelled out character by character for screen reader users, and a `label` of "generated password".

#### Scenario: Screen reader reads generated password

- **WHEN** a screen reader focuses on the generated password display
- **THEN** it SHALL announce "generated password" as the label followed by the password value

### Requirement: QR code result semantics

The QR scanner's decoded result display SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the decoded text, so screen readers announce scan results automatically.

#### Scenario: Screen reader announces QR scan result

- **WHEN** the QR scanner decodes a QR code and displays the result
- **THEN** the screen reader SHALL automatically announce the decoded text
