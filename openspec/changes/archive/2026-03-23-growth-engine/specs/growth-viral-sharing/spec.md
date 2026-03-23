## ADDED Requirements

### Requirement: Share hook text for tools

The system SHALL provide tool-specific "comparison hook" text when sharing results. The hook text SHALL encourage the recipient to try the tool themselves.

#### Scenario: BMI share hook

- **WHEN** user shares a BMI result
- **THEN** the share text SHALL include a comparison hook like "My BMI is {value}, what's yours?"

#### Scenario: Noise meter share hook

- **WHEN** user shares a noise meter reading
- **THEN** the share text SHALL include a challenge hook like "I measured {value} dB, how loud is your environment?"

#### Scenario: Split bill share hook

- **WHEN** user shares a split bill result
- **THEN** the share text SHALL include a fun tone in the share message

#### Scenario: Tool without custom hook

- **WHEN** user shares from a tool without a defined hook
- **THEN** the share text SHALL use the default generic share format

### Requirement: Share hook localization

All share hook texts SHALL be localized through the i18n system supporting both Traditional Chinese and English.

#### Scenario: Chinese share hook

- **WHEN** app locale is zh and user shares a result
- **THEN** the hook text SHALL display in Traditional Chinese

#### Scenario: English share hook

- **WHEN** app locale is en and user shares a result
- **THEN** the hook text SHALL display in English
