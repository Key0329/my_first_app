## ADDED Requirements

### Requirement: Uniform two-column grid layout

The home page SHALL display all tools in a uniform 2-column GridView with equal-sized cards. Each card SHALL have a fixed aspect ratio of approximately 1:1. The grid SHALL have 12px spacing between items.

#### Scenario: Home page displays uniform grid

- **WHEN** user navigates to the Tools tab
- **THEN** all tools SHALL be displayed in a uniform 2-column grid with equal-sized cards

### Requirement: Category tab filtering

The home page SHALL display a horizontal row of category filter chips below the title area. The categories SHALL be: 全部 (All), 計算 (Calculate), 測量 (Measure), 生活 (Life). The 全部 chip SHALL be selected by default. When a category is selected, only tools belonging to that category SHALL be displayed. The chip style SHALL use a filled/selected state for the active category and an outlined state for inactive categories.

#### Scenario: Default shows all tools

- **WHEN** user opens the home page
- **THEN** the 全部 category chip SHALL be selected and all tools SHALL be visible

#### Scenario: User selects a category

- **WHEN** user taps the 計算 category chip
- **THEN** only tools categorized as 計算 SHALL be displayed in the grid

#### Scenario: User switches back to all

- **WHEN** user taps the 全部 chip after filtering by a category
- **THEN** all tools SHALL be displayed again

### Requirement: Tool card with colored rounded-square icon

Each tool card SHALL display a centered colored rounded-square container (border-radius 12px) with the tool's designated color as background. Inside the container SHALL be a white line-style icon. Below the container SHALL be the tool name text. The card background SHALL be white in light mode and #16213E in dark mode, with border-radius 16px.

#### Scenario: Tool card renders in light mode

- **WHEN** the app is in light mode
- **THEN** each tool card SHALL have a white background with a colored rounded-square icon container and the tool name below

#### Scenario: Tool card renders in dark mode

- **WHEN** the app is in dark mode
- **THEN** each tool card SHALL have a #16213E background with a colored rounded-square icon container and the tool name below

### Requirement: ToolItem category field

Each ToolItem SHALL have a `category` field of type ToolCategory enum. The ToolCategory enum SHALL have values: calculate, measure, life. The category assignments SHALL be: calculate (calculator, unit_converter, bmi_calculator, split_bill), measure (level, compass, protractor, screen_ruler, noise_meter), life (flashlight, stopwatch_timer, password_generator, color_picker, qr_generator, random_wheel).

#### Scenario: All tools have a category assigned

- **WHEN** the allTools list is loaded
- **THEN** every ToolItem SHALL have a non-null category value

### Requirement: Title area with app name and subtitle

The home page SHALL display a title area at the top with the app name "工具箱" in large bold text and a subtitle showing "N 個工具，隨手可用" where N is the total number of tools. A search icon button SHALL be displayed on the right side of the title area.

#### Scenario: Title displays correct tool count

- **WHEN** user views the home page
- **THEN** the subtitle SHALL show the correct total number of tools
