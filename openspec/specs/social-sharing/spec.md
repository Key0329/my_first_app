# social-sharing Specification

## Purpose

TBD - created by archiving change 'growth-infrastructure'. Update Purpose after archive.

## Requirements

### Requirement: ShareButton widget in tool actions

The app SHALL provide a reusable `ShareButton` widget that displays a share icon button. The `ShareButton` SHALL be placed in the `ImmersiveToolScaffold` actions area of each shareable tool page. The button SHALL use the `Icons.share` icon and match the existing AppBar action button style.

#### Scenario: ShareButton is visible on shareable tool page

- **WHEN** user opens a shareable tool (split bill, random wheel, BMI calculator, or QR generator)
- **THEN** a share icon button SHALL be displayed in the AppBar actions area


<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: Split bill share text template

When the user taps the share button on the split bill tool, the app SHALL invoke the system share sheet via `share_plus` with a text message containing: the total amount, per-person amount, number of people, and a deep link URL `https://spectra.app/tools/split-bill`.

#### Scenario: User shares split bill result

- **WHEN** user taps the share button after calculating a split bill
- **THEN** the system share sheet SHALL open with text including the total amount, per-person amount, number of people, and the deep link URL


<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: Random wheel share text template

When the user taps the share button on the random wheel tool after spinning, the app SHALL invoke the system share sheet via `share_plus` with a text message containing: the selected result item and a deep link URL `https://spectra.app/tools/random-wheel`.

#### Scenario: User shares random wheel result

- **WHEN** user taps the share button after the wheel has selected a result
- **THEN** the system share sheet SHALL open with text including the selected item and the deep link URL


<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: BMI calculator share text template

When the user taps the share button on the BMI calculator tool after calculating, the app SHALL invoke the system share sheet via `share_plus` with a text message containing: the BMI value, the BMI classification, height, weight, and a deep link URL `https://spectra.app/tools/bmi-calculator`.

#### Scenario: User shares BMI result

- **WHEN** user taps the share button after calculating BMI
- **THEN** the system share sheet SHALL open with text including the BMI value, classification, height, weight, and the deep link URL


<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: QR generator share image and text

When the user taps the share button on the QR generator tool after generating a QR code, the app SHALL invoke the system share sheet via `share_plus` with the QR code image and a text message containing a deep link URL `https://spectra.app/tools/qr-generator`.

#### Scenario: User shares QR code result

- **WHEN** user taps the share button after generating a QR code
- **THEN** the system share sheet SHALL open with the QR code image and a text message including the deep link URL


<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: Share button disabled state before result

The `ShareButton` SHALL be disabled (grayed out, non-tappable) when the tool has not yet produced a result. It SHALL become enabled only after the user completes an action that produces a shareable result.

#### Scenario: Share button is disabled before calculation

- **WHEN** user opens BMI calculator but has not yet calculated a result
- **THEN** the share button SHALL be visually disabled and non-tappable

#### Scenario: Share button becomes enabled after result

- **WHEN** user completes a BMI calculation
- **THEN** the share button SHALL become enabled and tappable

<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->