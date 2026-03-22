## MODIFIED Requirements

### Requirement: Theme mode selection

The settings page SHALL provide a theme mode selector using a SegmentedButton with three options: Light, Dark, and System Default. The selector SHALL be displayed inside a Bento-style ToolSectionCard in the "Appearance" section. The selected mode SHALL take effect immediately and persist across app restarts.

#### Scenario: User changes theme mode

- **WHEN** user selects a different theme mode via the SegmentedButton
- **THEN** the app theme SHALL change immediately

### Requirement: Language selection

The settings page SHALL provide a language selector using a SegmentedButton with two options: Traditional Chinese and English. The selector SHALL be displayed inside the same "Appearance" ToolSectionCard as the theme mode selector. The selected language SHALL take effect immediately and persist across app restarts.

#### Scenario: User changes language

- **WHEN** user selects a different language via the SegmentedButton
- **THEN** the app interface language SHALL change immediately

### Requirement: About and legal links

The settings page SHALL display the app version, a link to the privacy policy, and a link to the terms of use inside a Bento-style ToolSectionCard in the "About" section.

#### Scenario: User views about section

- **WHEN** user is on the settings page
- **THEN** the app version, privacy policy link, and terms of use link SHALL be visible inside a Bento-style card

## ADDED Requirements

### Requirement: Settings page Bento layout

The settings page SHALL use a Bento Grid-style layout with ToolSectionCard components instead of standard ListTile items. The settings SHALL be organized into three sections: "Appearance" (theme mode, language), "Data" (clear favorites, clear recent tools), and "About" (version, privacy, terms). Each section SHALL be wrapped in a ToolSectionCard with rounded corners and the standard card styling. The sections SHALL animate in with StaggeredFadeIn on page load.

#### Scenario: Settings page displays Bento-style cards

- **WHEN** user navigates to the settings page
- **THEN** settings items SHALL be displayed in Bento-style ToolSectionCard components organized into three sections

#### Scenario: Settings sections animate in

- **WHEN** the settings page loads
- **THEN** each section card SHALL animate in with the StaggeredFadeIn effect

### Requirement: Clear recent tools data

The settings page SHALL provide a "Clear Recent Tools" action in the "Data" section. Tapping the action SHALL clear all recent tools history from shared_preferences and update the UI immediately. A confirmation dialog SHALL be shown before clearing.

#### Scenario: User clears recent tools

- **WHEN** user taps "Clear Recent Tools" and confirms the dialog
- **THEN** the recent tools list SHALL be cleared from storage and the home page recent tools section SHALL be hidden
