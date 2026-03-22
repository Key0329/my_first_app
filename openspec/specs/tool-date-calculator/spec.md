# tool-date-calculator Specification

## Purpose

TBD - created by archiving change 'feature-expansion'. Update Purpose after archive.

## Requirements

### Requirement: Date interval calculation

The tool SHALL allow users to select two dates and calculate the interval between them. The result SHALL display the difference in days, weeks, and months. Date selection SHALL use the Material `showDatePicker` widget.

#### Scenario: User calculates interval between two dates

- **WHEN** user selects January 1, 2026 as the start date and March 22, 2026 as the end date
- **THEN** the tool SHALL display the interval as 80 days, 11 weeks and 3 days, and 2 months and 21 days

#### Scenario: Start date is after end date

- **WHEN** user selects a start date that is after the end date
- **THEN** the tool SHALL still calculate and display the absolute interval between the two dates


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
### Requirement: Add or subtract days from date

The tool SHALL allow users to select a base date and enter a number of days to add or subtract. The result SHALL display the calculated target date.

#### Scenario: User adds days to a date

- **WHEN** user selects March 1, 2026 as the base date and enters 30 days to add
- **THEN** the tool SHALL display March 31, 2026 as the target date

#### Scenario: User subtracts days from a date

- **WHEN** user selects March 22, 2026 as the base date and enters 10 days to subtract
- **THEN** the tool SHALL display March 12, 2026 as the target date


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
### Requirement: Business days calculation

The tool SHALL allow users to calculate the number of business days (excluding Saturdays and Sundays) between two selected dates. The result SHALL display both the total calendar days and the business days count.

#### Scenario: User calculates business days

- **WHEN** user selects Monday March 2, 2026 as the start date and Friday March 13, 2026 as the end date
- **THEN** the tool SHALL display 11 total calendar days and 10 business days

#### Scenario: Range includes weekends

- **WHEN** user selects a date range that spans across two weekends
- **THEN** the business days count SHALL exclude all Saturdays and Sundays within the range

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