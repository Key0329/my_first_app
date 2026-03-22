# favorites Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: Add and remove favorites

Users SHALL be able to add a tool to favorites by tapping the visible heart icon button on its card on the home page. A tap on the heart icon of a favorited tool SHALL remove it from favorites. Additionally, a long press on a tool card SHALL toggle the favorite status as a secondary interaction method. The favorites list SHALL persist across app restarts using shared_preferences. When a tool is added to favorites, it SHALL be promoted to a large card in the Bento Grid layout on the home page. When removed from favorites, it SHALL return to medium or small size. When the favorite status changes, a SnackBar SHALL be displayed with the message "Added to favorites" or "Removed from favorites" respectively.

#### Scenario: User adds a tool to favorites via heart button

- **WHEN** user taps the heart icon button on a tool card that is not in favorites
- **THEN** the tool SHALL be added to favorites, the heart icon SHALL change to a filled heart with brand color, a SnackBar SHALL display "Added to favorites", and the card SHALL be promoted to large size in the Bento Grid

#### Scenario: User removes a tool from favorites via heart button

- **WHEN** user taps the heart icon button on a tool card that is in favorites
- **THEN** the tool SHALL be removed from favorites, the heart icon SHALL change to an outline heart, a SnackBar SHALL display "Removed from favorites", and the card SHALL return to medium or small size in the Bento Grid

#### Scenario: User toggles favorites via long press

- **WHEN** user long-presses a tool card
- **THEN** the favorite status SHALL be toggled with the same behavior as tapping the heart button


<!-- @trace
source: ux-polish
updated: 2026-03-22
code:
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/models/tool_item.dart
  - lib/widgets/error_state.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/services/haptic_service.dart
  - lib/pages/home_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/bouncing_button.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/compass/compass_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/tool_search_delegate.dart
  - lib/pages/settings_page.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - .mcp.json
  - lib/tools/flashlight/flashlight_logic.dart
  - CLAUDE.md
  - lib/tools/compass/compass_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/app.dart
  - lib/tools/level/level_page.dart
  - lib/pages/favorites_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/services/settings_service.dart
  - lib/theme/design_tokens.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
tests:
  - test/tools/screen_ruler_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/services/settings_service_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/widget_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/level_logic_test.dart
  - test/models/tool_item_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/compass_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
-->

---
### Requirement: Favorites page

The Favorites tab SHALL display all favorited tools in a grid layout identical to the home page. If no tools are favorited, a placeholder message SHALL be displayed.

#### Scenario: User views favorites

- **WHEN** user navigates to the Favorites tab
- **THEN** all favorited tools SHALL be displayed in a grid layout

#### Scenario: No favorites exist

- **WHEN** user navigates to the Favorites tab with no favorited tools
- **THEN** a placeholder message SHALL be displayed suggesting the user to add favorites


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
### Requirement: Favorites persistence

The favorites list SHALL be stored using shared_preferences and SHALL persist across app restarts.

#### Scenario: Favorites persist after restart

- **WHEN** user has favorited tools and restarts the app
- **THEN** the favorites list SHALL be restored from local storage

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
### Requirement: Visible favorite heart button on tool cards

Each tool card on the home page and favorites page SHALL display a heart icon button in the top-right corner. The heart icon SHALL be `Icons.favorite` (filled) when the tool is favorited and `Icons.favorite_border` (outline) when not favorited. The favorited heart icon SHALL use the brand color. The heart button SHALL have an AnimatedScale animation on tap (scale to 1.2 then back to 1.0).

#### Scenario: Heart button is visible on all tool cards

- **WHEN** the home page displays tool cards
- **THEN** each tool card SHALL have a visible heart icon button in the top-right corner

#### Scenario: Heart button reflects favorite status

- **WHEN** a tool is in the favorites list
- **THEN** the heart icon on its card SHALL be displayed as a filled heart with brand color

#### Scenario: Heart button animates on tap

- **WHEN** user taps the heart icon button
- **THEN** the heart icon SHALL animate with a scale-up to 1.2 and spring back to 1.0

<!-- @trace
source: ux-polish
updated: 2026-03-22
code:
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/models/tool_item.dart
  - lib/widgets/error_state.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/services/haptic_service.dart
  - lib/pages/home_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/bouncing_button.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/compass/compass_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/tool_search_delegate.dart
  - lib/pages/settings_page.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - .mcp.json
  - lib/tools/flashlight/flashlight_logic.dart
  - CLAUDE.md
  - lib/tools/compass/compass_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/app.dart
  - lib/tools/level/level_page.dart
  - lib/pages/favorites_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/services/settings_service.dart
  - lib/theme/design_tokens.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
tests:
  - test/tools/screen_ruler_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/services/settings_service_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/widget_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/level_logic_test.dart
  - test/models/tool_item_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/compass_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
-->