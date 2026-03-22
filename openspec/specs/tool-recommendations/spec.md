# tool-recommendations Specification

## Purpose

TBD - created by archiving change 'tool-recommendations'. Update Purpose after archive.

## Requirements

### Requirement: Tool relation graph

The app SHALL maintain a static map of tool relationships where each tool ID maps to an ordered list of 1-2 recommended related tool IDs. The relation graph SHALL cover all tools defined in the app. If a tool has no explicitly defined relations, the system SHALL fall back to recommending tools from the same category.

#### Scenario: Tool has explicit relations

- **WHEN** the relation graph is queried for tool "calculator"
- **THEN** it SHALL return the defined related tool IDs (e.g., "unit_converter", "currency_converter")

#### Scenario: Tool falls back to same category

- **WHEN** a tool has no explicitly defined relations in the graph
- **THEN** the system SHALL return up to 2 other tools from the same category


<!-- @trace
source: tool-recommendations
updated: 2026-03-22
code:
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/models/tool_relations.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
tests:
  - test/models/tool_relations_test.dart
  - test/widgets/tool_recommendation_bar_test.dart
-->

---
### Requirement: Recommendation bar in tool pages

The `ImmersiveToolScaffold` SHALL accept an optional `toolId` parameter. When provided, the scaffold SHALL render a `ToolRecommendationBar` at the bottom of the body area displaying recommended tools from the relation graph. Each recommendation SHALL show the tool icon and name as a tappable chip. Tapping a recommendation chip SHALL navigate to the corresponding tool page.

#### Scenario: Tool page shows recommendations

- **WHEN** a tool page provides its `toolId` to the scaffold
- **THEN** the scaffold SHALL display a recommendation bar at the bottom with 1-2 related tool chips

#### Scenario: User taps a recommendation chip

- **WHEN** the user taps a recommended tool chip
- **THEN** the app SHALL navigate to that tool's page

#### Scenario: No toolId provided

- **WHEN** a tool page does not provide `toolId` to the scaffold
- **THEN** no recommendation bar SHALL be displayed

<!-- @trace
source: tool-recommendations
updated: 2026-03-22
code:
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/models/tool_relations.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
tests:
  - test/models/tool_relations_test.dart
  - test/widgets/tool_recommendation_bar_test.dart
-->