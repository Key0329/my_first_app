## ADDED Requirements

### Requirement: Persistent calculator history

The calculator SHALL persist calculation history entries across app restarts using SharedPreferences. Each entry SHALL contain the expression, result, and timestamp. The history SHALL store a maximum of 100 entries; when the limit is exceeded, the oldest entries SHALL be removed. The history SHALL be loaded when the calculator page initializes and saved after each new calculation.

#### Scenario: History persists across app restarts

- **WHEN** the user performs calculations, closes the app, and reopens the calculator
- **THEN** the previously calculated entries SHALL be displayed in the history list

#### Scenario: History enforces 100-entry limit

- **WHEN** the history contains 100 entries and a new calculation is performed
- **THEN** the oldest entry SHALL be removed and the new entry SHALL be added at the top

#### Scenario: History is cleared

- **WHEN** the user taps the clear history button
- **THEN** all persisted history entries SHALL be removed from both memory and storage

### Requirement: Calculator history search

The calculator history list SHALL support search functionality. The user SHALL be able to enter a search query that filters history entries by matching against the expression or result fields (case-insensitive substring match). The search results SHALL update in real-time as the user types.

#### Scenario: User searches history by expression

- **WHEN** the user types "123" in the history search field
- **THEN** only history entries whose expression or result contains "123" SHALL be displayed

#### Scenario: Empty search shows all history

- **WHEN** the search field is empty
- **THEN** all history entries SHALL be displayed
