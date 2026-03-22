## ADDED Requirements

### Requirement: Countdown timer accuracy

The countdown timer SHALL calculate remaining time based on actual elapsed time using a `Stopwatch` instance, rather than subtracting a fixed duration on each Timer.periodic tick. When the timer is started, a `Stopwatch` SHALL begin tracking elapsed time. The remaining time SHALL be computed as `totalDuration - stopwatch.elapsed` on each UI update tick. When paused, the system SHALL record the remaining duration. When resumed, a new `Stopwatch` SHALL start from zero, and remaining time SHALL be computed as `pausedRemaining - stopwatch.elapsed`. The timer SHALL complete within 1 second of the intended duration for timers up to 60 minutes.

#### Scenario: Timer completes within accuracy threshold

- **WHEN** user sets a 10-minute countdown timer and starts it
- **THEN** the timer SHALL complete within 1 second of the 10-minute mark

#### Scenario: Timer pause and resume preserves accuracy

- **WHEN** user pauses a running timer and resumes it
- **THEN** the remaining time SHALL continue from the paused value with the same accuracy guarantee

#### Scenario: Timer displays update smoothly

- **WHEN** the timer is running
- **THEN** the display SHALL update at approximately 100ms intervals showing the computed remaining time
