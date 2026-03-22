# localization Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: Multi-language support

The app SHALL support two locales: Traditional Chinese (zh_TW) as the default and English (en). All user-facing strings SHALL be localized using Flutter's official internationalization mechanism (flutter_localizations + ARB files). All user-visible text in pages, tool pages, and shared widgets SHALL be sourced from AppLocalizations. Hardcoded Chinese strings SHALL NOT exist in any UI-rendering code. Both zh and en ARB files SHALL contain entries for every localization key.

#### Scenario: App displays in Traditional Chinese by default

- **WHEN** the user's device locale is zh_TW or the user has not changed the language setting
- **THEN** all UI text SHALL display in Traditional Chinese from AppLocalizations

#### Scenario: App pages display localized strings

- **WHEN** any page (home, settings, favorites, onboarding) is displayed
- **THEN** all visible text SHALL come from AppLocalizations, not hardcoded strings

#### Scenario: Tool pages display localized strings

- **WHEN** any of the 18 tool pages is displayed
- **THEN** all visible text (titles, labels, buttons, results, hints) SHALL come from AppLocalizations

#### Scenario: Shared widgets display localized strings

- **WHEN** shared widgets (error_state, confirm_dialog, share_button, etc.) are displayed
- **THEN** all visible text SHALL come from AppLocalizations

#### Scenario: Switching locale updates all text

- **WHEN** the user switches locale from zh to en in settings
- **THEN** all UI text across all pages and tools SHALL update to English


<!-- @trace
source: i18n-completion
updated: 2026-03-23
code:
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_en.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/widgets/error_state.dart
  - lib/pages/settings_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/widgets/share_button.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/pages/home_page.dart
  - lib/l10n/app_en.arb
  - lib/pages/tool_search_delegate.dart
  - lib/pages/favorites_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/confirm_dialog.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/pages/onboarding_page.dart
  - lib/l10n/app_zh.arb
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/password_generator/password_generator_page.dart
tests:
  - test/pages/home_page_test.dart
  - test/pages/onboarding_page_test.dart
  - test/tools/calculator_page_test.dart
  - test/widgets/tool_recommendation_bar_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/qr_scanner_live_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/favorites_page_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Locale persistence

The selected locale SHALL persist across app restarts using shared_preferences. If no locale has been explicitly selected, the app SHALL use the device's system locale if supported, or fall back to Traditional Chinese.

#### Scenario: Locale persists after restart

- **WHEN** user has selected a locale and restarts the app
- **THEN** the previously selected locale SHALL be applied on launch

<!-- @trace
source: mvp-v1-toolbox-app
updated: 2026-03-18
code:
  - lib/tools/invoice_checker/invoice_parser.dart
  - macos/Flutter/GeneratedPluginRegistrant.swift
  - lib/tools/unit_converter/units_data.dart
  - lib/pages/home_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - windows/flutter/generated_plugins.cmake
  - pubspec.lock
  - lib/l10n/l10n.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/l10n/app_zh.arb
  - lib/services/settings_service.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - lib/l10n/app_en.arb
  - lib/pages/settings_page.dart
  - lib/tools/level/level_page.dart
  - windows/flutter/generated_plugin_registrant.cc
  - lib/tools/compass/compass_page.dart
  - l10n.yaml
  - lib/models/tool_item.dart
  - lib/app.dart
  - lib/pages/favorites_page.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/widgets/app_scaffold.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/theme/app_theme.dart
  - lib/main.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - pubspec.yaml
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_card.dart
  - lib/tools/calculator/calculator_logic.dart
  - lib/tools/calculator/calculator_page.dart
  - ios/Runner/Info.plist
tests:
  - test/widget_test.dart
  - test/tools/calculator_logic_test.dart
  - test/tools/password_generator_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/unit_converter_test.dart
  - test/tools/stopwatch_timer_test.dart
  - test/services/settings_service_test.dart
-->

---
### Requirement: Localization strings for new tools

The localization system SHALL include translated strings for all four new tools in both Traditional Chinese (zh) and English (en). The following i18n keys SHALL be added:

- `tool_bmi_calculator`: BMI Calculator / BMI 計算機
- `tool_split_bill`: Split Bill / AA 制分帳
- `tool_random_wheel`: Random Wheel / 隨機決定器
- `tool_screen_ruler`: Screen Ruler / 螢幕尺規

Each tool page SHALL also have localized strings for its UI elements (labels, buttons, category names, empty states).

#### Scenario: New tool names display in Traditional Chinese

- **WHEN** app locale is set to zh
- **THEN** the four new tools SHALL display their Traditional Chinese names on the home page and tool page AppBar

#### Scenario: New tool names display in English

- **WHEN** app locale is set to en
- **THEN** the four new tools SHALL display their English names on the home page and tool page AppBar

<!-- @trace
source: add-tools-batch-2
updated: 2026-03-19
code:
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/tools/screen_ruler/ruler_painter.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - lib/tools/level/level_page.dart
  - patches/audio_streamer/android/gradle.properties
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - pubspec.yaml
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/favorites_page.dart
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - lib/l10n/app_zh.arb
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/README.md
  - lib/app.dart
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - lib/tools/invoice_checker/invoice_api.dart
  - lib/tools/invoice_checker/invoice_parser.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - ios/Runner/Info.plist
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/widgets/bento_grid.dart
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - pubspec.lock
  - lib/tools/split_bill/split_bill_page.dart
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - lib/widgets/bouncing_button.dart
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - lib/models/tool_item.dart
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - lib/pages/home_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - lib/tools/bmi_calculator/bmi_logic.dart
  - lib/l10n/app_en.arb
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - lib/tools/random_wheel/wheel_painter.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/README.md
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - patches/audio_streamer/example/android/gradle.properties
  - lib/l10n/app_localizations_en.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - lib/l10n/app_localizations.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/android/settings.gradle
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - lib/tools/password_generator/password_generator_page.dart
tests:
  - test/tools/password_generator_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/tools/split_bill_test.dart
  - test/tools/invoice_checker_test.dart
  - test/tools/qr_generator_test.dart
  - test/widgets/bento_grid_test.dart
  - test/tools/bmi_calculator_logic_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/models/tool_item_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/theme/app_theme_test.dart
  - test/pages/home_page_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
-->