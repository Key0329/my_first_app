## MODIFIED Requirements

### Requirement: Home page tool search

The home page SHALL provide a functional search feature accessible via a placeholder search bar displayed below the title area. The search bar SHALL be a full-width rounded container with a search icon and localized hint text. When the user taps the search bar, a search interface SHALL open allowing the user to type a query. The search SHALL filter tools by matching against tool names (in the current locale) and category names. Results SHALL be displayed as a list of matching tools. Tapping a search result SHALL navigate to that tool's page. An empty query SHALL show suggestions or recent tools.

#### Scenario: User searches for a tool by name

- **WHEN** user taps the search bar and types "計算"
- **THEN** the search results SHALL show tools whose name contains "計算" in the current locale

#### Scenario: Search bar is visually prominent

- **WHEN** the home page loads
- **THEN** a full-width search bar with hint text SHALL be visible below the title area
