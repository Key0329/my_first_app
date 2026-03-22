## ADDED Requirements

### Requirement: Tool page body staggered fade-in animation

When a tool page opens, the body section cards SHALL animate in with a staggered fade-in effect, reusing the same pattern as the home page. Each section card SHALL slide up from 20 pixels below and fade from 0 to full opacity. Each successive card SHALL start 50ms after the previous one. The animation SHALL play once on page open and SHALL NOT replay on widget rebuilds.

#### Scenario: Body sections animate in on tool page open

- **WHEN** user navigates to any tool page
- **THEN** each ToolSectionCard in the body area SHALL animate in with staggered slide-up and fade-in effect

#### Scenario: Animation does not replay on state changes

- **WHEN** user interacts with controls on a tool page causing widget rebuilds
- **THEN** the body section cards SHALL NOT replay the entrance animation

### Requirement: Value change animation with AnimatedSwitcher

Numeric result displays in tool pages SHALL animate value transitions using AnimatedSwitcher. When a result value changes, the old value SHALL slide out upward while fading out, and the new value SHALL slide in from below while fading in. The transition duration SHALL be 200ms. High-frequency update displays (stopwatch centiseconds) SHALL NOT use this animation to avoid performance impact.

#### Scenario: Calculator result animates on evaluation

- **WHEN** user presses equals on the calculator and a new result appears
- **THEN** the result text SHALL transition with a slide-up fade animation over 200ms

#### Scenario: BMI value animates on slider change

- **WHEN** user adjusts the height or weight slider on the BMI calculator
- **THEN** the BMI result number SHALL animate with a slide-up fade transition

#### Scenario: Stopwatch centiseconds do not animate

- **WHEN** the stopwatch is running and centiseconds are updating
- **THEN** the time display SHALL update immediately without AnimatedSwitcher animation

## MODIFIED Requirements

### Requirement: Interactive micro-animations

Tool pages SHALL include subtle micro-animations for interactive elements. All interactive buttons across all 15 tool pages SHALL be wrapped in BouncingButton with a scale bounce effect (scale to 0.95 on press, back to 1.0 on release with a spring curve). Numeric displays that change value SHALL animate the transition with a brief vertical slide using AnimatedSwitcher with 200ms duration. The BouncingButton wrapper SHALL apply to FilledButton, OutlinedButton, IconButton, and custom GestureDetector-based interactive elements.

#### Scenario: Button press shows scale bounce

- **WHEN** user presses any interactive button in any tool page
- **THEN** the button SHALL briefly scale down to 0.95 and spring back to 1.0

#### Scenario: Calculator result animates on change

- **WHEN** the calculator result value changes
- **THEN** the new value SHALL slide in from below while the old value slides out above
