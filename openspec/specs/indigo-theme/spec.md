# indigo-theme Specification

## Purpose

TBD - created by archiving change 'homepage-redesign-indigo'. Update Purpose after archive.

## Requirements

### Requirement: Indigo brand color seed

The app theme SHALL use `ColorScheme.fromSeed(seedColor: Color(0xFF6C5CE7))` as the brand color for both light and dark modes. All Material 3 components SHALL derive their colors from this seed.

#### Scenario: App uses indigo color scheme

- **WHEN** the app starts
- **THEN** the Material 3 color scheme SHALL be generated from the indigo seed color #6C5CE7


<!-- @trace
source: homepage-redesign-indigo
updated: 2026-03-21
code:
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/widgets/tool_card.dart
  - pubspec.yaml
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/pages/favorites_page.dart
  - lib/l10n/app_en.arb
  - lib/widgets/bento_grid.dart
  - android/app/src/main/AndroidManifest.xml
  - pubspec.lock
  - lib/widgets/app_scaffold.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/l10n/app_zh.arb
  - lib/app.dart
  - lib/pages/home_page.dart
  - lib/models/tool_item.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/theme/design_tokens.dart
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/theme/app_theme.dart
  - lib/tools/screen_ruler/ruler_painter.dart
  - lib/tools/invoice_checker/invoice_api.dart
tests:
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/widget_test.dart
  - test/pages/favorites_page_test.dart
-->

---
### Requirement: Dark mode deep indigo surface colors

In dark mode, the scaffold background color SHALL be #1A1A2E (deep indigo blue). Card and surface container colors SHALL be #16213E. These values SHALL override the default Material 3 dark surface colors using `ColorScheme.copyWith()`.

#### Scenario: Dark mode uses deep indigo background

- **WHEN** the app is in dark mode
- **THEN** the scaffold background SHALL be #1A1A2E

#### Scenario: Dark mode cards use custom surface color

- **WHEN** the app is in dark mode
- **THEN** card backgrounds SHALL be #16213E


<!-- @trace
source: homepage-redesign-indigo
updated: 2026-03-21
code:
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/widgets/tool_card.dart
  - pubspec.yaml
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/pages/favorites_page.dart
  - lib/l10n/app_en.arb
  - lib/widgets/bento_grid.dart
  - android/app/src/main/AndroidManifest.xml
  - pubspec.lock
  - lib/widgets/app_scaffold.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/l10n/app_zh.arb
  - lib/app.dart
  - lib/pages/home_page.dart
  - lib/models/tool_item.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/theme/design_tokens.dart
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/theme/app_theme.dart
  - lib/tools/screen_ruler/ruler_painter.dart
  - lib/tools/invoice_checker/invoice_api.dart
tests:
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/widget_test.dart
  - test/pages/favorites_page_test.dart
-->

---
### Requirement: Light mode uses standard Material 3 surfaces

In light mode, the surface colors SHALL use the default Material 3 values generated from the indigo seed color. No custom surface overrides SHALL be applied in light mode.

#### Scenario: Light mode uses generated surfaces

- **WHEN** the app is in light mode
- **THEN** surface colors SHALL be the default Material 3 generated values from the indigo seed

<!-- @trace
source: homepage-redesign-indigo
updated: 2026-03-21
code:
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/widgets/tool_card.dart
  - pubspec.yaml
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/pages/favorites_page.dart
  - lib/l10n/app_en.arb
  - lib/widgets/bento_grid.dart
  - android/app/src/main/AndroidManifest.xml
  - pubspec.lock
  - lib/widgets/app_scaffold.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/l10n/app_zh.arb
  - lib/app.dart
  - lib/pages/home_page.dart
  - lib/models/tool_item.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/theme/design_tokens.dart
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/theme/app_theme.dart
  - lib/tools/screen_ruler/ruler_painter.dart
  - lib/tools/invoice_checker/invoice_api.dart
tests:
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/home_page_test.dart
  - test/widget_test.dart
  - test/pages/favorites_page_test.dart
-->