## ADDED Requirements

### Requirement: Global haptic feedback

The app SHALL provide haptic feedback for interactive actions using the Flutter HapticFeedback API. Light impact feedback SHALL be triggered on general button taps and tab switches. Medium impact feedback SHALL be triggered on favorite toggles and onboarding page swipes. Heavy impact feedback SHALL be triggered on wheel result reveals and important confirmations. Selection click feedback SHALL be triggered on slider drags and option switches. The BouncingButton widget SHALL integrate light impact haptic feedback so that all wrapped buttons automatically provide tactile feedback.

#### Scenario: Button tap triggers light haptic feedback

- **WHEN** user taps any button wrapped in BouncingButton
- **THEN** a light impact haptic feedback SHALL be triggered

#### Scenario: Favorite toggle triggers medium haptic feedback

- **WHEN** user toggles a tool's favorite status
- **THEN** a medium impact haptic feedback SHALL be triggered

#### Scenario: Wheel result triggers heavy haptic feedback

- **WHEN** the random wheel stops and reveals a result
- **THEN** a heavy impact haptic feedback SHALL be triggered

#### Scenario: Tab switch triggers selection click haptic

- **WHEN** user switches between navigation tabs
- **THEN** a selection click haptic feedback SHALL be triggered

### Requirement: Wheel result overlay animation

The random wheel result SHALL be displayed using a custom overlay animation instead of a standard AlertDialog. When the wheel stops, a semi-transparent dark background SHALL fade in, followed by a result card that scales in from center with an elastic bounce effect (Curves.elasticOut). The result card SHALL display the result text in large font on a gradient background matching the tool's color scheme. Tapping the background or a dismiss button SHALL close the overlay with a scale-out fade animation. The overlay SHALL trigger heavy haptic feedback on appearance.

#### Scenario: Wheel result displays with overlay animation

- **WHEN** the random wheel stops spinning
- **THEN** a semi-transparent overlay SHALL fade in and the result card SHALL scale in with an elastic bounce animation

#### Scenario: User dismisses wheel result overlay

- **WHEN** user taps the overlay background or the dismiss button
- **THEN** the result card SHALL scale out and the overlay SHALL fade out

### Requirement: Favorite heart button animation

When the user taps the favorite heart icon button, the heart SHALL animate with an AnimatedScale effect. The heart SHALL scale up to 1.2x its normal size and then spring back to 1.0x. The animation duration SHALL be 200ms with a spring curve.

#### Scenario: Heart icon animates on favorite toggle

- **WHEN** user taps the heart icon button on a tool card
- **THEN** the heart icon SHALL scale up to 1.2x and spring back to 1.0x over 200ms
