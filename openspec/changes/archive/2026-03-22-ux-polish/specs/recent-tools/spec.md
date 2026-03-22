## ADDED Requirements

### Requirement: Recent tools tracking

The app SHALL track the most recently used tools. When a user opens a tool page, that tool's ID SHALL be recorded at the top of the recent tools list. The recent tools list SHALL store a maximum of 5 entries. If the tool is already in the list, it SHALL be moved to the top (deduplication). The recent tools list SHALL be persisted using shared_preferences as a JSON array of tool IDs.

#### Scenario: Tool usage is recorded

- **WHEN** the user navigates to a tool page
- **THEN** that tool's ID SHALL be added to the top of the recent tools list

#### Scenario: Duplicate tool usage updates position

- **WHEN** the user opens a tool that is already in the recent tools list
- **THEN** the tool SHALL be moved to the top of the list without creating a duplicate entry

#### Scenario: Recent tools list respects maximum size

- **WHEN** the recent tools list already contains 5 entries and the user opens a new tool
- **THEN** the oldest entry SHALL be removed and the new tool SHALL be added at the top

### Requirement: Recent tools display on home page

The home page SHALL display a "Recent Tools" horizontal scrolling section above the tool grid when the recent tools list is not empty. Each recent tool SHALL be displayed as a circular gradient card showing the tool icon. Tapping a recent tool card SHALL navigate to that tool's page. The section SHALL be hidden when the recent tools list is empty.

#### Scenario: Recent tools section is visible

- **WHEN** the home page loads and the recent tools list contains at least one entry
- **THEN** the "Recent Tools" section SHALL be displayed above the tool grid with horizontal scrolling cards

#### Scenario: Recent tools section is hidden when empty

- **WHEN** the home page loads and the recent tools list is empty
- **THEN** the "Recent Tools" section SHALL NOT be displayed

#### Scenario: Tapping a recent tool card navigates to tool page

- **WHEN** the user taps a recent tool card in the horizontal section
- **THEN** the app SHALL navigate to that tool's page

### Requirement: Recent tools persistence

The recent tools list SHALL persist across app restarts using shared_preferences. On app launch, the recent tools list SHALL be loaded from local storage. If no stored data exists, the list SHALL be initialized as empty.

#### Scenario: Recent tools persist after restart

- **WHEN** the user has used tools and restarts the app
- **THEN** the recent tools list SHALL be restored from local storage

#### Scenario: Fresh install has empty recent tools

- **WHEN** the app launches for the first time with no stored recent tools data
- **THEN** the recent tools list SHALL be empty and the section SHALL be hidden
