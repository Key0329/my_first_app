## ADDED Requirements

### Requirement: Multi-language support

The app SHALL support two locales: Traditional Chinese (zh_TW) as the default and English (en). All user-facing strings SHALL be localized using Flutter's official internationalization mechanism (flutter_localizations + ARB files).

#### Scenario: App displays in Traditional Chinese by default

- **WHEN** the user's device locale is zh_TW or the user has not changed the language setting
- **THEN** all UI strings SHALL be displayed in Traditional Chinese

#### Scenario: App displays in English

- **WHEN** the user selects English in settings
- **THEN** all UI strings SHALL be displayed in English

### Requirement: Locale persistence

The selected locale SHALL persist across app restarts using shared_preferences. If no locale has been explicitly selected, the app SHALL use the device's system locale if supported, or fall back to Traditional Chinese.

#### Scenario: Locale persists after restart

- **WHEN** user has selected a locale and restarts the app
- **THEN** the previously selected locale SHALL be applied on launch
