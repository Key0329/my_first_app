## ADDED Requirements

### Requirement: ToolTag enum with five categories

The system SHALL define a ToolTag enum with five values: calculate, measure, life, productivity, and finance. Each tag SHALL have a localized display label accessible via AppLocalizations.

#### Scenario: All five tags are defined

- **WHEN** the ToolTag enum is referenced
- **THEN** it SHALL contain exactly five values: calculate, measure, life, productivity, finance

### Requirement: ToolItem supports multiple tags

Each ToolItem SHALL have a `tags` field of type `Set<ToolTag>` containing 1-3 tags. The existing `category` getter SHALL return the first tag in the set for backward compatibility. Every tool in allTools SHALL have at least one tag assigned.

#### Scenario: Tool has multiple tags

- **WHEN** the currency_converter ToolItem is queried
- **THEN** its tags SHALL contain both ToolTag.calculate and ToolTag.finance

#### Scenario: Category getter returns first tag

- **WHEN** a ToolItem's category getter is accessed
- **THEN** it SHALL return the first tag from the tags set

### Requirement: Tag-based filtering on home page

The home page tab filtering SHALL use tag-based matching instead of exact category matching. When a tag tab is selected, the tool grid SHALL display all tools whose tags set contains the selected tag. When "All" is selected, all tools SHALL be displayed.

#### Scenario: Filtering by productivity tag

- **WHEN** user selects the "Productivity" tab
- **THEN** the grid SHALL show all tools that have ToolTag.productivity in their tags set

#### Scenario: Tool appears in multiple tabs

- **WHEN** a tool has tags {calculate, finance}
- **THEN** the tool SHALL appear in both the Calculate tab and the Finance tab
