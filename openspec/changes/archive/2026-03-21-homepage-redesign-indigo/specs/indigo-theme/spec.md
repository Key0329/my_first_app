## ADDED Requirements

### Requirement: Indigo brand color seed

The app theme SHALL use `ColorScheme.fromSeed(seedColor: Color(0xFF6C5CE7))` as the brand color for both light and dark modes. All Material 3 components SHALL derive their colors from this seed.

#### Scenario: App uses indigo color scheme

- **WHEN** the app starts
- **THEN** the Material 3 color scheme SHALL be generated from the indigo seed color #6C5CE7

### Requirement: Dark mode deep indigo surface colors

In dark mode, the scaffold background color SHALL be #1A1A2E (deep indigo blue). Card and surface container colors SHALL be #16213E. These values SHALL override the default Material 3 dark surface colors using `ColorScheme.copyWith()`.

#### Scenario: Dark mode uses deep indigo background

- **WHEN** the app is in dark mode
- **THEN** the scaffold background SHALL be #1A1A2E

#### Scenario: Dark mode cards use custom surface color

- **WHEN** the app is in dark mode
- **THEN** card backgrounds SHALL be #16213E

### Requirement: Light mode uses standard Material 3 surfaces

In light mode, the surface colors SHALL use the default Material 3 values generated from the indigo seed color. No custom surface overrides SHALL be applied in light mode.

#### Scenario: Light mode uses generated surfaces

- **WHEN** the app is in light mode
- **THEN** surface colors SHALL be the default Material 3 generated values from the indigo seed
