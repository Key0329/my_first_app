# app-shell Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: App entry point and root widget

The app SHALL use `MaterialApp.router` with GoRouter as the routing engine. The app SHALL apply Material 3 theming with `ColorScheme.fromSeed(seedColor: Colors.teal)`. The theme SHALL include extended configuration for transparent AppBar styles, surface container colors for the immersive tool scaffold body sections, and card themes supporting gradient backgrounds.

#### Scenario: App launches with correct theme

- **WHEN** the app starts
- **THEN** the Material 3 theme with teal seed color SHALL be applied, including transparent AppBar support and extended card styling


<!-- @trace
source: design-overhaul-bento
updated: 2026-03-19
code:
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - lib/widgets/bento_grid.dart
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/README.md
  - lib/l10n/app_localizations.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - pubspec.lock
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/l10n/app_en.arb
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/widgets/bouncing_button.dart
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - ios/Runner/Info.plist
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - lib/models/tool_item.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - patches/audio_streamer/example/README.md
  - pubspec.yaml
  - lib/tools/qr_generator/qr_generator_page.dart
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - lib/tools/password_generator/password_generator_page.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - lib/pages/favorites_page.dart
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/home_page.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations_en.dart
  - patches/audio_streamer/android/gradle.properties
  - lib/tools/calculator/calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/android/gradle.properties
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/level/level_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/app.dart
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - lib/tools/unit_converter/unit_converter_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - patches/audio_streamer/android/settings.gradle
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
tests:
  - test/theme/app_theme_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
  - test/widgets/bento_grid_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/pages/home_page_test.dart
  - test/tools/password_generator_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Bottom navigation with three tabs

The app SHALL display a bottom navigation bar with three tabs: Tools (工具), Favorites (收藏), and Settings (設定). The navigation SHALL use GoRouter ShellRoute to maintain tab state.

#### Scenario: User switches between tabs

- **WHEN** user taps a bottom navigation tab
- **THEN** the corresponding page SHALL be displayed while the bottom navigation bar remains visible


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
### Requirement: Tool pages open in full screen

When a user navigates to a tool page, the app SHALL push a full-screen route that hides the bottom navigation bar. The tool page SHALL use ImmersiveToolScaffold with a transparent AppBar showing the tool name and a back button. The route transition SHALL use CustomTransitionPage to support Hero animations between the home card and tool page.

#### Scenario: User opens a tool from the list

- **WHEN** user taps a tool card on the home page
- **THEN** the tool page SHALL open in full screen with a Hero transition animation and without the bottom navigation bar

#### Scenario: User returns from a tool page

- **WHEN** user taps the back button on a tool page
- **THEN** the app SHALL return to the previous tab with its state preserved, using a reverse Hero transition animation


<!-- @trace
source: design-overhaul-bento
updated: 2026-03-19
code:
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - lib/widgets/bento_grid.dart
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/README.md
  - lib/l10n/app_localizations.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - pubspec.lock
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/l10n/app_en.arb
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/widgets/bouncing_button.dart
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - ios/Runner/Info.plist
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - lib/models/tool_item.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - patches/audio_streamer/example/README.md
  - pubspec.yaml
  - lib/tools/qr_generator/qr_generator_page.dart
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - lib/tools/password_generator/password_generator_page.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - lib/pages/favorites_page.dart
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/home_page.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations_en.dart
  - patches/audio_streamer/android/gradle.properties
  - lib/tools/calculator/calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/android/gradle.properties
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/level/level_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/app.dart
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - lib/tools/unit_converter/unit_converter_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - patches/audio_streamer/android/settings.gradle
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
tests:
  - test/theme/app_theme_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
  - test/widgets/bento_grid_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/pages/home_page_test.dart
  - test/tools/password_generator_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Tool list displayed as grid

The home page SHALL display all tools in a Bento Grid layout with variable-sized cards. Favorited tools SHALL be displayed as large cards spanning 2 columns. The home page SHALL include a search bar at the top to filter tools by name. When filtering, the Bento layout SHALL recalculate for the visible tools.

#### Scenario: User views the tool list

- **WHEN** user is on the Tools tab
- **THEN** all 12 tools SHALL be displayed in a Bento Grid layout with variable card sizes

#### Scenario: User searches for a tool

- **WHEN** user types a query in the search bar
- **THEN** only tools whose name contains the query SHALL be displayed in a recalculated Bento layout


