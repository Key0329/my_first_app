## ADDED Requirements

### Requirement: Total amount and participant count input

The split bill calculator SHALL accept a total amount via a text field with numeric keyboard and a participant count adjustable via increment/decrement buttons. The minimum participant count SHALL be 2 and the maximum SHALL be 30.

#### Scenario: User enters total amount and adjusts participant count

- **WHEN** user enters a total amount and sets participant count to N
- **THEN** the system SHALL display the per-person amount calculated as total / N

#### Scenario: User attempts to decrease below minimum

- **WHEN** user taps the decrement button when participant count is 2
- **THEN** the decrement button SHALL be disabled and the count SHALL remain at 2

### Requirement: Equal split calculation with remainder handling

The system SHALL calculate equal split amounts. When the total amount does not divide evenly, the first participant SHALL pay the remainder. All amounts SHALL be rounded to integer (whole dollar).

#### Scenario: Amount divides evenly

- **WHEN** total is 900 and participants is 3
- **THEN** each person SHALL pay 300

#### Scenario: Amount does not divide evenly

- **WHEN** total is 100 and participants is 3
- **THEN** the first person SHALL pay 34 and the remaining 2 people SHALL each pay 33

#### Scenario: Total is zero or empty

- **WHEN** total amount field is empty or zero
- **THEN** the per-person amount SHALL display 0

### Requirement: Summary display in header

The header area SHALL display a summary showing the total amount and participant count in the format "$ {total} ÷ {count}".

#### Scenario: User views split summary

- **WHEN** user has entered 1500 as total and 3 as participant count
- **THEN** the header SHALL display "$1,500 ÷ 3 人"

### Requirement: ImmersiveToolScaffold integration

The split bill page SHALL use ImmersiveToolScaffold with tool color `Color(0xFF26A69A)`, icon `Icons.groups`, and Hero animation tag `tool_hero_split_bill`.

#### Scenario: User opens split bill from home page

- **WHEN** user taps the split bill card on the home page
- **THEN** the tool page SHALL open with a Hero transition animation using ImmersiveToolScaffold layout
