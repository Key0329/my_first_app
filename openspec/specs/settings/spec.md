# settings Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: Theme mode selection

The settings page SHALL provide a theme mode selector using a SegmentedButton with three options: Light, Dark, and System Default. The selector SHALL be displayed inside a Bento-style ToolSectionCard in the "Appearance" section. The selected mode SHALL take effect immediately and persist across app restarts. Theme and locale state SHALL be managed by a dedicated ThemeService. Changes to ThemeService SHALL trigger MaterialApp rebuild. Changes to other services (favorites, recent tools) SHALL NOT trigger MaterialApp rebuild.

#### Scenario: User changes theme mode

- **WHEN** user selects a different theme mode via the SegmentedButton
- **THEN** the app theme SHALL change immediately
- **AND** only the MaterialApp SHALL rebuild, not other unrelated widgets

#### Scenario: User toggles a favorite

- **WHEN** user toggles a favorite tool
- **THEN** the MaterialApp SHALL NOT rebuild
- **AND** only the favorite-related UI SHALL update


<!-- @trace
source: services-refactor
updated: 2026-03-22
code:
  - lib/services/favorites_service.dart
  - lib/services/theme_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/services/user_preferences_service.dart
-->

---
### Requirement: Language selection

The settings page SHALL provide a language selector using a SegmentedButton with two options: Traditional Chinese and English. The selector SHALL be displayed inside the same "Appearance" ToolSectionCard as the theme mode selector. The selected language SHALL take effect immediately and persist across app restarts.

#### Scenario: User changes language

- **WHEN** user selects a different language via the SegmentedButton
- **THEN** the app interface language SHALL change immediately


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
### Requirement: About and legal links

The settings page SHALL display the app version, a link to the privacy policy, and a link to the terms of use inside a Bento-style ToolSectionCard in the "About" section.

#### Scenario: User views about section

- **WHEN** user is on the settings page
- **THEN** the app version, privacy policy link, and terms of use link SHALL be visible inside a Bento-style card


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
### Requirement: Settings page Bento layout

The settings page SHALL use a Bento Grid-style layout with ToolSectionCard components instead of standard ListTile items. The settings SHALL be organized into three sections: "Appearance" (theme mode, language), "Data" (clear favorites, clear recent tools), and "About" (version, privacy, terms). Each section SHALL be wrapped in a ToolSectionCard with rounded corners and the standard card styling. The sections SHALL animate in with StaggeredFadeIn on page load.

#### Scenario: Settings page displays Bento-style cards

- **WHEN** user navigates to the settings page
- **THEN** settings items SHALL be displayed in Bento-style ToolSectionCard components organized into three sections

#### Scenario: Settings sections animate in

- **WHEN** the settings page loads
- **THEN** each section card SHALL animate in with the StaggeredFadeIn effect


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
### Requirement: Clear recent tools data

The settings page SHALL provide a "Clear Recent Tools" action in the "Data" section. Tapping the action SHALL clear all recent tools history from shared_preferences and update the UI immediately. A confirmation dialog SHALL be shown before clearing.

#### Scenario: User clears recent tools

- **WHEN** user taps "Clear Recent Tools" and confirms the dialog
- **THEN** the recent tools list SHALL be cleared from storage and the home page recent tools section SHALL be hidden

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
### Requirement: SharedPreferences cached instance

The AppSettings service SHALL obtain a SharedPreferences instance once during initialization and reuse it for all subsequent read and write operations. Individual setter methods SHALL NOT call SharedPreferences.getInstance() separately.

#### Scenario: Multiple settings changes in sequence

- **WHEN** a user changes theme mode and then toggles a favorite
- **THEN** both operations SHALL use the same SharedPreferences instance obtained during init()


<!-- @trace
source: services-refactor
updated: 2026-03-22
code:
  - lib/services/favorites_service.dart
  - lib/services/theme_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/services/user_preferences_service.dart
-->

---
### Requirement: Service separation

The AppSettings class SHALL delegate to three specialized sub-services: ThemeService (theme mode, locale), FavoritesService (favorites set), and UserPreferencesService (onboarding status, recent tools). Each sub-service SHALL extend ChangeNotifier and notify listeners independently. The AppSettings class SHALL remain as a facade with the same public API.

#### Scenario: AppSettings API backward compatibility

- **WHEN** existing code calls AppSettings.setThemeMode(), AppSettings.toggleFavorite(), or AppSettings.addRecentTool()
- **THEN** the calls SHALL succeed without any modification to the calling code

<!-- @trace
source: services-refactor
updated: 2026-03-22
code:
  - lib/services/favorites_service.dart
  - lib/services/theme_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/services/user_preferences_service.dart
-->