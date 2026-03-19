## ADDED Requirements

### Requirement: ImmersiveToolScaffold shared base widget

All 12 tool pages SHALL use an ImmersiveToolScaffold widget as their base layout. This scaffold SHALL provide a two-section layout: an upper header area with gradient background using the tool's color, and a lower body area with a rounded-corner surface container. The AppBar SHALL be transparent and overlay the gradient header.

#### Scenario: Tool page renders with immersive layout

- **WHEN** user opens any tool page
- **THEN** the page SHALL display with a gradient header area at the top and a rounded-corner body area at the bottom

#### Scenario: AppBar is transparent over gradient

- **WHEN** user views a tool page
- **THEN** the AppBar SHALL be transparent with the tool title and back button visible over the gradient background

### Requirement: Tool-specific gradient colors

The header gradient SHALL use the tool's designated color from ToolItem.color. In light mode, the gradient SHALL transition from toolColor at 0.8 opacity to toolColor at 0.4 opacity (top to bottom). In dark mode, the gradient SHALL transition from toolColor at 0.5 opacity to toolColor at 0.2 opacity.

#### Scenario: Calculator page shows green gradient

- **WHEN** user opens the calculator tool (color: 0xFF4CAF50)
- **THEN** the header area SHALL display a green gradient background

#### Scenario: Flashlight page shows amber gradient

- **WHEN** user opens the flashlight tool (color: 0xFFFFC107)
- **THEN** the header area SHALL display an amber gradient background

#### Scenario: Gradient adapts to dark mode

- **WHEN** the app is in dark mode and user opens a tool
- **THEN** the gradient SHALL use reduced opacity values (0.5 to 0.2) for the tool color

### Requirement: Configurable header and body flex ratios

The ImmersiveToolScaffold SHALL accept configurable flex ratios for the header and body sections. Each tool page SHALL specify its preferred ratio based on the amount of display content vs. interactive content. Default ratio SHALL be 2:3 (header:body).

#### Scenario: Calculator uses custom flex ratio

- **WHEN** calculator page is rendered
- **THEN** the header (display area) and body (button grid) SHALL use the ratio specified by the calculator page

#### Scenario: Default ratio applies when not specified

- **WHEN** a tool page does not specify custom flex ratios
- **THEN** the scaffold SHALL use the default 2:3 ratio

### Requirement: Rounded corner separator between sections

The body section SHALL have top-left and top-right rounded corners (radius 24px) that overlap the gradient header area by the corner radius amount, creating a sheet-like visual effect.

#### Scenario: Body section displays with rounded top corners

- **WHEN** user views any tool page
- **THEN** the body section SHALL have rounded top corners that visually overlap the gradient header
