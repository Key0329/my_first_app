## MODIFIED Requirements

### Requirement: Countdown timer

The countdown timer SHALL support manual time input and quick-set time buttons (3min, 5min, 10min, 15min, 30min). Quick-set buttons SHALL set the duration and start the countdown with a single tap. When the countdown reaches zero, a "Repeat" button SHALL appear to restart with the same duration.

#### Scenario: Quick-set timer

- **WHEN** user taps a quick-set button (e.g., 5min)
- **THEN** the timer SHALL set to 5:00 and begin countdown

#### Scenario: Timer repeat after completion

- **WHEN** the countdown reaches 0:00
- **THEN** a Repeat button SHALL appear to restart the same duration

### Requirement: Lap recording

The stopwatch SHALL record lap times with lap/split display. A copy button SHALL be available to export all lap records as formatted text to the clipboard.

#### Scenario: User exports laps to clipboard

- **WHEN** user taps the lap export button
- **THEN** all lap records SHALL be copied as formatted text
