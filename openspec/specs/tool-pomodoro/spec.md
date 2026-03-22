# tool-pomodoro Specification

## Purpose

TBD - created by archiving change 'tool-pomodoro'. Update Purpose after archive.

## Requirements

### Requirement: Pomodoro timer page

The system SHALL provide a "Pomodoro Timer" tool page accessible from the tool registry. The page SHALL display a countdown timer with circular progress indicator, phase information, and control buttons.

#### Scenario: Page renders with idle state

- **WHEN** user navigates to the pomodoro timer tool
- **THEN** the page SHALL display the default work duration (25:00), a "Start" button, and phase indicator showing "Work"


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Timer countdown

The system SHALL count down from the configured duration, updating the display every second.

#### Scenario: Timer counts down

- **WHEN** user taps the start button
- **THEN** the timer SHALL begin counting down from the configured work duration, updating the display every second

#### Scenario: Timer reaches zero

- **WHEN** the timer reaches 00:00
- **THEN** the system SHALL play a notification sound and automatically transition to the next phase


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Phase cycling

The system SHALL cycle through work and rest phases automatically. After every 4 work sessions, a long rest phase SHALL occur instead of a short rest.

#### Scenario: Work to short rest transition

- **WHEN** a work phase completes and fewer than 4 work sessions have been completed in the current cycle
- **THEN** the timer SHALL automatically switch to short rest phase (default 5 minutes)

#### Scenario: Work to long rest transition

- **WHEN** the 4th work phase in a cycle completes
- **THEN** the timer SHALL automatically switch to long rest phase (default 15 minutes) and reset the cycle counter

#### Scenario: Rest to work transition

- **WHEN** a rest phase (short or long) completes
- **THEN** the timer SHALL automatically switch to work phase


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Timer controls

The system SHALL provide start, pause, reset, and skip controls for the timer.

#### Scenario: Pause timer

- **WHEN** user taps the pause button during an active countdown
- **THEN** the timer SHALL pause at its current position and the button SHALL change to "Resume"

#### Scenario: Resume timer

- **WHEN** user taps the resume button while paused
- **THEN** the timer SHALL resume counting down from the paused position

#### Scenario: Reset timer

- **WHEN** user taps the reset button
- **THEN** the timer SHALL stop and reset to the beginning of the current phase

#### Scenario: Skip phase

- **WHEN** user taps the skip button
- **THEN** the system SHALL immediately transition to the next phase without counting the current phase as completed


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Customizable durations

The system SHALL allow users to customize work duration, short rest duration, and long rest duration.

#### Scenario: Change work duration

- **WHEN** user adjusts the work duration slider
- **THEN** the new duration SHALL apply to the next work phase (range: 1-60 minutes)

#### Scenario: Change rest duration

- **WHEN** user adjusts the rest duration slider
- **THEN** the new duration SHALL apply to the next rest phase (short rest range: 1-30 minutes, long rest range: 5-60 minutes)


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: White noise playback

The system SHALL provide built-in white noise audio options that can be played independently of the timer.

#### Scenario: Start white noise

- **WHEN** user selects a white noise option (rain, cafe, forest)
- **THEN** the selected audio SHALL begin playing in a continuous loop

#### Scenario: Stop white noise

- **WHEN** user deselects the active white noise option
- **THEN** audio playback SHALL stop immediately

#### Scenario: White noise independent of timer

- **WHEN** user plays white noise without starting the timer
- **THEN** the white noise SHALL play independently


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Focus statistics

The system SHALL track and display daily focus statistics including completed pomodoro count and total focus minutes. Statistics SHALL persist across app restarts using SharedPreferences.

#### Scenario: Increment on work completion

- **WHEN** a work phase completes normally (not skipped)
- **THEN** the today's pomodoro count SHALL increment by 1 and the focus minutes SHALL increase by the work duration

#### Scenario: Daily reset

- **WHEN** the app is opened on a new day
- **THEN** the daily statistics SHALL reset to zero

#### Scenario: Statistics display

- **WHEN** the pomodoro page is visible
- **THEN** today's completed pomodoro count and total focus minutes SHALL be displayed


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Phase completion notification

The system SHALL play an audio alert and display a local notification when a timer phase completes.

#### Scenario: Notification on phase end

- **WHEN** a timer phase reaches zero
- **THEN** the system SHALL play a short alert sound and show a local notification indicating the phase that ended and the next phase


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Tool registry integration

The pomodoro timer SHALL be registered in the tool registry with id `pomodoro`, route path `/pomodoro`, and category `life`.

#### Scenario: Tool appears on homepage

- **WHEN** user views the homepage tool grid
- **THEN** the pomodoro timer SHALL appear with appropriate icon and localized name


<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->

---
### Requirement: Internationalization support

The pomodoro timer SHALL support both Traditional Chinese and English through the existing i18n system.

#### Scenario: Chinese locale

- **WHEN** app locale is set to zh
- **THEN** all pomodoro UI text SHALL display in Traditional Chinese

#### Scenario: English locale

- **WHEN** app locale is set to en
- **THEN** all pomodoro UI text SHALL display in English

<!-- @trace
source: tool-pomodoro
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/l10n/app_localizations.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/audio/forest.mp3
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - assets/audio/rain.mp3
  - lib/theme/design_tokens.dart
  - lib/tools/pomodoro/pomodoro_timer.dart
  - pubspec.yaml
  - assets/audio/cafe.mp3
tests:
  - test/tools/pomodoro_widget_test.dart
  - test/tools/pomodoro_timer_test.dart
-->