<!-- @trace
source: design-overhaul-bento
updated: 2026-03-19
code:
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - patches/audio_streamer/lib/audio_streamer.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - patches/audio_streamer/example/android/settings.gradle
  - patches/audio_streamer/pubspec.yaml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - lib/widgets/bento_grid.dart
  - lib/widgets/staggered_fade_in.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - patches/audio_streamer/README.md
  - lib/l10n/app_localizations.dart
  - lib/tools/invoice_checker/invoice_checker_page.dart
  - pubspec.lock
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/l10n/app_en.arb
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - patches/audio_streamer/android/src/main/kotlin/plugins/cachet/audio_streamer/AudioStreamerPlugin.kt
  - patches/audio_streamer/example/android/gradle/wrapper/gradle-wrapper.properties
  - patches/audio_streamer/example/ios/Flutter/Debug.xcconfig
  - patches/audio_streamer/example/android/app/src/debug/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - lib/widgets/bouncing_button.dart
  - patches/audio_streamer/example/android/app/src/main/kotlin/plugins/cachet/audio_streamer_example/MainActivity.kt
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.pbxproj
  - patches/audio_streamer/example/android/app/src/main/res/values/styles.xml
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - patches/audio_streamer/ios/audio_streamer.podspec
  - patches/audio_streamer/example/ios/Flutter/AppFrameworkInfo.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - ios/Runner/Info.plist
  - lib/tools/compass/compass_page.dart
  - patches/audio_streamer/example/android/app/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata
  - lib/models/tool_item.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - lib/widgets/tool_card.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.h
  - patches/audio_streamer/example/README.md
  - pubspec.yaml
  - lib/tools/qr_generator/qr_generator_page.dart
  - patches/audio_streamer/example/ios/Runner/Base.lproj/Main.storyboard
  - lib/tools/protractor/protractor_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - patches/audio_streamer/example/ios/Podfile
  - patches/audio_streamer/analysis_options.yaml
  - patches/audio_streamer/example/ios/Runner/Info.plist
  - patches/audio_streamer/example/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - lib/tools/flashlight/flashlight_page.dart
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - lib/tools/password_generator/password_generator_page.dart
  - patches/audio_streamer/android/src/main/AndroidManifest.xml
  - lib/pages/favorites_page.dart
  - patches/audio_streamer/ios/Classes/AudioStreamerPlugin.m
  - patches/audio_streamer/example/android/app/src/profile/AndroidManifest.xml
  - patches/audio_streamer/example/ios/Runner/AppDelegate.swift
  - patches/audio_streamer/example/ios/Flutter/Release.xcconfig
  - lib/pages/home_page.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations_en.dart
  - patches/audio_streamer/android/gradle.properties
  - lib/tools/calculator/calculator_page.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - lib/widgets/immersive_tool_scaffold.dart
  - patches/audio_streamer/example/pubspec.yaml
  - patches/audio_streamer/ios/Classes/SwiftAudioStreamerPlugin.swift
  - lib/theme/app_theme.dart
  - patches/audio_streamer/example/android/gradle.properties
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - patches/audio_streamer/example/android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - android/app/src/main/AndroidManifest.xml
  - lib/tools/level/level_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - patches/audio_streamer/example/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - patches/audio_streamer/LICENSE
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
  - patches/audio_streamer/example/android/app/src/main/AndroidManifest.xml
  - lib/app.dart
  - patches/audio_streamer/example/ios/Runner/Runner-Bridging-Header.h
  - patches/audio_streamer/android/build.gradle
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - patches/audio_streamer/example/lib/main.dart
  - patches/audio_streamer/CHANGELOG.md
  - patches/audio_streamer/example/android/app/src/main/res/drawable/launch_background.xml
  - lib/tools/unit_converter/unit_converter_page.dart
  - patches/audio_streamer/example/android/build.gradle
  - patches/audio_streamer/example/ios/Runner.xcworkspace/contents.xcworkspacedata
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
  - patches/audio_streamer/example/ios/Runner/Base.lproj/LaunchScreen.storyboard
  - patches/audio_streamer/android/settings.gradle
  - lib/l10n/app_localizations_zh.dart
  - patches/audio_streamer/example/ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
tests:
  - test/theme/app_theme_test.dart
  - patches/audio_streamer/test/audio_streamer_test.dart
  - test/widgets/bento_grid_test.dart
  - test/models/tool_item_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/pages/favorites_page_test.dart
  - test/widgets/tool_card_test.dart
  - test/widgets/immersive_tool_scaffold_test.dart
  - test/pages/home_page_test.dart
  - test/tools/password_generator_test.dart
  - test/widgets/staggered_fade_in_test.dart
  - test/tools/qr_generator_test.dart
-->

---
### Requirement: Dark mode support

The app SHALL support three theme modes: light, dark, and system default. The theme mode setting SHALL persist across app restarts using shared_preferences.

#### Scenario: User switches to dark mode

- **WHEN** user selects dark mode in settings
- **THEN** the entire app SHALL switch to the dark color scheme immediately

#### Scenario: Theme persists after restart

- **WHEN** user has set a theme mode and restarts the app
- **THEN** the previously selected theme mode SHALL be applied on launch

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