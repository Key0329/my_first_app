# tool-stopwatch-timer Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: Stopwatch functionality

The stopwatch SHALL provide start, stop, and reset controls. The display SHALL show elapsed time in HH:MM:SS.mm format.

#### Scenario: User starts and stops the stopwatch

- **WHEN** user taps start, waits, then taps stop
- **THEN** the elapsed time SHALL be displayed and frozen


<!-- @trace
source: mvp-v1-toolbox-app
updated: 2026-03-18
code:
  - lib/tools/invoice_checker/invoice_parser.dart
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/tools/unit_converter/units_data.dart
  - lib/pages/home_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - windows/flutter/generated_plugins.cmake
  - pubspec.lock
  - lib/l10n/l10n.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_zh.arb
  - lib/services/settings_service.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - lib/l10n/app_en.arb
  - lib/pages/settings_page.dart
  - lib/tools/level/level_page.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_page.dart
  - l10n.yaml
  - lib/models/tool_item.dart
  - lib/app.dart
  - lib/pages/favorites_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/theme/app_theme.dart
  - lib/main.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - pubspec.yaml
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_card.dart
  - lib/tools/calculator/calculator_logic.dart
  - lib/tools/calculator/calculator_page.dart
  - ios/Runner/Info.plist
tests:
  - test/widget_test.dart
  - test/tools/calculator_logic_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/unit_converter_test.dart
  - test/tools/stopwatch_timer_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: Lap recording

The stopwatch SHALL allow users to record lap times while running. Each lap SHALL show the lap number, lap time, and total time.

#### Scenario: User records a lap

- **WHEN** user taps the lap button while the stopwatch is running
- **THEN** a new lap entry SHALL be added to the lap list with the current lap time


<!-- @trace
source: mvp-v1-toolbox-app
updated: 2026-03-18
code:
  - lib/tools/invoice_checker/invoice_parser.dart
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/tools/unit_converter/units_data.dart
  - lib/pages/home_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - windows/flutter/generated_plugins.cmake
  - pubspec.lock
  - lib/l10n/l10n.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_zh.arb
  - lib/services/settings_service.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - lib/l10n/app_en.arb
  - lib/pages/settings_page.dart
  - lib/tools/level/level_page.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_page.dart
  - l10n.yaml
  - lib/models/tool_item.dart
  - lib/app.dart
  - lib/pages/favorites_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/theme/app_theme.dart
  - lib/main.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - pubspec.yaml
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_card.dart
  - lib/tools/calculator/calculator_logic.dart
  - lib/tools/calculator/calculator_page.dart
  - ios/Runner/Info.plist
tests:
  - test/widget_test.dart
  - test/tools/calculator_logic_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/unit_converter_test.dart
  - test/tools/stopwatch_timer_test.dart
  - test/services/settings_service_test.dart
-->

---
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


<!-- @trace
source: feature-expansion
updated: 2026-03-22
code:
  - lib/widgets/confirm_dialog.dart
  - lib/pages/settings_page.dart
  - lib/theme/design_tokens.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/l10n/app_zh.arb
  - CLAUDE.md
  - lib/tools/currency_converter/currency_api.dart
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - windows/flutter/generated_plugins.cmake
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/l10n/app_localizations_en.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/pages/tool_search_delegate.dart
  - linux/flutter/generated_plugins.cmake
  - lib/app.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/services/haptic_service.dart
  - lib/services/settings_service.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_logic.dart
  - .mcp.json
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_en.arb
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/models/tool_item.dart
  - lib/tools/compass/compass_logic.dart
  - lib/widgets/error_state.dart
  - lib/widgets/bouncing_button.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - pubspec.yaml
  - lib/pages/favorites_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/services/timer_notification_service.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/utils/platform_check.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/pages/onboarding_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/level/level_page.dart
  - lib/tools/compass/compass_page.dart
tests:
  - test/tools/flashlight_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/level_logic_test.dart
  - test/models/tool_item_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/pages/onboarding_page_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/currency_converter_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/services/recent_tools_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/widget_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/services/settings_service_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/widgets/tool_card_test.dart
  - test/tools/date_calculator_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/protractor_logic_test.dart
-->

---
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

<!-- @trace
source: critical-fixes
updated: 2026-03-22
code:
  - lib/pages/tool_search_delegate.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/home_page.dart
  - lib/tools/calculator/calculator_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/utils/platform_check.dart
tests:
  - test/pages/tool_search_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/calculator_page_test.dart
  - test/utils/platform_check_test.dart
-->

---
### Requirement: Timer notification scheduling

When the user starts a countdown timer, the system SHALL schedule a local notification for the exact time the timer will reach zero. If the user cancels or resets the timer before it completes, the scheduled notification SHALL be cancelled.

#### Scenario: Timer is cancelled before completion

- **WHEN** user starts a 5-minute timer and then cancels it after 2 minutes
- **THEN** the previously scheduled local notification SHALL be cancelled

#### Scenario: Timer notification is scheduled on start

- **WHEN** user starts a countdown timer with a duration of 10 minutes
- **THEN** a local notification SHALL be scheduled to fire exactly 10 minutes from the start time

<!-- @trace
source: feature-expansion
updated: 2026-03-22
code:
  - lib/widgets/confirm_dialog.dart
  - lib/pages/settings_page.dart
  - lib/theme/design_tokens.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/l10n/app_zh.arb
  - CLAUDE.md
  - lib/tools/currency_converter/currency_api.dart
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - windows/flutter/generated_plugins.cmake
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/l10n/app_localizations_en.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/pages/tool_search_delegate.dart
  - linux/flutter/generated_plugins.cmake
  - lib/app.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/services/haptic_service.dart
  - lib/services/settings_service.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_logic.dart
  - .mcp.json
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_en.arb
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/models/tool_item.dart
  - lib/tools/compass/compass_logic.dart
  - lib/widgets/error_state.dart
  - lib/widgets/bouncing_button.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - pubspec.yaml
  - lib/pages/favorites_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/services/timer_notification_service.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/l10n/app_localizations_zh.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/utils/platform_check.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/pages/onboarding_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/level/level_page.dart
  - lib/tools/compass/compass_page.dart
tests:
  - test/tools/flashlight_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/level_logic_test.dart
  - test/models/tool_item_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/pages/onboarding_page_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/currency_converter_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/services/recent_tools_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/widget_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/services/settings_service_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/widgets/tool_card_test.dart
  - test/tools/date_calculator_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/protractor_logic_test.dart
-->