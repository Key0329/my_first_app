# share-result-cards Specification

## Purpose

TBD - created by archiving change 'share-result-cards'. Update Purpose after archive.

## Requirements

### Requirement: Share card image generation

The app SHALL provide a `ShareCardGenerator` utility that captures a Flutter Widget as a PNG image using `RepaintBoundary` and `toImage()`. The generated image SHALL be saved to the device's temporary directory as a PNG file. The generator SHALL return an `XFile` suitable for sharing via `share_plus`.

#### Scenario: Widget is captured as PNG image

- **WHEN** `ShareCardGenerator.capture()` is called with a `GlobalKey` attached to a `RepaintBoundary`
- **THEN** it SHALL return an `XFile` pointing to a PNG image in the temporary directory


<!-- @trace
source: share-result-cards
updated: 2026-03-22
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/widgets/share_card_template.dart
  - pubspec.lock
  - pubspec.yaml
  - lib/widgets/share_card_generator.dart
-->

---
### Requirement: Branded share card template

The app SHALL provide a `ShareCardTemplate` widget that renders a branded share card with: a gradient border using the tool's gradient colors, the tool name, a custom result content widget, and a bottom watermark displaying the app name "Spectra 工具箱". The card SHALL have a fixed logical size suitable for social media sharing.

#### Scenario: Card renders with brand elements

- **WHEN** a `ShareCardTemplate` is rendered with tool name and result content
- **THEN** it SHALL display the gradient border, tool name, result content, and "Spectra 工具箱" watermark


<!-- @trace
source: share-result-cards
updated: 2026-03-22
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/widgets/share_card_template.dart
  - pubspec.lock
  - pubspec.yaml
  - lib/widgets/share_card_generator.dart
-->

---
### Requirement: Tool-specific share cards

The split bill, BMI calculator, random wheel, and date calculator tools SHALL generate branded share card images when the user taps the share button, instead of sharing plain text only. The share card SHALL contain the tool's calculation result formatted for visual clarity. The `ShareButton` SHALL receive the generated `XFile` via its `shareFiles` parameter.

#### Scenario: Split bill shares result card

- **WHEN** the user taps share after completing a split bill calculation
- **THEN** the app SHALL generate a share card image showing the total, per-person amount, and number of people

#### Scenario: BMI shares result card

- **WHEN** the user taps share after calculating BMI
- **THEN** the app SHALL generate a share card image showing the BMI value and category

#### Scenario: Random wheel shares result card

- **WHEN** the user taps share after spinning the wheel
- **THEN** the app SHALL generate a share card image showing the selected result

#### Scenario: Date calculator shares result card

- **WHEN** the user taps share after calculating a date interval
- **THEN** the app SHALL generate a share card image showing the date range and interval

<!-- @trace
source: share-result-cards
updated: 2026-03-22
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/widgets/share_card_template.dart
  - pubspec.lock
  - pubspec.yaml
  - lib/widgets/share_card_generator.dart
-->