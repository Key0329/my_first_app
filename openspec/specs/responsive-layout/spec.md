# responsive-layout Specification

## Purpose

TBD - created by archiving change 'architecture-scaling'. Update Purpose after archive.

## Requirements

### Requirement: Responsive grid column count

The home page tool grid SHALL dynamically adjust its column count based on the available width. For widths less than 600dp, 2 columns SHALL be used. For widths between 600dp and 900dp, 3 columns SHALL be used. For widths greater than 900dp, 4 columns SHALL be used. The childAspectRatio SHALL remain 1.2 across all breakpoints.

#### Scenario: Phone in portrait mode

- **WHEN** the home page renders on a device with width less than 600dp
- **THEN** the tool grid SHALL display 2 columns

#### Scenario: Tablet in landscape mode

- **WHEN** the home page renders on a device with width greater than 900dp
- **THEN** the tool grid SHALL display 4 columns


<!-- @trace
source: architecture-scaling
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/confetti_effect.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/app_scaffold.dart
  - lib/l10n/app_en.arb
  - lib/pages/home_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/models/tool_item_test.dart
-->

---
### Requirement: Tool page body max width constraint

The ImmersiveToolScaffold body area SHALL be constrained to a maximum width of 600dp on wide screens. The body content SHALL be horizontally centered when the constraint is active. The header area SHALL remain full width.

#### Scenario: Tool page on iPad

- **WHEN** a tool page renders on a device wider than 600dp
- **THEN** the body content area SHALL be centered with a maximum width of 600dp


<!-- @trace
source: architecture-scaling
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/confetti_effect.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/app_scaffold.dart
  - lib/l10n/app_en.arb
  - lib/pages/home_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/models/tool_item_test.dart
-->

---
### Requirement: NavigationRail on wide screens

On screens wider than 900dp, the app SHALL display a NavigationRail on the left side instead of the bottom NavigationBar. The NavigationRail SHALL contain the same navigation items (home, favorites, settings) with the same icons and labels. On screens 900dp or narrower, the bottom NavigationBar SHALL be used.

#### Scenario: iPad displays NavigationRail

- **WHEN** the app renders on a screen wider than 900dp
- **THEN** a NavigationRail SHALL be displayed on the left side and no bottom NavigationBar SHALL be shown

#### Scenario: Phone displays NavigationBar

- **WHEN** the app renders on a screen 900dp or narrower
- **THEN** a bottom NavigationBar SHALL be displayed and no NavigationRail SHALL be shown

<!-- @trace
source: architecture-scaling
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/confetti_effect.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/app_scaffold.dart
  - lib/l10n/app_en.arb
  - lib/pages/home_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/models/tool_item_test.dart
-->