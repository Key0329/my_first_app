## MODIFIED Requirements

### Requirement: Total amount and participant count input

The split bill calculator SHALL accept a total amount via a text field with numeric keyboard and a participant count adjustable via increment/decrement buttons. The minimum participant count SHALL be 2 and the maximum SHALL be 30. The tool SHALL additionally support tip percentage selection and mode switching between equal split, ratio split, and multi-item split.

#### Scenario: User enters total amount and adjusts participant count

- **WHEN** user enters a total amount and sets participant count to N
- **THEN** the per-person amount SHALL update automatically based on the selected mode

#### Scenario: User selects tip percentage

- **WHEN** user selects a non-zero tip percentage
- **THEN** the tip amount SHALL be added to the total before splitting
