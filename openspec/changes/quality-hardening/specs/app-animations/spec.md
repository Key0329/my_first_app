## ADDED Requirements

### Requirement: Motion Token constants in Design Tokens

The DT class SHALL define Motion Token constants for animation durations. The following constants SHALL be defined: `durationFast` as Duration(milliseconds: 150) for button feedback and micro-interactions, `durationMedium` as Duration(milliseconds: 300) for page transitions and expand/collapse animations, and `durationSlow` as Duration(milliseconds: 500) for complex animations and initial page load effects. All animation durations throughout the app SHALL reference these Motion Token constants instead of using inline magic numbers.

#### Scenario: Motion Token durationFast is defined

- **WHEN** code references DT.durationFast
- **THEN** it SHALL resolve to Duration(milliseconds: 150)

#### Scenario: Motion Token durationMedium is defined

- **WHEN** code references DT.durationMedium
- **THEN** it SHALL resolve to Duration(milliseconds: 300)

#### Scenario: Motion Token durationSlow is defined

- **WHEN** code references DT.durationSlow
- **THEN** it SHALL resolve to Duration(milliseconds: 500)

### Requirement: Opacity Token constants in Design Tokens

The DT class SHALL define Opacity Token constants. The following constants SHALL be defined: `opacityDisabled` as 0.38 for disabled state elements, `opacityOverlay` as 0.08 for press overlay effects, and `opacityHover` as 0.04 for hover overlay effects. All opacity values throughout the app SHALL reference these Opacity Token constants instead of using inline magic numbers.

#### Scenario: Opacity Token opacityDisabled is defined

- **WHEN** code references DT.opacityDisabled
- **THEN** it SHALL resolve to 0.38

#### Scenario: Opacity Token opacityOverlay is defined

- **WHEN** code references DT.opacityOverlay
- **THEN** it SHALL resolve to 0.08

#### Scenario: Opacity Token opacityHover is defined

- **WHEN** code references DT.opacityHover
- **THEN** it SHALL resolve to 0.04
