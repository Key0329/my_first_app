## ADDED Requirements

### Requirement: Three-page onboarding flow

The app SHALL display a 3-page onboarding flow on first launch. The onboarding flow SHALL use a PageView with page indicator dots. Page 1 SHALL display the app logo, a welcome title, and a brief app description. Page 2 SHALL showcase core features (toolbox, favorites, settings) with icons and descriptions. Page 3 SHALL display a "Get Started" button that navigates the user to the home page. The user SHALL be able to swipe between pages. A "Skip" button SHALL be available on all pages to skip directly to the home page.

#### Scenario: First launch shows onboarding

- **WHEN** the app launches for the first time (no previous onboarding completion recorded)
- **THEN** the onboarding flow SHALL be displayed instead of the home page

#### Scenario: User swipes through onboarding pages

- **WHEN** the user swipes left on an onboarding page
- **THEN** the next onboarding page SHALL be displayed with a smooth transition

#### Scenario: User taps Get Started on the last page

- **WHEN** the user taps the "Get Started" button on page 3
- **THEN** the onboarding SHALL be marked as completed and the user SHALL be navigated to the home page

#### Scenario: User taps Skip button

- **WHEN** the user taps the "Skip" button on any onboarding page
- **THEN** the onboarding SHALL be marked as completed and the user SHALL be navigated to the home page

### Requirement: Onboarding completion persistence

The onboarding completion status SHALL be persisted using shared_preferences with the key `hasCompletedOnboarding`. Once completed, the onboarding flow SHALL NOT be shown on subsequent app launches. The app SHALL check this value on startup to determine whether to show onboarding or the home page.

#### Scenario: Onboarding not shown after completion

- **WHEN** the app launches and `hasCompletedOnboarding` is true
- **THEN** the app SHALL navigate directly to the home page without showing onboarding

#### Scenario: Onboarding shown after fresh install

- **WHEN** the app launches and `hasCompletedOnboarding` is false or not set
- **THEN** the app SHALL display the onboarding flow

### Requirement: Onboarding page indicator

The onboarding flow SHALL display animated dot indicators at the bottom of each page. The current page dot SHALL be visually distinct (larger and using the brand color). The dots SHALL animate smoothly when the user swipes between pages using AnimatedContainer.

#### Scenario: Page indicator reflects current page

- **WHEN** the user is viewing onboarding page 2
- **THEN** the second dot indicator SHALL be highlighted and enlarged while other dots remain in default state
