# home-screen-widgets Specification

## Purpose

TBD - created by archiving change 'home-screen-widgets'. Update Purpose after archive.

## Requirements

### Requirement: Calculator quick-launch widget

The app SHALL provide a home screen widget for both iOS (WidgetKit) and Android (AppWidget) that displays the Spectra brand gradient background with a calculator icon and "Calculator" label. When the user taps the widget, the app SHALL open directly to the calculator tool page via deep link.

#### Scenario: User taps calculator widget

- **WHEN** the user taps the calculator home screen widget
- **THEN** the app SHALL launch and navigate to the `/tools/calculator` route

#### Scenario: Calculator widget displays brand identity

- **WHEN** the calculator widget is rendered on the home screen
- **THEN** it SHALL display the Spectra brand gradient colors, a calculator icon, and the tool name


<!-- @trace
source: home-screen-widgets
updated: 2026-03-22
code:
  - android/app/src/main/res/xml/calculator_widget_info.xml
  - lib/tools/currency_converter/currency_converter_page.dart
  - ios/SpectraWidgets/SpectraWidgets.entitlements
  - ios/Runner/Runner.entitlements
  - ios/SpectraWidgets/CurrencyWidget.swift
  - ios/SpectraWidgets/CalculatorWidget.swift
  - android/app/src/main/res/xml/currency_widget_info.xml
  - ios/SpectraWidgets/SpectraWidgetsBundle.swift
  - ios/Runner/Info.plist
  - pubspec.yaml
  - android/app/src/main/kotlin/com/spectra/toolbox/widget/CurrencyWidgetProvider.kt
  - android/app/src/main/res/values/strings.xml
  - android/app/src/main/kotlin/com/spectra/toolbox/widget/CalculatorWidgetProvider.kt
  - android/app/src/main/res/drawable/widget_gradient_bg.xml
  - ios/SpectraWidgets/ColorExtension.swift
  - android/app/src/main/res/drawable/currency_widget_bg.xml
  - lib/services/widget_service.dart
  - ios/SpectraWidgets/Info.plist
  - pubspec.lock
  - android/app/src/main/res/layout/currency_widget_layout.xml
  - ios/SpectraWidgets/SimpleTimelineProvider.swift
  - android/app/src/main/AndroidManifest.xml
  - android/app/src/main/res/layout/calculator_widget_layout.xml
-->

---
### Requirement: Currency rate display widget

The app SHALL provide a home screen widget for both iOS (WidgetKit) and Android (AppWidget) that displays the most recently queried currency conversion result. The widget SHALL show the source currency, target currency, exchange rate value, and last updated timestamp. When the user taps the widget, the app SHALL open the currency converter tool.

#### Scenario: Widget shows last queried rate

- **WHEN** the user has previously used the currency converter in the app
- **THEN** the currency widget SHALL display the last queried currency pair, rate, and update timestamp

#### Scenario: Widget shows placeholder when no data exists

- **WHEN** the user has never used the currency converter
- **THEN** the currency widget SHALL display a placeholder message prompting the user to open the currency converter

#### Scenario: User taps currency widget

- **WHEN** the user taps the currency rate widget
- **THEN** the app SHALL launch and navigate to the `/tools/currency-converter` route

#### Scenario: Widget data updates after currency conversion

- **WHEN** the user completes a currency conversion in the app
- **THEN** the app SHALL update the widget data with the new currency pair, rate, and timestamp, and request a widget refresh


