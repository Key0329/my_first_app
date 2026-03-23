## MODIFIED Requirements

### Requirement: Uniform two-column grid layout

The home page SHALL display tools in a responsive grid layout using SliverGrid within a CustomScrollView. The grid column count SHALL be determined by the available width: 2 columns for less than 600dp, 3 columns for 600-900dp, and 4 columns for greater than 900dp. The grid SHALL maintain consistent spacing using DT.gridSpacing for both main axis and cross axis spacing. The childAspectRatio SHALL be 1.2. Tools SHALL be filterable by tag selection from the category tab bar.

#### Scenario: Grid renders with correct column count on phone

- **WHEN** the home page renders on a phone with width less than 600dp
- **THEN** the tool grid SHALL display in 2 columns with DT.gridSpacing spacing

#### Scenario: Grid filters tools by selected tag

- **WHEN** user selects a tag tab
- **THEN** the grid SHALL display only tools whose tags contain the selected tag
