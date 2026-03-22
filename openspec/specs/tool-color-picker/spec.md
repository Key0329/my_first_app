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

The tool SHALL display the picked color with its HEX, RGB, and HSL values. Users SHALL be able to copy any color value to the clipboard. The HSL format SHALL show Hue (0-360), Saturation (0-100%), and Lightness (0-100%).

#### Scenario: Color values show all three formats

- **WHEN** a color is selected or picked
- **THEN** HEX, RGB, and HSL values SHALL all be displayed


<!-- @trace
source: enhance-color-picker
updated: 2026-03-23
code:
  - linux/flutter/generated_plugins.cmake
  - pubspec.yaml
  - windows/flutter/generated_plugin_registrant.cc
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/color_picker/color_picker_page.dart
  - pubspec.lock
  - lib/l10n/app_en.arb
  - windows/flutter/generated_plugins.cmake
  - linux/flutter/generated_plugin_registrant.cc
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_en.dart
  - macos/Flutter/GeneratedPluginRegistrant.swift
-->

---
### Requirement: Color history palette

The color pick history SHALL persist across app sessions using SharedPreferences. The history SHALL load on page entry and save on every addition or clear operation. The maximum history size SHALL be 20 entries.

#### Scenario: History persists after leaving and returning

- **WHEN** user picks colors, leaves the page, and returns
- **THEN** the previously picked colors SHALL still appear in the history palette

<!-- @trace
source: enhance-color-picker
updated: 2026-03-23
code:
  - linux/flutter/generated_plugins.cmake
  - pubspec.yaml
  - windows/flutter/generated_plugin_registrant.cc
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/color_picker/color_picker_page.dart
  - pubspec.lock
  - lib/l10n/app_en.arb
  - windows/flutter/generated_plugins.cmake
  - linux/flutter/generated_plugin_registrant.cc
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_en.dart
  - macos/Flutter/GeneratedPluginRegistrant.swift
-->