## MODIFIED Requirements

### Requirement: Multi-language support

The app SHALL support two locales: Traditional Chinese (zh_TW) as the default and English (en). All user-facing strings SHALL be localized using Flutter's official internationalization mechanism (flutter_localizations + ARB files). All user-visible text in pages, tool pages, and shared widgets SHALL be sourced from AppLocalizations. Hardcoded Chinese strings SHALL NOT exist in any UI-rendering code. Both zh and en ARB files SHALL contain entries for every localization key.

#### Scenario: App displays in Traditional Chinese by default

- **WHEN** the user's device locale is zh_TW or the user has not changed the language setting
- **THEN** all UI text SHALL display in Traditional Chinese from AppLocalizations

#### Scenario: App pages display localized strings

- **WHEN** any page (home, settings, favorites, onboarding) is displayed
- **THEN** all visible text SHALL come from AppLocalizations, not hardcoded strings

#### Scenario: Tool pages display localized strings

- **WHEN** any of the 18 tool pages is displayed
- **THEN** all visible text (titles, labels, buttons, results, hints) SHALL come from AppLocalizations

#### Scenario: Shared widgets display localized strings

- **WHEN** shared widgets (error_state, confirm_dialog, share_button, etc.) are displayed
- **THEN** all visible text SHALL come from AppLocalizations

#### Scenario: Switching locale updates all text

- **WHEN** the user switches locale from zh to en in settings
- **THEN** all UI text across all pages and tools SHALL update to English
