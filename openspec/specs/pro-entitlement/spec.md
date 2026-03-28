# pro-entitlement Specification

## Purpose

TBD - created by archiving change 'freemium-paywall'. Update Purpose after archive.

## Requirements

### Requirement: Pro status persistence

The system SHALL maintain an `isPro` boolean flag in SharedPreferences under the key `is_pro`. The `ProService` singleton SHALL expose `isPro` as a getter and SHALL extend `ChangeNotifier` to notify listeners on state changes. `ProService.init()` SHALL be called during app startup alongside other services.

#### Scenario: First launch (free user)

- **WHEN** the app is launched for the first time with no prior purchase
- **THEN** `ProService.isPro` SHALL return `false`

#### Scenario: Pro user reopens app

- **WHEN** a user who previously completed a purchase reopens the app
- **THEN** `ProService.isPro` SHALL return `true` without requiring a network call


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
### Requirement: Pro status activation

The `ProService` SHALL expose a `setPro(bool value)` method that writes the new state to SharedPreferences and calls `notifyListeners()`. This method SHALL be called by the `InAppPurchaseService` upon successful purchase verification.

#### Scenario: Purchase completes

- **WHEN** `InAppPurchaseService` verifies a successful purchase
- **THEN** `ProService.setPro(true)` SHALL be called and all listeners SHALL be notified immediately

#### Scenario: Restore purchase

- **WHEN** user initiates restore purchase and a prior purchase is found
- **THEN** `ProService.setPro(true)` SHALL be called


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
### Requirement: Pro-gated feature check

Any widget or service that gates Pro features SHALL read `ProService.isPro` via `context.watch<ProService>()` or `context.read<ProService>()`. Hard-coded fallback behavior SHALL default to `isPro == false` (free tier).

#### Scenario: Widget reacts to Pro status change

- **WHEN** `ProService.isPro` changes from `false` to `true` during an active session
- **THEN** all widgets watching `ProService` SHALL rebuild and reflect the Pro state without requiring an app restart

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