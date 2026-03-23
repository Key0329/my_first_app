## ADDED Requirements

### Requirement: Native splash screen with brand identity

The app SHALL display a native splash screen during cold start that shows the brand primary color (#6C5CE7) as the background with the app icon centered on screen. The splash screen SHALL be implemented using flutter_native_splash to ensure it displays before the Flutter engine initializes. The splash screen SHALL be configured for both Android and iOS platforms.

#### Scenario: App cold start shows branded splash

- **WHEN** the user launches the app from a cold start
- **THEN** the native splash screen SHALL display with the brand purple background and centered app icon before the Flutter UI loads

#### Scenario: Splash screen transitions to app

- **WHEN** the Flutter engine finishes initializing
- **THEN** the splash screen SHALL transition smoothly to the first Flutter screen (onboarding or home page)
