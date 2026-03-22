# tool-word-counter Specification

## Purpose

TBD - created by archiving change 'tool-word-counter'. Update Purpose after archive.

## Requirements

### Requirement: Word counter tool page

The system SHALL provide a "Word Counter" tool page accessible from the tool registry. The page SHALL display a multiline text input field and real-time statistics.

#### Scenario: Page renders with empty state

- **WHEN** user navigates to the word counter tool
- **THEN** the page SHALL display an empty text input field and all statistics SHALL show 0 (reading time SHALL show "< 1 min")


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Character count

The system SHALL count the total number of characters in the input text, providing both with-spaces and without-spaces counts.

#### Scenario: Count characters with spaces

- **WHEN** user enters "Hello World"
- **THEN** character count (with spaces) SHALL display 11

#### Scenario: Count characters without spaces

- **WHEN** user enters "Hello World"
- **THEN** character count (without spaces) SHALL display 10


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Word count with CJK support

The system SHALL count words in the input text. Each CJK character SHALL be counted as one word. Latin-script words SHALL be counted by whitespace separation.

#### Scenario: Count English words

- **WHEN** user enters "Hello beautiful world"
- **THEN** word count SHALL display 3

#### Scenario: Count Chinese characters as words

- **WHEN** user enters "你好世界"
- **THEN** word count SHALL display 4

#### Scenario: Count mixed Chinese and English

- **WHEN** user enters "Hello 你好 World"
- **THEN** word count SHALL display 4 (2 English words + 2 Chinese characters)


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Line count

The system SHALL count the number of lines in the input text. An empty input SHALL have 0 lines.

#### Scenario: Count lines

- **WHEN** user enters text with 2 newline characters
- **THEN** line count SHALL display 3

#### Scenario: Empty input lines

- **WHEN** input is empty
- **THEN** line count SHALL display 0


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Paragraph count

The system SHALL count paragraphs, defined as blocks of text separated by one or more blank lines. An empty input SHALL have 0 paragraphs.

#### Scenario: Count paragraphs

- **WHEN** user enters two blocks of text separated by a blank line
- **THEN** paragraph count SHALL display 2

#### Scenario: Empty input paragraphs

- **WHEN** input is empty
- **THEN** paragraph count SHALL display 0


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Estimated reading time

The system SHALL estimate reading time based on Chinese characters at 300 chars/minute and English words at 200 words/minute. The minimum displayed value SHALL be "< 1 min" for non-empty text.

#### Scenario: Short text reading time

- **WHEN** user enters 100 Chinese characters
- **THEN** reading time SHALL display "< 1 min"

#### Scenario: Longer text reading time

- **WHEN** user enters 600 Chinese characters
- **THEN** reading time SHALL display "2 min"


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Real-time statistics update

The system SHALL update all statistics in real-time as the user types or modifies text. No manual refresh action SHALL be required.

#### Scenario: Statistics update on typing

- **WHEN** user types a character in the text field
- **THEN** all statistics SHALL update immediately


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Clear text action

The system SHALL provide a clear button in the AppBar that resets the text input and all statistics to their initial state.

#### Scenario: Clear text

- **WHEN** user taps the clear button
- **THEN** text input SHALL be empty and all statistics SHALL show 0


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Copy statistics summary

The system SHALL provide a copy button that copies a formatted summary of all statistics to the clipboard.

#### Scenario: Copy summary

- **WHEN** user taps the copy button
- **THEN** a formatted text summary of all statistics SHALL be copied to the clipboard and a confirmation snackbar SHALL appear


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Tool registry integration

The word counter tool SHALL be registered in the tool registry (`allTools`) with id `word_counter`, route path `/word-counter`, and category `life`.

#### Scenario: Tool appears on homepage

- **WHEN** user views the homepage tool grid
- **THEN** the word counter tool SHALL appear with appropriate icon and localized name


<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->

---
### Requirement: Internationalization support

The word counter tool SHALL support both Traditional Chinese and English through the existing i18n system (`AppLocalizations`).

#### Scenario: Chinese locale

- **WHEN** app locale is set to zh
- **THEN** all word counter UI text SHALL display in Traditional Chinese

#### Scenario: English locale

- **WHEN** app locale is set to en
- **THEN** all word counter UI text SHALL display in English

<!-- @trace
source: tool-word-counter
updated: 2026-03-23
code:
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/l10n/app_en.arb
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_zh.arb
  - lib/tools/word_counter/word_counter_page.dart
tests:
  - test/tools/word_counter_widget_test.dart
  - test/tools/word_counter_test.dart
-->