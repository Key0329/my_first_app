## ADDED Requirements

### Requirement: Daily tool recommendation

The system SHALL display a daily recommended tool card on the homepage. The recommendation SHALL prioritize tools the user has not recently used.

#### Scenario: Show daily recommendation

- **WHEN** user opens the homepage
- **THEN** a recommendation card SHALL appear above the recent tools section, showing a tool the user has not recently used

#### Scenario: Same recommendation within a day

- **WHEN** user opens the homepage multiple times in the same day
- **THEN** the recommended tool SHALL remain the same

#### Scenario: Different recommendation on new day

- **WHEN** user opens the homepage on a new day
- **THEN** the recommended tool SHALL change

#### Scenario: All tools recently used

- **WHEN** user has recently used all available tools
- **THEN** the system SHALL still display a recommendation by selecting any tool

### Requirement: Usage streak tracking

The system SHALL track the number of consecutive days the user has actively used any tool. The streak count SHALL persist across app restarts.

#### Scenario: First day usage

- **WHEN** user uses a tool for the first time
- **THEN** the streak count SHALL be set to 1

#### Scenario: Consecutive day usage

- **WHEN** user uses a tool on the day after their last active day
- **THEN** the streak count SHALL increment by 1

#### Scenario: Streak broken

- **WHEN** user has not used any tool for more than 1 day
- **THEN** the streak count SHALL reset to 1 on the next usage

#### Scenario: Multiple uses same day

- **WHEN** user uses multiple tools on the same day
- **THEN** the streak count SHALL not change (already counted for today)

### Requirement: Streak display on homepage

The system SHALL display the current streak count on the homepage with a fire icon.

#### Scenario: Active streak

- **WHEN** user has a streak of 3 or more days
- **THEN** the homepage SHALL display a fire icon with the streak count (e.g., "🔥 3 天")

#### Scenario: No streak or streak is 1

- **WHEN** user streak is 0 or 1
- **THEN** the streak indicator SHALL still be displayed showing the current count

### Requirement: Streak persistence

The streak data (count and last active date) SHALL be persisted using SharedPreferences and survive app restarts.

#### Scenario: Streak survives restart

- **WHEN** user restarts the app on the same day
- **THEN** the streak count SHALL remain unchanged

### Requirement: Retention i18n support

All retention-related UI text SHALL support both Traditional Chinese and English through the i18n system.

#### Scenario: Chinese locale retention text

- **WHEN** app locale is zh
- **THEN** all retention UI text (daily recommendation, streak) SHALL display in Traditional Chinese

#### Scenario: English locale retention text

- **WHEN** app locale is en
- **THEN** all retention UI text SHALL display in English
