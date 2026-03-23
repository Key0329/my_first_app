## ADDED Requirements

### Requirement: Tab switch animation on home page

When the user switches between category tabs on the home page, the tool grid content SHALL animate with an AnimatedSwitcher transition. The outgoing content SHALL fade out while the incoming content fades in with a horizontal slide direction. The animation duration SHALL match DT.durationMedium and use DT.curveDecelerate for enter and DT.curveAccelerate for exit.

#### Scenario: Tab switch triggers animation

- **WHEN** user taps a different category tab
- **THEN** the tool grid content SHALL transition with a fade-slide animation using DT.durationMedium

### Requirement: Shimmer skeleton animation timing

The shimmer loading skeleton on the home page SHALL use a continuous horizontal gradient sweep animation cycling every 1.5 seconds. The gradient SHALL move from left to right across the skeleton placeholders. The animation SHALL use a linear curve for smooth continuous motion.

#### Scenario: Shimmer animation cycles continuously

- **WHEN** the shimmer skeleton is displayed
- **THEN** the gradient highlight SHALL sweep from left to right every 1.5 seconds
