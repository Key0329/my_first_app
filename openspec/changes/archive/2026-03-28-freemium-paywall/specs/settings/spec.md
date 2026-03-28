## ADDED Requirements

### Requirement: Pro upgrade card in settings

The settings page SHALL display a "Pro 升級" ToolSectionCard in a new "Pro" section positioned above the "Appearance" section. When `ProService.isPro == false`, the card SHALL show a gradient Pro badge, a headline "升級至 Pro", a subtitle listing three key benefits, and a primary button "NT$90 立即升級". When `ProService.isPro == true`, the card SHALL show a "已是 Pro 用戶 ✓" state with no upgrade button.

#### Scenario: Free user views settings Pro card

- **WHEN** `ProService.isPro` is `false` and user opens settings
- **THEN** the Pro upgrade card SHALL display with upgrade CTA visible

#### Scenario: Pro user views settings Pro card

- **WHEN** `ProService.isPro` is `true` and user opens settings
- **THEN** the Pro card SHALL display a "已是 Pro 用戶 ✓" badge and no upgrade button

#### Scenario: User taps upgrade CTA

- **WHEN** free user taps the "立即升級" button in the Pro card
- **THEN** `PaywallScreen` SHALL be presented as a modal
