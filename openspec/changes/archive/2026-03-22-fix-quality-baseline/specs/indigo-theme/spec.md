## MODIFIED Requirements

### Requirement: Dark mode deep indigo surface colors

In dark mode, the scaffold background color SHALL be #1A1A2E (deep indigo blue). Card and surface container colors SHALL be #16213E. These values SHALL override the default Material 3 dark surface colors using `ColorScheme.copyWith()`. The `darkSubtitle` text color SHALL be #9999BB to achieve a contrast ratio of at least 4.5:1 against the scaffold background (#1A1A2E), meeting WCAG AA requirements. The `darkNavInactive` icon/text color SHALL be #8888AA to achieve a contrast ratio of at least 4.5:1 against the navigation background (#16213E), meeting WCAG AA requirements.

#### Scenario: Dark mode uses deep indigo background

- **WHEN** the app is in dark mode
- **THEN** the scaffold background SHALL be #1A1A2E

#### Scenario: Dark mode cards use custom surface color

- **WHEN** the app is in dark mode
- **THEN** card backgrounds SHALL be #16213E

#### Scenario: Dark mode subtitle text meets WCAG AA contrast

- **WHEN** the app is in dark mode
- **THEN** the subtitle text color SHALL be #9999BB and the contrast ratio against the scaffold background (#1A1A2E) SHALL be at least 4.5:1

#### Scenario: Dark mode navigation inactive color meets WCAG AA contrast

- **WHEN** the app is in dark mode
- **THEN** the navigation inactive icon/text color SHALL be #8888AA and the contrast ratio against the navigation background (#16213E) SHALL be at least 4.5:1
