## ADDED Requirements

### Requirement: Localization strings for new tools

The localization system SHALL include translated strings for all four new tools in both Traditional Chinese (zh) and English (en). The following i18n keys SHALL be added:

- `tool_bmi_calculator`: BMI Calculator / BMI 計算機
- `tool_split_bill`: Split Bill / AA 制分帳
- `tool_random_wheel`: Random Wheel / 隨機決定器
- `tool_screen_ruler`: Screen Ruler / 螢幕尺規

Each tool page SHALL also have localized strings for its UI elements (labels, buttons, category names, empty states).

#### Scenario: New tool names display in Traditional Chinese

- **WHEN** app locale is set to zh
- **THEN** the four new tools SHALL display their Traditional Chinese names on the home page and tool page AppBar

#### Scenario: New tool names display in English

- **WHEN** app locale is set to en
- **THEN** the four new tools SHALL display their English names on the home page and tool page AppBar

## REMOVED Requirements

### Requirement: Invoice checker localization strings

**Reason**: The invoice checker tool is being removed from the application.
**Migration**: Remove all `tool_invoice_checker` prefixed keys from both `app_en.arb` and `app_zh.arb`. No user-facing migration needed.

#### Scenario: Invoice checker strings are removed

- **WHEN** the localization files are regenerated after removing invoice checker keys
- **THEN** no `tool_invoice_checker` prefixed keys SHALL exist in any ARB file or generated localization class
