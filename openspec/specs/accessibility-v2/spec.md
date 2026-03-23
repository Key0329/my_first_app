# accessibility-v2 Specification

## Purpose

TBD - created by archiving change 'design-system-v2'. Update Purpose after archive.

## Requirements

### Requirement: Tool result values use liveRegion

All tool pages that display computed result values (BMI result, currency conversion result, split bill per-person amount, word counter statistics, date calculator result) SHALL wrap their primary result display in a Semantics widget with `liveRegion: true` and a `value` property containing the result with its unit. This ensures screen readers automatically announce result changes.

#### Scenario: BMI result announces to screen reader

- **WHEN** the BMI calculator computes a new BMI value of 22.5
- **THEN** the result display SHALL have Semantics with liveRegion true and value "BMI 22.5"

#### Scenario: Currency conversion result announces

- **WHEN** the currency converter displays a converted amount of 150.00 USD
- **THEN** the result display SHALL have Semantics with liveRegion true and value including the amount and currency code


<!-- @trace
source: design-system-v2
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/theme/design_tokens.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/word_counter/word_counter_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/home_page.dart
  - lib/tools/level/level_page.dart
  - lib/widgets/tool_card.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/l10n/app_localizations.dart
  - lib/theme/app_theme.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_en.arb
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/split_bill/split_bill_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/theme/design_tokens_v2_test.dart
  - test/theme/color_contrast_test.dart
-->

---
### Requirement: Interactive elements have semantic labels

All custom interactive elements (IconButton without label, GestureDetector, InkWell used as buttons) across all tool pages SHALL be wrapped in or contain a Semantics widget with a descriptive `label` and optional `hint`. The labels SHALL be localized via AppLocalizations.

#### Scenario: Favorite button has semantic label

- **WHEN** a screen reader focuses on the favorite toggle button
- **THEN** it SHALL announce the button's semantic label (e.g., "add to favorites" or "remove from favorites") based on the current state

#### Scenario: Search button has semantic label

- **WHEN** a screen reader focuses on the home page search button
- **THEN** it SHALL announce "search tools" as the semantic label


<!-- @trace
source: design-system-v2
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/theme/design_tokens.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/word_counter/word_counter_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/home_page.dart
  - lib/tools/level/level_page.dart
  - lib/widgets/tool_card.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/l10n/app_localizations.dart
  - lib/theme/app_theme.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_en.arb
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/split_bill/split_bill_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/theme/design_tokens_v2_test.dart
  - test/theme/color_contrast_test.dart
-->

---
### Requirement: Slider semantic formatter callback

All Slider widgets in the app (pomodoro duration settings, BMI height/weight inputs, and any future sliders) SHALL provide a `semanticFormatterCallback` that returns a human-readable string including the current value and its unit.

#### Scenario: Pomodoro work duration slider announces value

- **WHEN** a screen reader user adjusts the pomodoro work duration slider to 25
- **THEN** the screen reader SHALL announce "25 minutes" (or localized equivalent)

#### Scenario: BMI height slider announces value

- **WHEN** a screen reader user adjusts the BMI height slider to 170
- **THEN** the screen reader SHALL announce "170 cm" (or localized equivalent)


<!-- @trace
source: design-system-v2
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/theme/design_tokens.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/word_counter/word_counter_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/home_page.dart
  - lib/tools/level/level_page.dart
  - lib/widgets/tool_card.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/l10n/app_localizations.dart
  - lib/theme/app_theme.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_en.arb
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/split_bill/split_bill_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/theme/design_tokens_v2_test.dart
  - test/theme/color_contrast_test.dart
-->

---
### Requirement: Color contrast compliance

All text rendered in the app SHALL meet WCAG 2.1 Level AA contrast requirements: normal text (< 18sp) SHALL have a contrast ratio of at least 4.5:1 against its background, and large text (>= 18sp or >= 14sp bold) SHALL have a contrast ratio of at least 3:1 against its background. This applies to both light and dark modes.

#### Scenario: Body text meets contrast in light mode

- **WHEN** body text renders with DT.lightSubtitle color on DT.lightPageBg background
- **THEN** the contrast ratio SHALL be at least 4.5:1

#### Scenario: Body text meets contrast in dark mode

- **WHEN** body text renders with DT.darkSubtitle color on DT.darkPageBg background
- **THEN** the contrast ratio SHALL be at least 4.5:1

<!-- @trace
source: design-system-v2
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/theme/design_tokens.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/word_counter/word_counter_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/home_page.dart
  - lib/tools/level/level_page.dart
  - lib/widgets/tool_card.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/l10n/app_localizations.dart
  - lib/theme/app_theme.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_en.arb
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/split_bill/split_bill_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/theme/design_tokens_v2_test.dart
  - test/theme/color_contrast_test.dart
-->