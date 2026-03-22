# analytics-tracking Specification

## Purpose

TBD - created by archiving change 'growth-infrastructure'. Update Purpose after archive.

## Requirements

### Requirement: AnalyticsService singleton initialization

The app SHALL initialize Firebase Core, Firebase Analytics, and Firebase Crashlytics during app startup in `main()`. An `AnalyticsService` singleton SHALL be created that wraps `FirebaseAnalytics` and provides a unified event-logging interface. The service SHALL be accessible throughout the app via `AnalyticsService.instance`.

#### Scenario: Firebase initializes on app start

- **WHEN** the app starts
- **THEN** Firebase Core, Analytics, and Crashlytics SHALL be initialized before `runApp()` is called

#### Scenario: AnalyticsService is accessible as singleton

- **WHEN** any widget or service needs to log an event
- **THEN** `AnalyticsService.instance` SHALL return the initialized singleton


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
### Requirement: Tool open event tracking

The app SHALL log a `tool_open` event via `AnalyticsService` whenever a user navigates to a tool page. The event SHALL include parameters `tool_id` (String) and `source` (String, e.g. "home", "favorites", "deep_link").

#### Scenario: User opens a tool from home page

- **WHEN** user taps a tool card on the home page
- **THEN** a `tool_open` event SHALL be logged with `tool_id` matching the tool's ID and `source` set to "home"

#### Scenario: User opens a tool from favorites

- **WHEN** user taps a tool card on the favorites page
- **THEN** a `tool_open` event SHALL be logged with `tool_id` matching the tool's ID and `source` set to "favorites"


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
### Requirement: Tool complete event tracking

The app SHALL log a `tool_complete` event via `AnalyticsService` when a user completes an action within a tool. The event SHALL include parameters `tool_id` (String) and `result_type` (String). The following tools SHALL trigger `tool_complete`: BMI calculator (result_type: "bmi_calculated"), split bill (result_type: "bill_split"), random wheel (result_type: "wheel_spun"), QR generator (result_type: "qr_generated").

#### Scenario: User completes BMI calculation

- **WHEN** user calculates BMI in the BMI calculator tool
- **THEN** a `tool_complete` event SHALL be logged with `tool_id` "bmi_calculator" and `result_type` "bmi_calculated"

#### Scenario: User completes split bill

- **WHEN** user calculates a split bill result
- **THEN** a `tool_complete` event SHALL be logged with `tool_id` "split_bill" and `result_type` "bill_split"


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
### Requirement: Tool share event tracking

The app SHALL log a `tool_share` event via `AnalyticsService` when a user shares a tool result. The event SHALL include parameters `tool_id` (String) and `share_method` (String, always "system_share" for now).

#### Scenario: User shares a tool result

- **WHEN** user taps the share button on any shareable tool
- **THEN** a `tool_share` event SHALL be logged with the corresponding `tool_id` and `share_method` "system_share"


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
### Requirement: Analytics route observer for page tracking

The app SHALL register an `AnalyticsRouteObserver` (extending `NavigatorObserver`) with GoRouter. The observer SHALL automatically log `screen_view` events with the route name whenever navigation occurs.

#### Scenario: User navigates between pages

- **WHEN** user navigates to any page in the app
- **THEN** a `screen_view` event SHALL be automatically logged with the route path


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
### Requirement: Tab switch event tracking

The app SHALL log a `tab_switch` event via `AnalyticsService` when the user switches between bottom navigation tabs. The event SHALL include a `tab_name` parameter (String: "tools", "favorites", or "settings").

#### Scenario: User switches to favorites tab

- **WHEN** user taps the favorites tab in the bottom navigation
- **THEN** a `tab_switch` event SHALL be logged with `tab_name` "favorites"


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
### Requirement: Crashlytics error reporting

The app SHALL configure `FlutterError.onError` to forward uncaught Flutter errors to Firebase Crashlytics. The app SHALL also capture uncaught async errors using `PlatformDispatcher.instance.onError` and report them to Crashlytics.

#### Scenario: Uncaught Flutter error occurs

- **WHEN** an uncaught Flutter framework error occurs
- **THEN** the error SHALL be reported to Firebase Crashlytics automatically

#### Scenario: Uncaught async error occurs

- **WHEN** an uncaught asynchronous error occurs
- **THEN** the error SHALL be reported to Firebase Crashlytics automatically

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