## MODIFIED Requirements

### Requirement: Password generation

The tool SHALL generate random passwords based on user-configured settings. It SHALL support two modes: character-based (existing) and memorable word-based. In character mode, users configure length and character types. In memorable mode, users set word count (3-6) and the tool generates hyphen-joined random words.

#### Scenario: Character-based generation

- **WHEN** user configures length and character types and taps generate
- **THEN** a random password matching the configuration SHALL be generated

#### Scenario: Memorable password generation

- **WHEN** user enables memorable mode and sets word count to 4
- **THEN** a password of 4 random words joined by hyphens SHALL be generated

## ADDED Requirements

### Requirement: Password history storage

The password generator SHALL maintain a history of the last 20 generated passwords in SharedPreferences. Passwords SHALL be masked in the list by default and revealed on tap. A clear history button SHALL be provided.

#### Scenario: Password added to history

- **WHEN** a new password is generated
- **THEN** it SHALL appear at the top of the persistent history list
