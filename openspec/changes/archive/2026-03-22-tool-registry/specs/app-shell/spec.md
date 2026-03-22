## MODIFIED Requirements

### Requirement: Routes for new tools

The app SHALL auto-generate full-screen GoRoute entries for all tools in the allTools registry. Each route SHALL use CustomTransitionPage with FadeTransition. Manual per-tool route definitions in `app.dart` SHALL NOT be used. The route path and page widget SHALL be derived from each ToolItem's `routePath` and `pageBuilder` fields respectively.

#### Scenario: User navigates to any tool

- **WHEN** user taps any tool card on the home page
- **THEN** the corresponding tool page SHALL open in full screen with a fade transition and Hero animation
- **AND** the route SHALL have been auto-generated from the allTools registry
