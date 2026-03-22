## ADDED Requirements

### Requirement: Date interval calculation

The tool SHALL allow users to select two dates and calculate the interval between them. The result SHALL display the difference in days, weeks, and months. Date selection SHALL use the Material `showDatePicker` widget.

#### Scenario: User calculates interval between two dates

- **WHEN** user selects January 1, 2026 as the start date and March 22, 2026 as the end date
- **THEN** the tool SHALL display the interval as 80 days, 11 weeks and 3 days, and 2 months and 21 days

#### Scenario: Start date is after end date

- **WHEN** user selects a start date that is after the end date
- **THEN** the tool SHALL still calculate and display the absolute interval between the two dates

### Requirement: Add or subtract days from date

The tool SHALL allow users to select a base date and enter a number of days to add or subtract. The result SHALL display the calculated target date.

#### Scenario: User adds days to a date

- **WHEN** user selects March 1, 2026 as the base date and enters 30 days to add
- **THEN** the tool SHALL display March 31, 2026 as the target date

#### Scenario: User subtracts days from a date

- **WHEN** user selects March 22, 2026 as the base date and enters 10 days to subtract
- **THEN** the tool SHALL display March 12, 2026 as the target date

### Requirement: Business days calculation

The tool SHALL allow users to calculate the number of business days (excluding Saturdays and Sundays) between two selected dates. The result SHALL display both the total calendar days and the business days count.

#### Scenario: User calculates business days

- **WHEN** user selects Monday March 2, 2026 as the start date and Friday March 13, 2026 as the end date
- **THEN** the tool SHALL display 11 total calendar days and 10 business days

#### Scenario: Range includes weekends

- **WHEN** user selects a date range that spans across two weekends
- **THEN** the business days count SHALL exclude all Saturdays and Sundays within the range
