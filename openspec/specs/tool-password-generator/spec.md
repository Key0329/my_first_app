# tool-password-generator Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: Password generation

The tool SHALL generate random passwords based on user-configured settings. It SHALL support two modes: character-based (existing) and memorable word-based. In character mode, users configure length and character types. In memorable mode, users set word count (3-6) and the tool generates hyphen-joined random words.

#### Scenario: Character-based generation

- **WHEN** user configures length and character types and taps generate
- **THEN** a random password matching the configuration SHALL be generated

#### Scenario: Memorable password generation

- **WHEN** user enables memorable mode and sets word count to 4
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
### Requirement: One-tap copy

The generator SHALL provide a one-tap copy button that copies the generated password to the clipboard. A confirmation message SHALL be shown after copying.

#### Scenario: User copies a password

- **WHEN** user taps the copy button
- **THEN** the password SHALL be copied to the clipboard and a confirmation snackbar SHALL appear


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
### Requirement: Password strength indicator

The generator SHALL display a visual strength indicator (weak, medium, strong, very strong) based on the configured password length and character types.

#### Scenario: User sees password strength

- **WHEN** a password is generated
- **THEN** a color-coded strength indicator SHALL reflect the password complexity

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
### Requirement: Password history storage

The password generator SHALL maintain a history of the last 20 generated passwords in SharedPreferences. Passwords SHALL be masked in the list by default and revealed on tap. A clear history button SHALL be provided.

#### Scenario: Password added to history

- **WHEN** a new password is generated
- **THEN** it SHALL appear at the top of the persistent history list

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