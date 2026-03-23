## ADDED Requirements

### Requirement: Quick notes list page

The system SHALL provide a "Quick Notes" tool page that displays all saved notes in a card list, sorted by most recently updated first.

#### Scenario: Page renders with empty state

- **WHEN** user navigates to quick notes and has no saved notes
- **THEN** the page SHALL display an empty state message and a floating action button to create a new note

#### Scenario: Page renders with existing notes

- **WHEN** user navigates to quick notes with existing notes
- **THEN** the page SHALL display note cards showing title (or first line of content), update time, and a preview of the content

### Requirement: Create note

The system SHALL allow users to create new notes by tapping the floating action button, which navigates to an edit page.

#### Scenario: Create new note

- **WHEN** user taps the FAB on the notes list page
- **THEN** the system SHALL navigate to an empty note edit page

#### Scenario: Save new note

- **WHEN** user enters content on the edit page and navigates back
- **THEN** the system SHALL save the note with the current timestamp and display it in the list

### Requirement: Edit note

The system SHALL allow users to edit existing notes by tapping on a note card.

#### Scenario: Edit existing note

- **WHEN** user taps on a note card
- **THEN** the system SHALL navigate to the edit page pre-filled with the note's title and content

#### Scenario: Auto-save on back

- **WHEN** user modifies a note and navigates back
- **THEN** the system SHALL update the note with the new content and updated timestamp

### Requirement: Delete note

The system SHALL allow users to delete notes with a confirmation dialog to prevent accidental deletion.

#### Scenario: Delete with confirmation

- **WHEN** user triggers delete on a note (via swipe or long press)
- **THEN** the system SHALL show a confirmation dialog before deleting

#### Scenario: Confirm delete

- **WHEN** user confirms the delete action
- **THEN** the note SHALL be permanently removed from the list and storage

### Requirement: Search notes

The system SHALL provide a search field that filters the note list in real-time based on title and content matching (case-insensitive).

#### Scenario: Filter notes by search

- **WHEN** user types a query in the search field
- **THEN** only notes whose title or content contains the query SHALL be displayed

#### Scenario: Clear search

- **WHEN** user clears the search field
- **THEN** all notes SHALL be displayed

### Requirement: Note data model

Each note SHALL have an id (unique string), optional title, content, createdAt timestamp, and updatedAt timestamp.

#### Scenario: Note with title

- **WHEN** user provides both title and content
- **THEN** the note SHALL store both fields

#### Scenario: Note without title

- **WHEN** user provides only content without title
- **THEN** the note card SHALL display the first line of content as the title

### Requirement: Local persistence

Notes SHALL be persisted locally using SharedPreferences with JSON serialization. Data SHALL survive app restarts.

#### Scenario: Notes persist across restarts

- **WHEN** user creates notes and restarts the app
- **THEN** all previously saved notes SHALL be restored

### Requirement: Tool registry integration

The quick notes tool SHALL be registered in the tool registry with id `quick_notes`, route path `/quick-notes`, and category `life`.

#### Scenario: Tool appears on homepage

- **WHEN** user views the homepage tool grid
- **THEN** the quick notes tool SHALL appear with appropriate icon and localized name

### Requirement: Internationalization support

The quick notes tool SHALL support both Traditional Chinese and English through the existing i18n system.

#### Scenario: Chinese locale

- **WHEN** app locale is set to zh
- **THEN** all quick notes UI text SHALL display in Traditional Chinese

#### Scenario: English locale

- **WHEN** app locale is set to en
- **THEN** all quick notes UI text SHALL display in English
