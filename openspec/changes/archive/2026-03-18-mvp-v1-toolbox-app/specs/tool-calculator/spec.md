## ADDED Requirements

### Requirement: Basic arithmetic operations

The calculator SHALL support addition, subtraction, multiplication, and division. The calculator SHALL support decimal point input and parentheses for operation grouping. The calculator SHALL respect standard operator precedence.

#### Scenario: User performs a calculation

- **WHEN** user inputs "2 + 3 × 4" and presses equals
- **THEN** the result SHALL display "14" (multiplication before addition)

#### Scenario: User uses parentheses

- **WHEN** user inputs "(2 + 3) × 4" and presses equals
- **THEN** the result SHALL display "20"

### Requirement: Calculation history

The calculator SHALL maintain a history of calculations during the current session. Users SHALL be able to view and clear the history.

#### Scenario: User views calculation history

- **WHEN** user has performed multiple calculations
- **THEN** the history list SHALL show previous expressions and their results

#### Scenario: User clears history

- **WHEN** user taps the clear history button
- **THEN** all history entries SHALL be removed

### Requirement: Calculator display

The calculator SHALL display the current input expression and the result. The calculator SHALL provide a clear button (C) to reset the current input and a backspace button to delete the last character.

#### Scenario: User clears the display

- **WHEN** user taps the C button
- **THEN** the current expression and result SHALL be cleared to initial state
