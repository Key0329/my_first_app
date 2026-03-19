## ADDED Requirements

### Requirement: Staggered fade-in animation on home page

When the home page first loads, tool cards SHALL animate in with a staggered fade-in effect. Each card SHALL slide up from 20 pixels below its final position while fading from 0 to full opacity. Each successive card SHALL start its animation 50ms after the previous card. The total animation duration SHALL be approximately 600ms for all 12 cards. The animation SHALL only play on the initial page load, not on subsequent tab switches.

#### Scenario: Cards animate in on first load

- **WHEN** the home page loads for the first time in a session
- **THEN** each tool card SHALL animate in with a staggered slide-up and fade-in effect

#### Scenario: Animation does not replay on tab switch

- **WHEN** user switches away from and back to the Tools tab
- **THEN** tool cards SHALL appear immediately without replay of the staggered animation

### Requirement: Hero transition between home card and tool page

When a user taps a tool card, a Hero animation SHALL connect the card to the tool page. The card's gradient background SHALL expand into the tool page's gradient header. The Hero tag SHALL use the format `tool_hero_{toolId}`. The transition SHALL use GoRouter's CustomTransitionPage.

#### Scenario: Tapping card triggers Hero expand animation

- **WHEN** user taps a tool card on the home page
- **THEN** the card SHALL expand via Hero animation into the full tool page with the gradient background morphing into the tool page header

#### Scenario: Returning from tool triggers Hero collapse animation

- **WHEN** user taps the back button on a tool page
- **THEN** the tool page header SHALL collapse back into the home page card via reverse Hero animation

### Requirement: Interactive micro-animations

Tool pages SHALL include subtle micro-animations for interactive elements. Buttons SHALL have a scale bounce effect (scale to 0.95 on press, back to 1.0 on release with a spring curve). Numeric displays that change value SHALL animate the transition with a brief vertical slide.

#### Scenario: Button press shows scale bounce

- **WHEN** user presses a button in any tool page
- **THEN** the button SHALL briefly scale down to 0.95 and spring back to 1.0

#### Scenario: Calculator result animates on change

- **WHEN** the calculator result value changes
- **THEN** the new value SHALL slide in from below while the old value slides out above
