# personalization-tool-order Specification

## Purpose

TBD - created by archiving change 'personalization'. Update Purpose after archive.

## Requirements

### Requirement: Tool order customization

The system SHALL allow users to customize the order of tools displayed on the homepage grid.

#### Scenario: Default order

- **WHEN** user has not customized tool order
- **THEN** tools SHALL display in the default order defined by `allTools`

#### Scenario: Custom order persists

- **WHEN** user reorders tools and restarts the app
- **THEN** the custom order SHALL be preserved


<!-- @trace
source: personalization
updated: 2026-03-23
code:
  - lib/services/user_preferences_service.dart
  - lib/services/settings_service.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/theme/app_theme.dart
  - lib/app.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/services/theme_service.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_zh.dart
tests:
  - test/services/tool_order_test.dart
  - test/services/accent_color_test.dart
  - test/pages/settings_accent_color_test.dart
-->

---
### Requirement: Reorder UI

The system SHALL provide a sort button on the homepage that opens a bottom sheet with a draggable list of tools for reordering.

#### Scenario: Open reorder sheet

- **WHEN** user taps the sort button on the homepage
- **THEN** a bottom sheet SHALL appear with all tools in a draggable list

#### Scenario: Drag to reorder

- **WHEN** user long-presses and drags a tool in the reorder sheet
- **THEN** the tool SHALL move to the new position and the order SHALL be saved automatically

#### Scenario: Close reorder sheet

- **WHEN** user dismisses the bottom sheet
- **THEN** the homepage grid SHALL reflect the updated tool order


<!-- @trace
source: personalization
updated: 2026-03-23
code:
  - lib/services/user_preferences_service.dart
  - lib/services/settings_service.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/theme/app_theme.dart
  - lib/app.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/services/theme_service.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_zh.dart
tests:
  - test/services/tool_order_test.dart
  - test/services/accent_color_test.dart
  - test/pages/settings_accent_color_test.dart
-->

---
### Requirement: New tools handling

The system SHALL handle newly added tools that are not in the saved order list.

#### Scenario: New tool appears at end

- **WHEN** a new tool is added to the app but not in the saved order
- **THEN** the new tool SHALL appear at the end of the grid


<!-- @trace
source: personalization
updated: 2026-03-23
code:
  - lib/services/user_preferences_service.dart
  - lib/services/settings_service.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/theme/app_theme.dart
  - lib/app.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/services/theme_service.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_zh.dart
tests:
  - test/services/tool_order_test.dart
  - test/services/accent_color_test.dart
  - test/pages/settings_accent_color_test.dart
-->

---
### Requirement: Tool order persistence

The tool order SHALL be persisted using SharedPreferences as a list of tool ID strings.

#### Scenario: Order saved to SharedPreferences

- **WHEN** user reorders tools
- **THEN** the new order SHALL be saved to SharedPreferences immediately


<!-- @trace
source: personalization
updated: 2026-03-23
code:
  - lib/services/user_preferences_service.dart
  - lib/services/settings_service.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/theme/app_theme.dart
  - lib/app.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/services/theme_service.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_zh.dart
tests:
  - test/services/tool_order_test.dart
  - test/services/accent_color_test.dart
  - test/pages/settings_accent_color_test.dart
-->

---
### Requirement: Tool order i18n

All tool order UI text SHALL support both Traditional Chinese and English.

#### Scenario: Chinese locale

- **WHEN** app locale is zh
- **THEN** reorder UI text SHALL display in Traditional Chinese

#### Scenario: English locale

- **WHEN** app locale is en
- **THEN** reorder UI text SHALL display in English

<!-- @trace
source: personalization
updated: 2026-03-23
code:
  - lib/services/user_preferences_service.dart
  - lib/services/settings_service.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/theme/app_theme.dart
  - lib/app.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/services/theme_service.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_zh.dart
tests:
  - test/services/tool_order_test.dart
  - test/services/accent_color_test.dart
  - test/pages/settings_accent_color_test.dart
-->