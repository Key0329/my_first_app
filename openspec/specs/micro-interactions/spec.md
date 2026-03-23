# micro-interactions Specification

## Purpose

TBD - created by archiving change 'ux-polish'. Update Purpose after archive.

## Requirements

### Requirement: Enhanced Hero animation for tool navigation

When navigating from the home page to a tool page, the tool card icon container SHALL perform a Hero animation that transitions from the circular icon container on the home page to the full-width gradient header on the tool page. The flight animation SHALL smoothly morph the border radius from circular to rectangular. The Hero tag SHALL follow the pattern 'tool_hero_{toolId}'.

#### Scenario: User opens a tool from home page

- **WHEN** user taps a tool card on the home page
- **THEN** the tool icon container SHALL animate via Hero transition to become the tool page gradient header

#### Scenario: User navigates back to home page

- **WHEN** user presses back on a tool page
- **THEN** the gradient header SHALL animate back to the circular icon container on the home page


<!-- @trace
source: ux-polish
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/widgets/shimmer_loading.dart
  - lib/pages/home_page.dart
  - lib/widgets/hero_moment.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/widgets/confetti_effect.dart
  - lib/widgets/tool_card.dart
tests:
  - test/widgets/hero_moment_test.dart
  - test/widgets/shimmer_loading_test.dart
  - test/widgets/confetti_effect_test.dart
-->

---
### Requirement: Confetti effect on favorite toggle

When a user adds a tool to favorites, a confetti particle effect SHALL play from the favorite button position. The effect SHALL consist of 15-20 colored particles that burst outward from the button. The particles SHALL use brand color variations (purple, blue, pink, orange). The animation SHALL last approximately 600ms. The confetti SHALL NOT play when removing a favorite.

#### Scenario: User adds a tool to favorites

- **WHEN** user taps the favorite button on a non-favorited tool
- **THEN** a confetti particle burst SHALL animate from the button position

#### Scenario: User removes a tool from favorites

- **WHEN** user taps the favorite button on a favorited tool
- **THEN** no confetti effect SHALL play


<!-- @trace
source: ux-polish
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/widgets/shimmer_loading.dart
  - lib/pages/home_page.dart
  - lib/widgets/hero_moment.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/widgets/confetti_effect.dart
  - lib/widgets/tool_card.dart
tests:
  - test/widgets/hero_moment_test.dart
  - test/widgets/shimmer_loading_test.dart
  - test/widgets/confetti_effect_test.dart
-->

---
### Requirement: Shimmer loading skeleton on home page

The home page SHALL display a shimmer loading skeleton animation during the initial load before tool cards appear. The skeleton SHALL mimic the layout of the tool grid with placeholder rectangles matching the card dimensions. The shimmer effect SHALL be a horizontal gradient sweep from left to right. The skeleton SHALL transition to real content via a crossfade once data is available.

#### Scenario: Home page initial load

- **WHEN** the home page loads for the first time and content is not yet rendered
- **THEN** a shimmer skeleton matching the tool grid layout SHALL be displayed briefly

#### Scenario: Skeleton transitions to real content

- **WHEN** the tool cards are ready to display
- **THEN** the shimmer skeleton SHALL crossfade to the real tool grid content


<!-- @trace
source: ux-polish
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/widgets/shimmer_loading.dart
  - lib/pages/home_page.dart
  - lib/widgets/hero_moment.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/widgets/confetti_effect.dart
  - lib/widgets/tool_card.dart
tests:
  - test/widgets/hero_moment_test.dart
  - test/widgets/shimmer_loading_test.dart
  - test/widgets/confetti_effect_test.dart
-->

---
### Requirement: Hero Moment result animation

When a tool computes a new result value, the result display SHALL animate with a scale-bounce effect to emphasize the update. The animation SHALL scale from 0.8x to 1.05x (overshoot) then settle to 1.0x, combined with opacity from 0.5 to 1.0. The animation SHALL use DT.curveSpring and DT.durationMedium.

#### Scenario: BMI calculator shows new result

- **WHEN** the BMI calculator computes a new result
- **THEN** the result text SHALL animate with a scale-bounce Hero Moment effect

#### Scenario: Currency converter shows conversion result

- **WHEN** the currency converter displays a new conversion amount
- **THEN** the result text SHALL animate with a scale-bounce Hero Moment effect

<!-- @trace
source: ux-polish
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/widgets/shimmer_loading.dart
  - lib/pages/home_page.dart
  - lib/widgets/hero_moment.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/widgets/confetti_effect.dart
  - lib/widgets/tool_card.dart
tests:
  - test/widgets/hero_moment_test.dart
  - test/widgets/shimmer_loading_test.dart
  - test/widgets/confetti_effect_test.dart
-->