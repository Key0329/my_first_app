## ADDED Requirements

### Requirement: Home page tool search

The home page SHALL provide a functional search feature accessible via the search icon button. When the user taps the search icon, a search interface SHALL open allowing the user to type a query. The search SHALL filter tools by matching against tool names (in the current locale) and category names. Results SHALL be displayed as a list of matching tools. Tapping a search result SHALL navigate to that tool's page. An empty query SHALL show suggestions or recent tools.

#### Scenario: User searches for a tool by name

- **WHEN** user taps the search icon and types "計算"
- **THEN** the search results SHALL show "計算機" and "BMI 計算機" as matching tools

#### Scenario: User taps a search result

- **WHEN** user taps a tool in the search results
- **THEN** the app SHALL navigate to that tool's page

#### Scenario: No matching tools

- **WHEN** user types a query that matches no tools
- **THEN** the search interface SHALL display a "no results found" message
