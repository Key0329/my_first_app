# growth-viral-sharing Specification

## Purpose

TBD - created by archiving change 'growth-engine'. Update Purpose after archive.

## Requirements

### Requirement: Share hook text for tools

The system SHALL provide tool-specific "comparison hook" text when sharing results. The hook text SHALL encourage the recipient to try the tool themselves.

#### Scenario: BMI share hook

- **WHEN** user shares a BMI result
- **THEN** the share text SHALL include a comparison hook like "My BMI is {value}, what's yours?"

#### Scenario: Noise meter share hook

- **WHEN** user shares a noise meter reading
- **THEN** the share text SHALL include a challenge hook like "I measured {value} dB, how loud is your environment?"

#### Scenario: Split bill share hook

- **WHEN** user shares a split bill result
- **THEN** the share text SHALL include a fun tone in the share message

#### Scenario: Tool without custom hook

- **WHEN** user shares from a tool without a defined hook
- **THEN** the share text SHALL use the default generic share format


<!-- @trace
source: growth-engine
updated: 2026-03-23
code:
  - lib/tools/split_bill/split_bill_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/user_preferences_service.dart
  - lib/l10n/app_zh.arb
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/l10n/app_en.arb
  - lib/services/settings_service.dart
  - lib/l10n/app_localizations.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations_zh.dart
tests:
  - test/services/growth_engine_test.dart
  - test/pages/growth_engine_widget_test.dart
-->

---
### Requirement: Share hook localization

All share hook texts SHALL be localized through the i18n system supporting both Traditional Chinese and English.

#### Scenario: Chinese share hook

- **WHEN** app locale is zh and user shares a result
- **THEN** the hook text SHALL display in Traditional Chinese

#### Scenario: English share hook

- **WHEN** app locale is en and user shares a result
- **THEN** the hook text SHALL display in English

<!-- @trace
source: growth-engine
updated: 2026-03-23
code:
  - lib/tools/split_bill/split_bill_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/user_preferences_service.dart
  - lib/l10n/app_zh.arb
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/l10n/app_en.arb
  - lib/services/settings_service.dart
  - lib/l10n/app_localizations.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_localizations_zh.dart
tests:
  - test/services/growth_engine_test.dart
  - test/pages/growth_engine_widget_test.dart
-->