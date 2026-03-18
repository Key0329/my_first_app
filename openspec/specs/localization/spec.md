# localization Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: Multi-language support

The app SHALL support two locales: Traditional Chinese (zh_TW) as the default and English (en). All user-facing strings SHALL be localized using Flutter's official internationalization mechanism (flutter_localizations + ARB files).

#### Scenario: App displays in Traditional Chinese by default

- **WHEN** the user's device locale is zh_TW or the user has not changed the language setting
- **THEN** all UI strings SHALL be displayed in Traditional Chinese

#### Scenario: App displays in English

- **WHEN** the user selects English in settings
- **THEN** all UI strings SHALL be displayed in English


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
### Requirement: Locale persistence

The selected locale SHALL persist across app restarts using shared_preferences. If no locale has been explicitly selected, the app SHALL use the device's system locale if supported, or fall back to Traditional Chinese.

#### Scenario: Locale persists after restart

- **WHEN** user has selected a locale and restarts the app
- **THEN** the previously selected locale SHALL be applied on launch

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