<!-- @trace
source: home-screen-widgets
updated: 2026-03-22
code:
  - android/app/src/main/res/xml/calculator_widget_info.xml
  - lib/tools/currency_converter/currency_converter_page.dart
  - ios/SpectraWidgets/SpectraWidgets.entitlements
  - ios/Runner/Runner.entitlements
  - ios/SpectraWidgets/CurrencyWidget.swift
  - ios/SpectraWidgets/CalculatorWidget.swift
  - android/app/src/main/res/xml/currency_widget_info.xml
  - ios/SpectraWidgets/SpectraWidgetsBundle.swift
  - ios/Runner/Info.plist
  - pubspec.yaml
  - android/app/src/main/kotlin/com/spectra/toolbox/widget/CurrencyWidgetProvider.kt
  - android/app/src/main/res/values/strings.xml
  - android/app/src/main/kotlin/com/spectra/toolbox/widget/CalculatorWidgetProvider.kt
  - android/app/src/main/res/drawable/widget_gradient_bg.xml
  - ios/SpectraWidgets/ColorExtension.swift
  - android/app/src/main/res/drawable/currency_widget_bg.xml
  - lib/services/widget_service.dart
  - ios/SpectraWidgets/Info.plist
  - pubspec.lock
  - android/app/src/main/res/layout/currency_widget_layout.xml
  - ios/SpectraWidgets/SimpleTimelineProvider.swift
  - android/app/src/main/AndroidManifest.xml
  - android/app/src/main/res/layout/calculator_widget_layout.xml
-->

---
### Requirement: Widget data bridge via home_widget

The app SHALL use the `home_widget` Flutter package to bridge data between the Flutter app and native widgets. On iOS, data SHALL be shared via App Group shared container. On Android, data SHALL be shared via SharedPreferences accessible to the AppWidgetProvider. The app SHALL provide a `WidgetService` class that encapsulates all widget data write operations.

#### Scenario: Flutter app writes widget data

- **WHEN** the currency converter completes a conversion
- **THEN** the `WidgetService` SHALL write the currency data keys (`currency_from`, `currency_to`, `currency_rate`, `currency_updated`) via `HomeWidget.saveWidgetData()` and request a widget update

#### Scenario: Native widget reads shared data

- **WHEN** the native widget renders
- **THEN** it SHALL read the stored data from the shared container (iOS App Group) or SharedPreferences (Android) and display the values

<!-- @trace
source: home-screen-widgets
updated: 2026-03-22
code:
  - android/app/src/main/res/xml/calculator_widget_info.xml
  - lib/tools/currency_converter/currency_converter_page.dart
  - ios/SpectraWidgets/SpectraWidgets.entitlements
  - ios/Runner/Runner.entitlements
  - ios/SpectraWidgets/CurrencyWidget.swift
  - ios/SpectraWidgets/CalculatorWidget.swift
  - android/app/src/main/res/xml/currency_widget_info.xml
  - ios/SpectraWidgets/SpectraWidgetsBundle.swift
  - ios/Runner/Info.plist
  - pubspec.yaml
  - android/app/src/main/kotlin/com/spectra/toolbox/widget/CurrencyWidgetProvider.kt
  - android/app/src/main/res/values/strings.xml
  - android/app/src/main/kotlin/com/spectra/toolbox/widget/CalculatorWidgetProvider.kt
  - android/app/src/main/res/drawable/widget_gradient_bg.xml
  - ios/SpectraWidgets/ColorExtension.swift
  - android/app/src/main/res/drawable/currency_widget_bg.xml
  - lib/services/widget_service.dart
  - ios/SpectraWidgets/Info.plist
  - pubspec.lock
  - android/app/src/main/res/layout/currency_widget_layout.xml
  - ios/SpectraWidgets/SimpleTimelineProvider.swift
  - android/app/src/main/AndroidManifest.xml
  - android/app/src/main/res/layout/calculator_widget_layout.xml
-->

---
### Requirement: Widget Pro gating in settings

The settings page SHALL display the home screen widget setup entry point with a Pro badge when `ProService.isPro == false`. Tapping the locked widget entry SHALL open `PaywallScreen`. When `ProService.isPro == true`, the widget setup flow SHALL proceed normally without any paywall interception.

#### Scenario: Free user taps widget setup

- **WHEN** `ProService.isPro` is `false` and user taps the widget setup option
- **THEN** `PaywallScreen` SHALL be presented as a modal

#### Scenario: Pro user taps widget setup

- **WHEN** `ProService.isPro` is `true` and user taps the widget setup option
- **THEN** the widget setup instructions SHALL be shown with no paywall

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