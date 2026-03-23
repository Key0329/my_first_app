## ADDED Requirements

### Requirement: Welcome page entrance animation

The onboarding welcome page (page 1) SHALL animate its content when the page becomes visible. The app logo container SHALL scale from 0 to 1 with an elastic overshoot curve. The title and description text SHALL slide up from 30dp below while fading in, starting 200ms after the logo animation begins.

#### Scenario: Welcome page animates on first view

- **WHEN** the onboarding welcome page becomes visible for the first time
- **THEN** the logo SHALL scale in with elastic overshoot and the text SHALL slide up with a 200ms delay

### Requirement: Features page staggered entrance

The onboarding features page (page 2) SHALL animate its three feature rows with staggered timing when the page becomes visible. Each feature row SHALL slide in from the right while fading in. The first row SHALL start immediately, the second after 200ms, and the third after 400ms.

#### Scenario: Features page rows animate in sequence

- **WHEN** the user swipes to the features page
- **THEN** the three feature rows SHALL animate in with 200ms stagger between each

### Requirement: Get started page entrance animation

The onboarding get started page (page 3) SHALL animate its content when the page becomes visible. The rocket icon SHALL slide up from 50dp below while scaling from 0.8 to 1.0. The action button SHALL fade in and scale from 0.8 to 1.0 with a 300ms delay after the rocket animation begins.

#### Scenario: Get started page animates on view

- **WHEN** the user swipes to the get started page
- **THEN** the rocket icon SHALL slide up and the button SHALL fade in with a 300ms delay
