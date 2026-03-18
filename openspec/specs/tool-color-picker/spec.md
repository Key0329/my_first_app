# tool-color-picker Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: Camera color picking

The color picker SHALL use the device camera to capture colors in real-time. A crosshair indicator SHALL show the target pixel, and the color at that pixel SHALL be displayed.

#### Scenario: User picks a color from camera

- **WHEN** user points the camera at a colored surface
- **THEN** the color at the crosshair position SHALL be displayed with its HEX and RGB values


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
### Requirement: Color value display

The color picker SHALL display the selected color in both HEX (e.g., #FF5733) and RGB (e.g., 255, 87, 51) formats. Users SHALL be able to copy either format with one tap.

#### Scenario: User copies color value

- **WHEN** user taps the HEX or RGB value
- **THEN** the value SHALL be copied to the clipboard with a confirmation message


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
### Requirement: Color history palette

The color picker SHALL maintain a history of recently picked colors (up to 20 entries). Users SHALL be able to tap a history entry to view its details.

#### Scenario: User picks multiple colors

- **WHEN** user picks a new color
- **THEN** the color SHALL be added to the history palette

#### Scenario: User views a color from history

- **WHEN** user taps a color in the history palette
- **THEN** the color details (HEX, RGB) SHALL be displayed

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