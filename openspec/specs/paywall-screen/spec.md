# paywall-screen Specification

## Purpose

TBD - created by archiving change 'freemium-paywall'. Update Purpose after archive.

## Requirements

### Requirement: Paywall screen layout

The `PaywallScreen` SHALL display a full-screen modal sheet with the following elements in order: (1) brand gradient header with Pro badge icon, (2) headline "升級至 Pro", (3) feature comparison list showing three Pro benefits (no ads, custom theme, home screen widgets), (4) pricing label "NT$90 一次買斷，永久使用", (5) primary CTA button "立即升級", (6) secondary text link "回復購買", (7) footer privacy/terms note. The screen SHALL be presented as a modal bottom sheet or pushed route from any upgrade CTA in the app.

#### Scenario: User opens paywall from settings

- **WHEN** user taps the "升級至 Pro" card in settings
- **THEN** the PaywallScreen SHALL be presented as a modal

#### Scenario: Pro user opens settings

- **WHEN** `ProService.isPro` is `true`
- **THEN** the settings Pro card SHALL display a "Pro 已啟用" badge instead of the upgrade CTA, and tapping it SHALL NOT open PaywallScreen


<!-- @trace
source: freemium-paywall
updated: 2026-03-28
code:
  - .agents/skills/spectra-ingest/SKILL.md
  - lib/config/ad_config.dart
  - pubspec.lock
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - .agents/skills/spectra-propose/SKILL.md
  - lib/main.dart
  - lib/services/pro_service.dart
  - lib/pages/settings_page.dart
  - .agents/skills/spectra-apply/SKILL.md
  - lib/widgets/banner_ad_widget.dart
  - lib/app.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - .agents/skills/spectra-discuss/SKILL.md
  - .agents/skills/spectra-ask/SKILL.md
  - android/app/src/main/AndroidManifest.xml
  - .spectra.yaml
  - ios/Runner/Info.plist
  - lib/services/in_app_purchase_service.dart
  - lib/pages/paywall_screen.dart
tests:
  - test/pages/paywall_screen_test.dart
  - test/services/pro_service_test.dart
  - test/widgets/banner_ad_widget_test.dart
  - test/services/in_app_purchase_service_test.dart
  - test/widget_test.dart
-->

---
### Requirement: Paywall CTA triggers purchase

The "立即升級" button SHALL call `InAppPurchaseService.buyPro()`. The button SHALL display a loading indicator while the purchase flow is in progress. The button SHALL be disabled during an active purchase to prevent duplicate taps.

#### Scenario: User taps upgrade button

- **WHEN** user taps "立即升級"
- **THEN** the platform purchase dialog SHALL appear (StoreKit2 / Play Billing)

#### Scenario: Purchase succeeds

- **WHEN** the purchase is verified successfully
- **THEN** the PaywallScreen SHALL dismiss and the app SHALL reflect Pro status immediately

#### Scenario: Purchase cancelled

- **WHEN** user cancels the platform purchase dialog
- **THEN** the PaywallScreen SHALL remain open with no error shown

#### Scenario: Purchase fails

- **WHEN** a purchase error occurs (network, billing unavailable, etc.)
- **THEN** the PaywallScreen SHALL display an error snackbar with a retry prompt


<!-- @trace
source: freemium-paywall
updated: 2026-03-28
code:
  - .agents/skills/spectra-ingest/SKILL.md
  - lib/config/ad_config.dart
  - pubspec.lock
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - .agents/skills/spectra-propose/SKILL.md
  - lib/main.dart
  - lib/services/pro_service.dart
  - lib/pages/settings_page.dart
  - .agents/skills/spectra-apply/SKILL.md
  - lib/widgets/banner_ad_widget.dart
  - lib/app.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - .agents/skills/spectra-discuss/SKILL.md
  - .agents/skills/spectra-ask/SKILL.md
  - android/app/src/main/AndroidManifest.xml
  - .spectra.yaml
  - ios/Runner/Info.plist
  - lib/services/in_app_purchase_service.dart
  - lib/pages/paywall_screen.dart
tests:
  - test/pages/paywall_screen_test.dart
  - test/services/pro_service_test.dart
  - test/widgets/banner_ad_widget_test.dart
  - test/services/in_app_purchase_service_test.dart
  - test/widget_test.dart
-->

---
### Requirement: Restore purchase

The PaywallScreen SHALL include a "回復購買" text button that calls `InAppPurchaseService.restorePurchases()`. After successful restore, the screen SHALL dismiss. If no prior purchase is found, a snackbar SHALL inform the user.

#### Scenario: Restore finds prior purchase

- **WHEN** user taps "回復購買" and a prior purchase exists
- **THEN** `ProService.setPro(true)` SHALL be called and the screen SHALL dismiss

#### Scenario: Restore finds no purchase

- **WHEN** user taps "回復購買" and no prior purchase exists
- **THEN** a snackbar SHALL display "找不到先前的購買紀錄"

<!-- @trace
source: freemium-paywall
updated: 2026-03-28
code:
  - .agents/skills/spectra-ingest/SKILL.md
  - lib/config/ad_config.dart
  - pubspec.lock
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - .agents/skills/spectra-propose/SKILL.md
  - lib/main.dart
  - lib/services/pro_service.dart
  - lib/pages/settings_page.dart
  - .agents/skills/spectra-apply/SKILL.md
  - lib/widgets/banner_ad_widget.dart
  - lib/app.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - .agents/skills/spectra-discuss/SKILL.md
  - .agents/skills/spectra-ask/SKILL.md
  - android/app/src/main/AndroidManifest.xml
  - .spectra.yaml
  - ios/Runner/Info.plist
  - lib/services/in_app_purchase_service.dart
  - lib/pages/paywall_screen.dart
tests:
  - test/pages/paywall_screen_test.dart
  - test/services/pro_service_test.dart
  - test/widgets/banner_ad_widget_test.dart
  - test/services/in_app_purchase_service_test.dart
  - test/widget_test.dart
-->