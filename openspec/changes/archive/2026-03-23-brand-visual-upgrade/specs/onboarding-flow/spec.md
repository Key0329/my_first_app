## MODIFIED Requirements

### Requirement: Three-page onboarding flow

The app SHALL display a 3-page onboarding flow on first launch. The onboarding flow SHALL use a PageView with page indicator dots. Page 1 SHALL display the app logo, a welcome title, and a brief app description. Page 2 SHALL showcase core features (toolbox, favorites, settings) with icons and descriptions. Page 3 SHALL display a "Get Started" button that navigates the user to the home page. The user SHALL be able to swipe between pages. A "Skip" button SHALL be available on all pages. Each page SHALL animate its content when it becomes visible for the first time (controlled by onPageChanged). The animations SHALL use DT design tokens for duration and curves.

#### Scenario: User completes onboarding via get started button

- **WHEN** user swipes to page 3 and taps the "Get Started" button
- **THEN** the onboarding flow SHALL complete and the home page SHALL be displayed

#### Scenario: User skips onboarding

- **WHEN** user taps the "Skip" button on any page
- **THEN** the onboarding flow SHALL complete immediately

#### Scenario: Page animations play once per session

- **WHEN** user swipes to a page, then swipes away and returns
- **THEN** the page entrance animation SHALL NOT replay (it only plays on first visit)
