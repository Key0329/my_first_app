## ADDED Requirements

### Requirement: Touch-based angle measurement

The protractor SHALL allow users to measure angles by dragging two arms from a center point on the screen. The angle between the two arms SHALL be displayed in degrees.

#### Scenario: User measures an angle

- **WHEN** user drags two arms to form an angle
- **THEN** the angle in degrees SHALL be displayed at the center point

### Requirement: Angle display

The protractor SHALL display the measured angle numerically (0-360°) and update in real-time as the user adjusts the arms.

#### Scenario: User adjusts the angle

- **WHEN** user drags one arm while the other remains fixed
- **THEN** the displayed angle SHALL update in real-time
