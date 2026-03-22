# tool-qr-scanner-live Specification

## Purpose

TBD - created by archiving change 'feature-expansion'. Update Purpose after archive.

## Requirements

### Requirement: QR Code live scanning

The tool SHALL provide a live camera preview using `mobile_scanner` for real-time QR Code scanning. The camera preview SHALL be displayed in the upper area of the ImmersiveToolScaffold layout with a scan frame overlay animation. When a QR Code is detected, the scanner SHALL automatically decode it and display the result.

#### Scenario: User scans a QR Code successfully

- **WHEN** user opens the QR scanner tool and points the camera at a valid QR Code
- **THEN** the system SHALL decode the QR Code and display the decoded content in the result area below the camera preview

#### Scenario: Camera preview is active

- **WHEN** user opens the QR scanner tool
- **THEN** a live camera preview SHALL be displayed with a scan frame overlay indicating the scanning area


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
### Requirement: QR scan result handling

The tool SHALL automatically detect the type of scanned content (URL, plain text, WiFi configuration) and display corresponding action buttons. For URL results, an "Open in browser" button SHALL be provided. For all result types, a "Copy to clipboard" button SHALL be available.

#### Scenario: User scans a URL QR Code

- **WHEN** user scans a QR Code containing a URL
- **THEN** the result area SHALL display the URL text and provide both "Open in browser" and "Copy to clipboard" action buttons

#### Scenario: User scans a plain text QR Code

- **WHEN** user scans a QR Code containing plain text
- **THEN** the result area SHALL display the text content and provide a "Copy to clipboard" action button


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
### Requirement: Camera permission handling

The tool SHALL request camera permission when first opened. If the user denies camera permission, the tool SHALL display a guidance message explaining why camera access is needed and provide a button to open system settings.

#### Scenario: Camera permission denied

- **WHEN** user denies camera permission
- **THEN** the tool SHALL display a message explaining that camera access is required for QR scanning and SHALL provide a button to open system settings

#### Scenario: Camera permission granted

- **WHEN** user grants camera permission
- **THEN** the camera preview SHALL start immediately and begin scanning for QR Codes

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