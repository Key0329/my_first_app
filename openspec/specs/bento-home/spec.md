# bento-home Specification

## Purpose

TBD - created by archiving change 'design-overhaul-bento'. Update Purpose after archive.

## Requirements

### Requirement: Home page tool search

The home page SHALL provide a functional search feature accessible via a placeholder search bar displayed below the title area. The search bar SHALL be a full-width rounded container with a search icon and localized hint text. When the user taps the search bar, a search interface SHALL open allowing the user to type a query. The search SHALL filter tools by matching against tool names (in the current locale) and category names. Results SHALL be displayed as a list of matching tools. Tapping a search result SHALL navigate to that tool's page. An empty query SHALL show suggestions or recent tools.

#### Scenario: User searches for a tool by name

- **WHEN** user taps the search bar and types "計算"
- **THEN** the search results SHALL show tools whose name contains "計算" in the current locale

#### Scenario: Search bar is visually prominent

- **WHEN** the home page loads
- **THEN** a full-width search bar with hint text SHALL be visible below the title area


<!-- @trace
source: ux-polish
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/widgets/shimmer_loading.dart
  - lib/pages/home_page.dart
  - lib/widgets/hero_moment.dart
  - lib/widgets/immersive_tool_scaffold.dart
  - lib/widgets/confetti_effect.dart
  - lib/widgets/tool_card.dart
tests:
  - test/widgets/hero_moment_test.dart
  - test/widgets/shimmer_loading_test.dart
  - test/widgets/confetti_effect_test.dart
-->

---
### Requirement: App display name for ASO

The app display name SHALL be set to "Spectra 工具箱" on both iOS (`CFBundleDisplayName`) and Android (`android:label`). The bundle identifier SHALL be `com.spectra.toolbox` on both platforms.

#### Scenario: App name displays correctly on home screen

- **WHEN** the app is installed on a device
- **THEN** the home screen icon label SHALL show "Spectra 工具箱"

#### Scenario: Bundle ID is set correctly

- **WHEN** the app is built for release
- **THEN** the bundle identifier SHALL be `com.spectra.toolbox`


<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: Marketing subtitle on home page

The home page subtitle SHALL display "15+ 實用工具，一個 App 搞定" as a marketing-oriented tagline for ASO purposes. This replaces the previous dynamic "N 個工具，隨手可用" subtitle.

#### Scenario: Home page shows marketing subtitle

- **WHEN** user views the home page
- **THEN** the subtitle text SHALL display "15+ 實用工具，一個 App 搞定"


<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: Deep link routing configuration

The app SHALL support deep links in the format `https://spectra.app/tools/{tool-id}` that open the corresponding tool page directly. GoRouter SHALL handle deep link URLs and match them to existing `/tools/{tool-id}` routes. On iOS, Universal Links SHALL be configured via Associated Domains entitlement with `applinks:spectra.app`. On Android, App Links SHALL be configured via intent-filter in AndroidManifest.xml for `https://spectra.app/tools/*`.

#### Scenario: Deep link opens correct tool

- **WHEN** user taps a deep link `https://spectra.app/tools/bmi-calculator`
- **THEN** the app SHALL open and navigate directly to the BMI calculator tool page

#### Scenario: iOS Universal Links configured

- **WHEN** the app is built for iOS
- **THEN** the Associated Domains entitlement SHALL include `applinks:spectra.app`

#### Scenario: Android App Links configured

- **WHEN** the app is built for Android
- **THEN** the AndroidManifest.xml SHALL include an intent-filter for `https://spectra.app/tools/*`

<!-- @trace
source: growth-infrastructure
updated: 2026-03-22
code:
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/split_bill/split_bill_page.dart
  - android/app/build.gradle.kts
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/main.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/compass/compass_page.dart
  - CLAUDE.md
  - lib/l10n/app_localizations.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - pubspec.lock
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/color_picker/color_picker_logic.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/services/timer_notification_service.dart
  - lib/services/haptic_service.dart
  - lib/tools/currency_converter/currency_api.dart
  - assets/sounds/timer_complete.wav
  - lib/tools/protractor/protractor_logic.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/widgets/tool_card.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - ios/Runner.xcodeproj/project.pbxproj
  - lib/models/tool_item.dart
  - lib/theme/design_tokens.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/tool_search_delegate.dart
  - lib/tools/level/level_logic.dart
  - lib/pages/onboarding_page.dart
  - lib/widgets/error_state.dart
  - lib/utils/platform_check.dart
  - lib/tools/color_picker/color_picker_page.dart
  - ios/Runner/Runner.entitlements
  - ios/Runner/Info.plist
  - .mcp.json
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/settings_page.dart
  - lib/pages/favorites_page.dart
  - linux/flutter/generated_plugins.cmake
  - lib/widgets/bouncing_button.dart
  - lib/services/analytics_route_observer.dart
  - lib/l10n/app_localizations_en.dart
  - lib/services/analytics_service.dart
  - lib/app.dart
  - lib/services/settings_service.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - linux/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_logic.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/l10n/app_en.arb
  - android/app/src/main/AndroidManifest.xml
  - windows/flutter/generated_plugins.cmake
  - lib/widgets/share_button.dart
  - lib/l10n/app_zh.arb
  - lib/widgets/immersive_tool_scaffold.dart
  - pubspec.yaml
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/date_calculator/date_calculator_logic.dart
  - lib/pages/home_page.dart
tests:
  - test/models/tool_item_test.dart
  - test/tools/level_logic_test.dart
  - test/pages/tool_search_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/widget_test.dart
  - test/tools/currency_converter_widget_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/compass_logic_test.dart
  - test/pages/home_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/pages/onboarding_page_test.dart
  - test/utils/platform_check_test.dart
  - test/tools/stopwatch_timer_notification_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/date_calculator_test.dart
  - test/tools/flashlight_logic_test.dart
  - test/services/recent_tools_test.dart
  - test/theme/design_tokens_test.dart
  - test/services/analytics_service_test.dart
  - test/tools/currency_converter_test.dart
  - test/services/settings_service_test.dart
-->