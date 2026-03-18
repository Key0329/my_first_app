## ADDED Requirements

### Requirement: Password generation

The password generator SHALL generate random passwords based on user-configured options: length (8-64 characters), uppercase letters, lowercase letters, numbers, and special characters. At least one character type MUST be selected.

#### Scenario: User generates a password with default settings

- **WHEN** user taps the generate button with default settings
- **THEN** a random password SHALL be generated and displayed

#### Scenario: User customizes password options

- **WHEN** user sets length to 16 and enables only uppercase and numbers
- **THEN** the generated password SHALL be 16 characters long containing only uppercase letters and numbers

### Requirement: One-tap copy

The generator SHALL provide a one-tap copy button that copies the generated password to the clipboard. A confirmation message SHALL be shown after copying.

#### Scenario: User copies a password

- **WHEN** user taps the copy button
- **THEN** the password SHALL be copied to the clipboard and a confirmation snackbar SHALL appear

### Requirement: Password strength indicator

The generator SHALL display a visual strength indicator (weak, medium, strong, very strong) based on the configured password length and character types.

#### Scenario: User sees password strength

- **WHEN** a password is generated
- **THEN** a color-coded strength indicator SHALL reflect the password complexity
