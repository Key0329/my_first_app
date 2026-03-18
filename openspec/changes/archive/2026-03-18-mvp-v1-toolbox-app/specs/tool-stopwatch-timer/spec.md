## ADDED Requirements

### Requirement: Stopwatch functionality

The stopwatch SHALL provide start, stop, and reset controls. The display SHALL show elapsed time in HH:MM:SS.mm format.

#### Scenario: User starts and stops the stopwatch

- **WHEN** user taps start, waits, then taps stop
- **THEN** the elapsed time SHALL be displayed and frozen

### Requirement: Lap recording

The stopwatch SHALL allow users to record lap times while running. Each lap SHALL show the lap number, lap time, and total time.

#### Scenario: User records a lap

- **WHEN** user taps the lap button while the stopwatch is running
- **THEN** a new lap entry SHALL be added to the lap list with the current lap time

### Requirement: Countdown timer

The timer SHALL allow users to set a countdown duration (hours, minutes, seconds). When the countdown reaches zero, the timer SHALL play an alarm sound.

#### Scenario: Timer reaches zero

- **WHEN** the countdown timer reaches 00:00:00
- **THEN** an alarm sound SHALL play and the timer SHALL display a completion indicator

#### Scenario: User sets and starts a timer

- **WHEN** user sets a duration and taps start
- **THEN** the timer SHALL count down from the set duration
