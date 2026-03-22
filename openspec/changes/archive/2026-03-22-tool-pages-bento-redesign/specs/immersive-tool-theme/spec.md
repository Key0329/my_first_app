## ADDED Requirements

### Requirement: Body area Bento card organization

The ImmersiveToolScaffold body area SHALL organize its contents using ToolSectionCard containers instead of raw widget layouts. The body area SHALL use `DT.toolBodyPadding` (16dp) outer padding. Tool pages SHALL NOT use hardcoded padding or spacing values in the body area; all spacing SHALL reference DT tokens.

#### Scenario: Body content uses ToolSectionCard containers

- **WHEN** user opens any tool page
- **THEN** the body area controls SHALL be grouped inside ToolSectionCard containers with consistent spacing and styling

#### Scenario: Body area uses DT token padding

- **WHEN** user opens any tool page
- **THEN** the body area outer padding SHALL be exactly `DT.toolBodyPadding` (16dp) on all sides

### Requirement: Tool gradient button replaces FilledButton for primary actions

Each tool page's primary call-to-action SHALL use ToolGradientButton instead of the default Material FilledButton. The gradient SHALL use the tool's colors from `toolGradients` map. Secondary actions (reset, swap, history) SHALL continue using standard Material buttons.

#### Scenario: Password generator uses gradient generate button

- **WHEN** user views the password generator page
- **THEN** the "Generate" button SHALL display with the tool's purple gradient background instead of the default Material primary color

#### Scenario: Secondary actions remain standard

- **WHEN** user views the stopwatch page
- **THEN** the "Reset" button SHALL remain a standard OutlinedButton while the "Start" button SHALL use ToolGradientButton

### Requirement: Result section tinted background

Tool pages following Mode A (Input-Result) layout SHALL display result sections with a tinted background using the tool's color. In light mode, the tint SHALL be the tool color at 8% opacity. In dark mode, the tint SHALL be the tool color at 15% opacity. This tinted background SHALL visually distinguish result sections from input sections.

#### Scenario: Split bill result card has tinted background

- **WHEN** user views the split bill result section
- **THEN** the result card SHALL have a teal-tinted background (tool color 0xFF26A69A at 8% opacity in light mode)

#### Scenario: Result tint adapts to dark mode

- **WHEN** user views a tool page result section in dark mode
- **THEN** the result card background SHALL use the tool color at 15% opacity

## MODIFIED Requirements

### Requirement: ImmersiveToolScaffold shared base widget

All 15 tool pages SHALL use an ImmersiveToolScaffold widget as their base layout. This scaffold SHALL provide a two-section layout: an upper header area with gradient background using the tool's color, and a lower body area with a rounded-corner surface container. The AppBar SHALL be transparent and overlay the gradient header. The body area SHALL use `DT.toolBodyPadding` for outer padding and SHALL organize content using ToolSectionCard containers.

#### Scenario: Tool page renders with immersive layout

- **WHEN** user opens any tool page
- **THEN** the page SHALL display with a gradient header area at the top and a rounded-corner body area at the bottom with content organized in ToolSectionCard containers

#### Scenario: AppBar is transparent over gradient

- **WHEN** user views a tool page
- **THEN** the AppBar SHALL be transparent with the tool title and back button visible over the gradient background
