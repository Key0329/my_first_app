# personalization-theme-color Specification

## Purpose

TBD - created by archiving change 'personalization'. Update Purpose after archive.

## Requirements

### Requirement: Accent color selection

The system SHALL allow users to select an accent color from a set of predefined color options only if `ProService.isPro == true`. When `isPro == false`, the accent color section SHALL display each color swatch with a lock icon overlay and a Pro badge label. Tapping any locked swatch SHALL open `PaywallScreen`. The default purple accent (#6C5CE7) SHALL remain active for free users regardless of any prior selection.

#### Scenario: Default accent color (free user)

- **WHEN** user has not purchased Pro
- **THEN** the app SHALL use the default purple accent (#6C5CE7) and color swatches SHALL show lock overlays

#### Scenario: Default accent color (no prior selection, Pro user)

- **WHEN** Pro user has not selected an accent color
- **THEN** the app SHALL use the default purple accent (#6C5CE7)

#### Scenario: Select accent color (Pro user)

- **WHEN** Pro user selects a new accent color in settings
- **THEN** the app's global UI elements (AppBar, tabs, buttons) SHALL update to reflect the selected color

#### Scenario: Free user taps locked color swatch

- **WHEN** free user taps any non-default color swatch
- **THEN** `PaywallScreen` SHALL be presented as a modal


<!-- @trace
source: freemium-paywall
updated: 2026-03-28
code:
  - .agents/skills/spectra-ingest/SKILL.md
  - lib/config/ad_config.dart
  - pubspec.lock
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - .agents/skills/spectra-propose/SKILL.md
  - lib/main.dart
  - lib/services/pro_service.dart
  - lib/pages/settings_page.dart
  - .agents/skills/spectra-apply/SKILL.md
  - lib/widgets/banner_ad_widget.dart
  - lib/app.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - .agents/skills/spectra-discuss/SKILL.md
  - .agents/skills/spectra-ask/SKILL.md
  - android/app/src/main/AndroidManifest.xml
  - .spectra.yaml
  - ios/Runner/Info.plist
  - lib/services/in_app_purchase_service.dart
  - lib/pages/paywall_screen.dart
tests:
  - test/pages/paywall_screen_test.dart
  - test/services/pro_service_test.dart
  - test/widgets/banner_ad_widget_test.dart
  - test/services/in_app_purchase_service_test.dart
  - test/widget_test.dart
-->

---
### Requirement: Accent color options

The system SHALL provide 6 predefined accent color options: purple (default), blue, green, red, orange, and pink.

#### Scenario: Six color options displayed

- **WHEN** user opens the accent color setting
- **THEN** 6 color circles SHALL be displayed for selection


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
### Requirement: Accent color persistence

The selected accent color SHALL persist across app restarts using SharedPreferences.

#### Scenario: Color persists after restart

- **WHEN** user selects an accent color and restarts the app
- **THEN** the previously selected color SHALL be applied


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
### Requirement: Accent color in settings page

The settings page SHALL display an accent color picker section with circular color swatches.

#### Scenario: Settings color picker

- **WHEN** user navigates to settings
- **THEN** an "Accent Color" section SHALL display with tappable color circles

#### Scenario: Selected color indicator

- **WHEN** a color is currently selected
- **THEN** the selected color circle SHALL display a check mark overlay


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
### Requirement: Theme color i18n

All theme color UI text SHALL support both Traditional Chinese and English.

#### Scenario: Chinese locale

- **WHEN** app locale is zh
- **THEN** accent color UI text SHALL display in Traditional Chinese

#### Scenario: English locale

- **WHEN** app locale is en
- **THEN** accent color UI text SHALL display in English

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