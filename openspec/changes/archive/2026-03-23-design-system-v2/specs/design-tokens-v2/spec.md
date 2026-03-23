## ADDED Requirements

### Requirement: Complete Typography Scale

The DT class SHALL provide a complete Typography Scale with 12 levels: displayLarge (32/w700), displayMedium (28/w700), headlineLarge (24/w600), headlineMedium (20/w600), titleLarge (18/w600), titleMedium (16/w500), bodyLarge (16/w400), bodyMedium (14/w400), bodySmall (12/w400), labelLarge (14/w500), labelMedium (12/w500), labelSmall (10/w500). Each level SHALL be accessible as a static TextStyle getter that accepts a Brightness parameter and returns the TextStyle with the appropriate foreground color for that brightness mode.

#### Scenario: Typography token returns correct size and weight

- **WHEN** a widget references `DT.titleMedium(Brightness.light)`
- **THEN** the returned TextStyle SHALL have fontSize 16, fontWeight w500, and color `DT.lightTitle`

#### Scenario: Typography token adapts to dark mode

- **WHEN** a widget references `DT.bodyMedium(Brightness.dark)`
- **THEN** the returned TextStyle SHALL have fontSize 14, fontWeight w400, and color `DT.darkTitle`

#### Scenario: AppTheme textTheme uses Typography Scale

- **WHEN** AppTheme.light() or AppTheme.dark() creates a ThemeData
- **THEN** the textTheme SHALL map the DT Typography Scale to the corresponding Material TextTheme levels

### Requirement: Shadow and Elevation tokens

The DT class SHALL provide four shadow levels as static methods returning List<BoxShadow>: shadowNone (no shadow), shadowSm (blur 4, offset 0,1, opacity 0.08), shadowMd (blur 8, offset 0,2, opacity 0.12), shadowLg (blur 16, offset 0,4, opacity 0.16). Each shadow method SHALL accept a Brightness parameter. In dark mode, all shadow methods SHALL return an empty list (shadows are not visible on dark backgrounds).

#### Scenario: Light mode card uses shadowMd

- **WHEN** a ToolSectionCard renders in light mode
- **THEN** it SHALL apply `DT.shadowMd(Brightness.light)` which returns a BoxShadow with blur 8, y-offset 2, and black at 12% opacity

#### Scenario: Dark mode shadow returns empty

- **WHEN** any widget requests `DT.shadowMd(Brightness.dark)`
- **THEN** the method SHALL return an empty List<BoxShadow>

### Requirement: Semantic Color tokens

The DT class SHALL provide semantic color tokens for success, error, warning, and info states. Each semantic token SHALL have light and dark variants accessible via a static method that accepts a Brightness parameter. The color values SHALL be: success (light: #10B981, dark: #34D399), error (light: #EF4444, dark: #F87171), warning (light: #F59E0B, dark: #FBBF24), info (light: #3B82F6, dark: #60A5FA).

#### Scenario: Success color in light mode

- **WHEN** a widget references `DT.success(Brightness.light)`
- **THEN** the returned Color SHALL be #10B981

#### Scenario: Error color in dark mode

- **WHEN** a widget references `DT.error(Brightness.dark)`
- **THEN** the returned Color SHALL be #F87171

### Requirement: Animation Curve tokens

The DT class SHALL provide four Animation Curve tokens as static const fields: curveStandard (Curves.easeInOut), curveDecelerate (Curves.easeOut), curveAccelerate (Curves.easeIn), curveSpring (Curves.elasticOut).

#### Scenario: Standard curve used for page transitions

- **WHEN** a widget animates a property transition
- **THEN** it SHALL use `DT.curveStandard` which maps to Curves.easeInOut

### Requirement: Iconography size tokens

The DT class SHALL provide five icon size tokens: iconXs (16), iconSm (20), iconMd (24), iconLg (32), iconXl (48). The existing `iconSize` (24) and `searchIconSize` (20) constants SHALL remain as aliases to iconMd and iconSm respectively.

#### Scenario: Settings row uses iconSm

- **WHEN** a settings row renders an icon
- **THEN** the icon size SHALL reference `DT.iconSm` (20)

#### Scenario: Home page tool card uses iconXl

- **WHEN** the home page renders a tool card icon container
- **THEN** the container size SHALL reference `DT.iconXl` (48)
