## MODIFIED Requirements

### Requirement: Staggered fade-in animation on home page

When the home page first loads, tool cards SHALL animate in with a staggered fade-in effect. Each card SHALL slide up from 20 pixels below its final position while fading from 0 to full opacity. Each successive card SHALL start its animation 50ms after the previous card. The animation SHALL only play on the initial page load, not on subsequent tab switches. The animation SHALL work with the uniform 2-column GridView layout.

#### Scenario: Cards animate in on first load

- **WHEN** the home page loads for the first time in a session
- **THEN** each tool card SHALL animate in with a staggered slide-up and fade-in effect

#### Scenario: Animation does not replay on tab switch

- **WHEN** user switches away from and back to the Tools tab
- **THEN** tool cards SHALL appear immediately without replay of the staggered animation
