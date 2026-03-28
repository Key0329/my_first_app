## ADDED Requirements

### Requirement: Widget Pro gating in settings

The settings page SHALL display the home screen widget setup entry point with a Pro badge when `ProService.isPro == false`. Tapping the locked widget entry SHALL open `PaywallScreen`. When `ProService.isPro == true`, the widget setup flow SHALL proceed normally without any paywall interception.

#### Scenario: Free user taps widget setup

- **WHEN** `ProService.isPro` is `false` and user taps the widget setup option
- **THEN** `PaywallScreen` SHALL be presented as a modal

#### Scenario: Pro user taps widget setup

- **WHEN** `ProService.isPro` is `true` and user taps the widget setup option
- **THEN** the widget setup instructions SHALL be shown with no paywall
