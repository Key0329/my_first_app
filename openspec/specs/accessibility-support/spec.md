# accessibility-support Specification

## Purpose

TBD - created by archiving change 'quality-hardening'. Update Purpose after archive.

## Requirements

### Requirement: Calculator button semantics

Each calculator button SHALL be wrapped in a Semantics widget with `button: true` and a descriptive `label` property. Operator buttons SHALL have labels describing their function (e.g., "addition", "subtraction", "equals", "clear"). Digit buttons SHALL have labels matching their digit value. The semantic labels SHALL be localized.

#### Scenario: Screen reader announces calculator button function

- **WHEN** a screen reader focuses on the addition operator button
- **THEN** the button SHALL be announced with its semantic label "addition" (or localized equivalent) and identified as a button

#### Scenario: Screen reader announces digit button

- **WHEN** a screen reader focuses on a digit button (e.g., "7")
- **THEN** the button SHALL be announced with its digit value and identified as a button


<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: Noise meter value semantics

The noise meter's current dB reading display SHALL be wrapped in a Semantics widget with `value` set to the current dB reading including the unit, and `liveRegion: true` so screen readers announce value changes automatically. The semantic label SHALL describe the reading (e.g., "current noise level").

#### Scenario: Screen reader announces dB value changes

- **WHEN** the noise meter updates its dB reading
- **THEN** the screen reader SHALL automatically announce the new value because the Semantics widget has liveRegion set to true

#### Scenario: Noise meter value includes unit in semantics

- **WHEN** a screen reader reads the noise meter value
- **THEN** the announced value SHALL include the numeric reading and the "dB" unit


<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: Compass bearing semantics

The compass display SHALL include a Semantics widget with a `label` describing the current bearing in a human-readable format (e.g., "North-East, 45 degrees"). The semantic label SHALL update as the bearing changes.

#### Scenario: Screen reader announces compass bearing

- **WHEN** a screen reader focuses on the compass display showing 45 degrees
- **THEN** it SHALL announce the bearing as the direction name and degree value

#### Scenario: Compass semantics update with rotation

- **WHEN** the device rotates and the compass bearing changes
- **THEN** the Semantics label SHALL update to reflect the new bearing direction and degree value


<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: Protractor angle semantics

The protractor's angle display SHALL include a Semantics widget with a `value` property set to the current measured angle including the degree unit. The label SHALL describe the measurement (e.g., "measured angle").

#### Scenario: Screen reader announces protractor angle

- **WHEN** a screen reader focuses on the protractor angle display
- **THEN** it SHALL announce the measured angle value with the degree unit

#### Scenario: Protractor angle semantics update on measurement

- **WHEN** the user adjusts the protractor and the angle changes
- **THEN** the Semantics value SHALL update to reflect the new angle measurement

<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: Level tool angle semantics

The level tool's angle display SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the current tilt angle including the degree unit. The label SHALL describe the measurement (e.g., "tilt angle").

#### Scenario: Screen reader announces level angle

- **WHEN** a screen reader focuses on the level tool angle display
- **THEN** it SHALL announce the tilt angle value with the degree unit

#### Scenario: Level angle updates announce automatically

- **WHEN** the device tilts and the level angle changes
- **THEN** the screen reader SHALL automatically announce the new value because the Semantics widget has liveRegion set to true


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
### Requirement: Flashlight toggle semantics

The flashlight toggle button SHALL include a Semantics widget with `label` describing its current state ("flashlight on" or "flashlight off") and `hint` describing the action ("double tap to toggle"). The toggled property SHALL reflect the current on/off state.

#### Scenario: Screen reader announces flashlight state

- **WHEN** a screen reader focuses on the flashlight toggle
- **THEN** it SHALL announce the current state label and the toggle hint


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
### Requirement: Screen ruler measurement semantics

The screen ruler's measurement display SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the current measurement including the unit (mm or inch).

#### Scenario: Screen reader announces ruler measurement

- **WHEN** the screen ruler displays a measurement of 45mm
- **THEN** the Semantics value SHALL be "45 mm" and it SHALL be announced automatically as a live region


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
### Requirement: Random wheel result semantics

The random wheel result overlay SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the selected result text, so screen readers announce the winner automatically.

#### Scenario: Screen reader announces wheel result

- **WHEN** the random wheel stops spinning and displays a result
- **THEN** the screen reader SHALL automatically announce the selected result text


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
### Requirement: Timer countdown semantics

The stopwatch/timer countdown display SHALL include a Semantics widget with a `value` property set to the remaining time in a human-readable format (e.g., "5 minutes 30 seconds remaining"). The Semantics SHALL NOT use liveRegion to avoid excessive announcements during countdown.

#### Scenario: Screen reader reads timer value

- **WHEN** a screen reader focuses on the timer countdown display showing 5:30
- **THEN** it SHALL announce "5 minutes 30 seconds remaining" (or localized equivalent)


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
### Requirement: Password generator result semantics

The password generator's generated password display SHALL include a Semantics widget with a `value` property set to the generated password spelled out character by character for screen reader users, and a `label` of "generated password".

#### Scenario: Screen reader reads generated password

- **WHEN** a screen reader focuses on the generated password display
- **THEN** it SHALL announce "generated password" as the label followed by the password value


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
### Requirement: QR code result semantics

The QR scanner's decoded result display SHALL include a Semantics widget with `liveRegion: true` and a `value` property set to the decoded text, so screen readers announce scan results automatically.

#### Scenario: Screen reader announces QR scan result

- **WHEN** the QR scanner decodes a QR code and displays the result
- **THEN** the screen reader SHALL automatically announce the decoded text

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