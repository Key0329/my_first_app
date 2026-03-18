## ADDED Requirements

### Requirement: Theme mode selection

The settings page SHALL provide a theme mode selector with three options: Light (亮色), Dark (暗色), and System Default (跟隨系統). The selected mode SHALL take effect immediately and persist across app restarts.

#### Scenario: User changes theme mode

- **WHEN** user selects a different theme mode
- **THEN** the app theme SHALL change immediately

### Requirement: Language selection

The settings page SHALL provide a language selector with two options: 繁體中文 and English. The selected language SHALL take effect immediately and persist across app restarts.

#### Scenario: User changes language

- **WHEN** user selects a different language
- **THEN** the app interface language SHALL change immediately

### Requirement: About and legal links

The settings page SHALL display the app version, a link to the privacy policy, and a link to the terms of use.

#### Scenario: User views about section

- **WHEN** user is on the settings page
- **THEN** the app version, privacy policy link, and terms of use link SHALL be visible
