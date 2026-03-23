## ADDED Requirements

### Requirement: Placeholder search bar on home page

The home page SHALL display a placeholder search bar below the title area instead of the current small search icon button. The search bar SHALL be a non-editable container styled as a rounded rectangle with a search icon and hint text (e.g., "Search tools..."). When tapped, the search bar SHALL open the existing ToolSearchDelegate via showSearch. The search bar SHALL be visually prominent and span the full width minus horizontal padding.

#### Scenario: User taps placeholder search bar

- **WHEN** user taps the placeholder search bar on the home page
- **THEN** the system SHALL open the ToolSearchDelegate search interface

#### Scenario: Search bar displays hint text

- **WHEN** the home page loads
- **THEN** the search bar SHALL display the localized hint text with a search icon

### Requirement: Tab switch transition animation

The home page tool grid content area SHALL animate when switching between category tabs. The transition SHALL use AnimatedSwitcher with a fade and horizontal slide effect. The outgoing content SHALL fade out while sliding left, and the incoming content SHALL fade in while sliding right. The animation duration SHALL be DT.durationMedium.

#### Scenario: User switches from All tab to Life tab

- **WHEN** user taps the "Life" category tab while "All" is selected
- **THEN** the tool grid SHALL animate with a fade-slide transition from the All content to the Life content

### Requirement: Recent tools only in All tab

The recent tools section on the home page SHALL only be visible when the "All" (first) tab is selected. When any other category tab is selected, the recent tools section SHALL be hidden.

#### Scenario: Recent tools visible in All tab

- **WHEN** user views the home page with the "All" tab selected and has recent tool usage
- **THEN** the recent tools section SHALL be displayed

#### Scenario: Recent tools hidden in category tab

- **WHEN** user switches to a specific category tab (e.g., "Life")
- **THEN** the recent tools section SHALL NOT be displayed

### Requirement: Collapsible title area with SliverAppBar

The home page SHALL use a CustomScrollView with a SliverAppBar for the title area. The SliverAppBar SHALL collapse when the user scrolls down and reappear when scrolling up (floating: true, snap: true). The expanded state SHALL show the app title, subtitle, and search bar. The collapsed state SHALL hide the subtitle and reduce the title size.

#### Scenario: Title collapses on scroll down

- **WHEN** user scrolls down the tool grid
- **THEN** the title area SHALL collapse, hiding the subtitle and search bar

#### Scenario: Title reappears on scroll up

- **WHEN** user scrolls up while the title is collapsed
- **THEN** the title area SHALL snap back to its expanded state
