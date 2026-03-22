# tool-body-bento-style Specification

## Purpose

TBD - created by archiving change 'tool-pages-bento-redesign'. Update Purpose after archive.

## Requirements

### Requirement: ToolSectionCard shared container widget

All tool pages SHALL use a `ToolSectionCard` widget to group related controls in the body area. Each `ToolSectionCard` SHALL have a light brand-color filled background (`DT.brandPrimaryBgLight` in light mode, `DT.brandPrimaryBgDark` in dark mode) with no border. The card SHALL use `DT.radiusLg` (16dp) border radius and `DT.spaceLg` (16dp) internal padding. Cards SHALL be separated by `DT.gridSpacing` (12dp) vertical spacing. Each card SHALL accept an optional label displayed in brand-color text at 14dp font size.

#### Scenario: Tool page body displays grouped controls in Bento cards

- **WHEN** user opens any tool page
- **THEN** the body area SHALL display controls grouped inside ToolSectionCard containers with light brand-color backgrounds, 16dp rounded corners, and 12dp spacing between cards

#### Scenario: ToolSectionCard shows optional label

- **WHEN** a ToolSectionCard is configured with a label
- **THEN** the label SHALL be displayed at 14dp font size in brand primary color above the card contents

#### Scenario: ToolSectionCard adapts to dark mode

- **WHEN** the app is in dark mode
- **THEN** ToolSectionCard SHALL use `DT.brandPrimaryBgDark` as background color


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: ToolGradientButton for primary actions

Each tool page SHALL use a `ToolGradientButton` for its primary call-to-action. The button SHALL display a 135-degree linear gradient background using the tool's gradient colors from `toolGradients`. The button SHALL have `DT.radiusMd` (14dp) border radius, 52dp height, white text at 16dp with w600 weight. The button SHALL be wrapped in a `BouncingButton` for press animation.

#### Scenario: Primary action button displays tool gradient

- **WHEN** user views the password generator tool page
- **THEN** the "Generate" button SHALL display with a purple gradient background matching the tool's gradient colors

#### Scenario: Primary action button has bounce animation

- **WHEN** user presses the primary action button on any tool page
- **THEN** the button SHALL scale to 0.95 and spring back to 1.0 with an elastic curve


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Design Tokens for tool page body

The `DT` class SHALL include tool-page-specific tokens: `toolBodyPadding` (16.0), `toolSectionGap` (12.0), `toolSectionRadius` (16.0), `toolSectionPadding` (16.0), `toolButtonRadius` (14.0), `toolButtonHeight` (52.0), `fontToolResult` (36.0), `fontToolLabel` (14.0), `fontToolButton` (16.0). All tool pages SHALL reference these tokens instead of hardcoded values.

#### Scenario: Tool page uses DT tokens for spacing

- **WHEN** user opens any tool page
- **THEN** the body area SHALL use `DT.toolBodyPadding` (16dp) for outer padding and `DT.toolSectionGap` (12dp) for spacing between sections

#### Scenario: Tool page uses DT tokens for typography

- **WHEN** a tool page displays a result value
- **THEN** the result text SHALL use `DT.fontToolResult` (36dp) font size


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Four standardized body layout modes

Tool pages SHALL follow one of four body layout modes based on their function:

- **Mode A (Input-Result)**: Unit converter, split bill, BMI calculator, password generator, QR generator SHALL organize body content as input section cards followed by a result section card. The result card SHALL use tool-color at 8% opacity (light) or 15% opacity (dark) as background to visually distinguish it from input cards.
- **Mode B (Grid Operation)**: Calculator SHALL display a full-area button grid within a single section card.
- **Mode C (Single Focus)**: Flashlight, stopwatch/timer, compass, level, noise meter SHALL display a central interactive element with a bottom control section card.
- **Mode D (Interactive Canvas)**: Screen ruler, protractor, color picker, random wheel SHALL display an interactive canvas area with a control panel section card.

#### Scenario: Split bill page follows Mode A layout

- **WHEN** user opens the split bill tool
- **THEN** the body SHALL display an input section card for amount and count, followed by a distinct result section card with tinted background showing per-person amount

#### Scenario: Calculator page follows Mode B layout

- **WHEN** user opens the calculator tool
- **THEN** the body SHALL display a button grid within a single section card filling the body area

#### Scenario: Flashlight page follows Mode C layout

- **WHEN** user opens the flashlight tool
- **THEN** the body SHALL display the SOS control within a centered section card at the bottom

#### Scenario: Random wheel page follows Mode D layout

- **WHEN** user opens the random wheel tool
- **THEN** the body SHALL display the wheel canvas above a control panel section card


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Brand color integration in body area

Tool page body areas SHALL integrate brand colors: section card labels SHALL use `DT.brandPrimary` (light mode) or `DT.brandPrimarySoft` (dark mode). Result values SHALL use the tool's gradient dark-end color. Input fields SHALL use `DT.brandPrimary` as focus border color. The body outer padding SHALL be `DT.toolBodyPadding`.

#### Scenario: Result value displays in tool gradient color

- **WHEN** the split bill calculator shows a per-person amount
- **THEN** the amount text SHALL be rendered in the tool's gradient start color (darker end)

#### Scenario: Input field focus uses brand color

- **WHEN** user taps an input field in any tool page
- **THEN** the input field border SHALL change to `DT.brandPrimary` color

<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->