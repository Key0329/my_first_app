# enhance-life-tools Specification

## Purpose

TBD - created by archiving change 'enhance-life-tools'. Update Purpose after archive.

## Requirements

### Requirement: Timer quick-set buttons

The stopwatch timer tool SHALL provide quick-set time buttons (3min, 5min, 10min, 15min, 30min) that set the timer duration and start countdown with a single tap.

#### Scenario: User taps quick-set button

- **WHEN** user taps the "5min" quick-set button
- **THEN** the timer SHALL set to 5:00 and begin countdown immediately


<!-- @trace
source: enhance-life-tools
updated: 2026-03-23
code:
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
tests:
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Timer repeat button

When the timer countdown reaches zero, the tool SHALL display a "Repeat" button that restarts the timer with the same duration as the previous countdown.

#### Scenario: Timer finishes and user taps repeat

- **WHEN** the timer reaches 0:00 after a 5-minute countdown
- **THEN** a "Repeat" button SHALL appear
- **AND** tapping it SHALL restart a new 5-minute countdown


<!-- @trace
source: enhance-life-tools
updated: 2026-03-23
code:
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
tests:
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Lap record export

The stopwatch tool SHALL provide a copy button to export all lap records as formatted text to the clipboard.

#### Scenario: User exports laps

- **WHEN** user taps the lap export button with 3 recorded laps
- **THEN** the formatted lap text SHALL be copied to the clipboard


<!-- @trace
source: enhance-life-tools
updated: 2026-03-23
code:
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
tests:
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Password history

The password generator SHALL store the last 20 generated passwords in SharedPreferences. Passwords in the history list SHALL be masked by default and revealed on tap. A clear history button SHALL be provided.

#### Scenario: Generated password appears in history

- **WHEN** user generates a new password
- **THEN** it SHALL be added to the top of the history list


<!-- @trace
source: enhance-life-tools
updated: 2026-03-23
code:
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
tests:
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Memorable password mode

The password generator SHALL provide a "Memorable" toggle that generates word-based passwords (e.g., tiger-cloud-river-moon). When enabled, a word count slider (3-6) SHALL replace the character type options.

#### Scenario: User enables memorable mode

- **WHEN** user toggles memorable mode on and sets word count to 4
- **THEN** a password of 4 random words joined by hyphens SHALL be generated


<!-- @trace
source: enhance-life-tools
updated: 2026-03-23
code:
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
tests:
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: QR code type templates

The QR generator SHALL support multiple QR code types via a mode selector: Text (existing), WiFi (SSID + password + encryption), and Email (recipient + subject + body). Each type SHALL generate the appropriate encoded format.

#### Scenario: User generates WiFi QR code

- **WHEN** user selects WiFi mode and enters SSID "MyNet" with password "pass123"
- **THEN** the QR code SHALL encode the string in WIFI format

<!-- @trace
source: enhance-life-tools
updated: 2026-03-23
code:
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
tests:
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/qr_generator_test.dart
-->