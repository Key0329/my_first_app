## ADDED Requirements

### Requirement: Tip percentage option

The split bill tool SHALL provide tip percentage selection with options: 0%, 5%, 10%, 15%, 20%. The selected tip percentage SHALL be applied to the original total amount before splitting. The tip amount and final total (original + tip) SHALL be displayed in the results.

#### Scenario: User adds 10% tip

- **WHEN** user enters 1000 as total and selects 10% tip with 2 people
- **THEN** tip amount 100 SHALL display, final total 1100, each person pays 550

### Requirement: Ratio-based split mode

The tool SHALL provide a ratio-based split mode where each participant has an adjustable ratio value. The total amount (including tip if applicable) SHALL be distributed proportionally based on the ratios.

#### Scenario: User splits by ratio

- **WHEN** user enters 4000 as total with 3 people at ratios 1:2:1
- **THEN** person 1 pays 1000, person 2 pays 2000, person 3 pays 1000

### Requirement: Multi-item split mode

The tool SHALL provide a multi-item mode where users can add multiple items, each with a name, amount, and participant count. Each item SHALL be split equally among its participants. The tool SHALL display a summary showing each person's total across all items.

#### Scenario: User adds multiple items

- **WHEN** user adds item A (600, 3 people) and item B (400, 2 people)
- **THEN** item A shows 200 per person, item B shows 200 per person
- **AND** a summary shows each person's combined total

### Requirement: Mode switching

The tool SHALL provide a mode selector (SegmentedButton) with three modes: Equal Split, Ratio Split, and Multi-Item. Switching modes SHALL preserve the total amount and participant count where applicable.

#### Scenario: User switches between modes

- **WHEN** user switches from equal split to ratio split
- **THEN** the total amount and participant count SHALL carry over
- **AND** the UI SHALL update to show ratio inputs
