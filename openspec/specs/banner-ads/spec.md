# banner-ads Specification

## Purpose

TBD - created by archiving change 'freemium-paywall'. Update Purpose after archive.

## Requirements

### Requirement: AdMob banner initialization

The app SHALL initialize `MobileAds.instance.initialize()` in `main()` before `runApp()`. The AdMob App ID SHALL be configured in `android/app/src/main/AndroidManifest.xml` (meta-data `com.google.android.gms.ads.APPLICATION_ID`) and `ios/Runner/Info.plist` (key `GADApplicationIdentifier`). Ad unit IDs SHALL be stored in a `AdConfig` constant class, with test IDs used during debug builds and production IDs in release builds.

#### Scenario: App initializes with AdMob

- **WHEN** the app starts in release mode on a free-tier device
- **THEN** AdMob SHALL be initialized before the first tool page renders

#### Scenario: Test IDs in debug mode

- **WHEN** the app runs in debug mode (`kDebugMode == true`)
- **THEN** the `BannerAdWidget` SHALL use Google's official test ad unit IDs to prevent policy violations


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
### Requirement: Banner ad widget in tool pages

The `BannerAdWidget` SHALL be a stateful widget that loads a `BannerAd` with size `AdSize.banner` (320×50). It SHALL be placed at the bottom of `ImmersiveToolScaffold` as a persistent slot above any bottom navigation elements. The widget SHALL be wrapped in a `Consumer<ProService>`: when `isPro == true`, the widget SHALL return `SizedBox.shrink()` (zero height, no ad loaded). When `isPro == false`, the banner ad SHALL load and display.

#### Scenario: Free user views a tool page

- **WHEN** a free user opens any tool page
- **THEN** a 320×50 banner ad SHALL be displayed at the bottom of the page without overlapping the tool's interactive area

#### Scenario: Pro user views a tool page

- **WHEN** `ProService.isPro` is `true`
- **THEN** no ad SHALL be displayed and the tool's full content area SHALL be available

#### Scenario: Ad fails to load

- **WHEN** an ad request fails (no network, no fill)
- **THEN** the banner slot SHALL collapse to zero height (no blank space shown to user)


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
### Requirement: Banner ad lifecycle management

The `BannerAdWidget` SHALL dispose the `BannerAd` instance in its `dispose()` method to prevent memory leaks. A new `BannerAd` instance SHALL be created each time the widget is initialized (not reused across navigations).

#### Scenario: User navigates away from tool page

- **WHEN** user navigates back from a tool page
- **THEN** the `BannerAd.dispose()` SHALL be called and no ad SHALL continue to render in background

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