## MODIFIED Requirements

### Requirement: ImmersiveToolScaffold shared base widget

All tool pages SHALL use an ImmersiveToolScaffold widget as their base layout. This scaffold SHALL provide a two-section layout: an upper header area with gradient background using the tool's color, and a lower body area with a rounded-corner surface container. The AppBar SHALL be transparent and overlay the gradient header. The body area SHALL use `DT.toolBodyPadding` for outer padding and SHALL organize content using ToolSectionCard containers. In light mode, ToolSectionCard SHALL apply `DT.shadowMd` for visual depth. In dark mode, ToolSectionCard SHALL continue using border-only styling without shadows.

#### Scenario: Tool page renders with immersive layout

- **WHEN** user opens any tool page
- **THEN** the page SHALL display with a gradient header area at the top and a rounded-corner body area at the bottom with content organized in ToolSectionCard containers

#### Scenario: AppBar is transparent over gradient

- **WHEN** user views a tool page
- **THEN** the AppBar SHALL be transparent with the tool title and back button visible over the gradient background

#### Scenario: ToolSectionCard has shadow in light mode

- **WHEN** a ToolSectionCard renders in light mode
- **THEN** the card container SHALL apply DT.shadowMd BoxShadow for visual depth

#### Scenario: ToolSectionCard has no shadow in dark mode

- **WHEN** a ToolSectionCard renders in dark mode
- **THEN** the card container SHALL NOT apply any BoxShadow and SHALL rely on border styling only
