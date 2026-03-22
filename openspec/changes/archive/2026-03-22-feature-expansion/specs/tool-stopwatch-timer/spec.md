## MODIFIED Requirements

### Requirement: Countdown timer

The timer SHALL allow users to set a countdown duration (hours, minutes, seconds). When the countdown reaches zero, the timer SHALL play a completion sound effect using the `audioplayers` package and SHALL send a local notification using `flutter_local_notifications` if the app is in the background. The completion sound SHALL be a short alert tone bundled as an app asset. In the foreground, only the sound effect SHALL play without a notification.

#### Scenario: Timer reaches zero in foreground

- **WHEN** the countdown timer reaches 00:00:00 while the app is in the foreground
- **THEN** a completion sound effect SHALL play and the timer SHALL display a completion indicator

#### Scenario: Timer reaches zero in background

- **WHEN** the countdown timer reaches 00:00:00 while the app is in the background
- **THEN** a local notification SHALL be sent to alert the user that the timer has completed

#### Scenario: User sets and starts a timer

- **WHEN** user sets a duration and taps start
- **THEN** the timer SHALL count down from the set duration

## ADDED Requirements

### Requirement: Timer notification scheduling

When the user starts a countdown timer, the system SHALL schedule a local notification for the exact time the timer will reach zero. If the user cancels or resets the timer before it completes, the scheduled notification SHALL be cancelled.

#### Scenario: Timer is cancelled before completion

- **WHEN** user starts a 5-minute timer and then cancels it after 2 minutes
- **THEN** the previously scheduled local notification SHALL be cancelled

#### Scenario: Timer notification is scheduled on start

- **WHEN** user starts a countdown timer with a duration of 10 minutes
- **THEN** a local notification SHALL be scheduled to fire exactly 10 minutes from the start time
