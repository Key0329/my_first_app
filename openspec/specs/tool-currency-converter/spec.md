# tool-currency-converter Specification

## Purpose

TBD - created by archiving change 'feature-expansion'. Update Purpose after archive.

## Requirements

### Requirement: Currency conversion with live rates

The tool SHALL fetch live exchange rates from the `frankfurter.app` API and allow users to convert between currencies. The user SHALL be able to select a source currency and a target currency from a list of supported currencies, enter an amount, and see the converted result in real-time. The conversion result SHALL update automatically when the amount or selected currencies change. If a selected currency is not present in the fetched rates data, the tool SHALL throw an `ArgumentError` and display an error message to the user instead of silently producing incorrect results. The HTTP request SHALL have a timeout of 10 seconds. The currency selector SHALL display favorite currencies (TWD, USD, JPY, EUR) at the top, separated by a divider from alphabetically sorted remaining currencies.

#### Scenario: User converts currency

- **WHEN** user selects USD as source currency, EUR as target currency, and enters 100 as the amount
- **THEN** the converted amount in EUR SHALL display based on the fetched exchange rate

#### Scenario: Currency selector shows favorites first

- **WHEN** user opens the currency selector
- **THEN** TWD, USD, JPY, EUR SHALL appear at the top with a divider below


<!-- @trace
source: enhance-currency-converter
updated: 2026-03-23
code:
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_en.arb
  - lib/tools/currency_converter/currency_api.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/l10n/app_zh.arb
-->

---
### Requirement: Offline cache for exchange rates

The tool SHALL cache the most recently fetched exchange rates and their timestamp using `shared_preferences`. When the device has no network connectivity, the tool SHALL use the cached rates and display an "offline mode" indicator showing the cache age.

#### Scenario: Network unavailable with cached data

- **WHEN** user opens the currency converter tool without network connectivity and cached rates exist
- **THEN** the tool SHALL display the cached exchange rates and show an "offline mode" indicator with the timestamp of the cached data

#### Scenario: Network unavailable without cached data

- **WHEN** user opens the currency converter tool without network connectivity and no cached rates exist
- **THEN** the tool SHALL display an error message indicating that network connectivity is required for the first use


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
### Requirement: Currency swap

The tool SHALL provide a swap button that exchanges the source and target currencies. When tapped, the source currency SHALL become the target currency and vice versa, and the conversion result SHALL update immediately.

#### Scenario: User swaps currencies

- **WHEN** user has USD as source and EUR as target, then taps the swap button
- **THEN** EUR SHALL become the source currency and USD SHALL become the target currency, and the converted amount SHALL update accordingly

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