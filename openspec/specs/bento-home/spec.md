# bento-home Specification

## Purpose

TBD - created by archiving change 'design-overhaul-bento'. Update Purpose after archive.

## Requirements

### Requirement: Bento Grid layout with variable card sizes

The home page SHALL display tools in a Bento Grid layout using a CustomScrollView with SliverGrid. Cards SHALL have three possible sizes: large (spanning 2 columns, 1.5x height), medium (1 column, 1.2x height), and small (1 column, 1x height). The layout SHALL dynamically arrange cards based on available sizes to fill rows without gaps.

#### Scenario: Home page displays Bento Grid layout

- **WHEN** user navigates to the Tools tab
- **THEN** tools SHALL be displayed in a Bento Grid with variable-sized cards instead of a uniform 2-column grid

#### Scenario: Favorited tools display as large cards

- **WHEN** a tool is marked as favorite
- **THEN** that tool's card SHALL be displayed at large size (spanning 2 columns)

#### Scenario: Non-favorited tools display as medium or small cards

- **WHEN** a tool is not marked as favorite
- **THEN** that tool's card SHALL be displayed at medium or small size based on the Bento layout algorithm


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
### Requirement: Tool cards with gradient backgrounds

Each tool card on the home page SHALL display a gradient background using the tool's designated color. In light mode, the gradient SHALL use the tool color at 30% opacity transitioning to 10% opacity. In dark mode, the gradient SHALL use 40% opacity transitioning to 15% opacity. The card SHALL display the tool icon and name over the gradient background.

#### Scenario: Tool card displays gradient in light mode

- **WHEN** the app is in light mode
- **THEN** each tool card SHALL show a top-to-bottom gradient from toolColor at 0.3 opacity to toolColor at 0.1 opacity

#### Scenario: Tool card displays gradient in dark mode

- **WHEN** the app is in dark mode
- **THEN** each tool card SHALL show a top-to-bottom gradient from toolColor at 0.4 opacity to toolColor at 0.15 opacity


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
### Requirement: Search bar filters Bento Grid

The search bar SHALL remain at the top of the home page. When the user types a search query, the Bento Grid SHALL filter to show only matching tools. The Bento layout SHALL recalculate card sizes for the filtered set.

#### Scenario: User searches and Bento Grid updates

- **WHEN** user types a query in the search bar
- **THEN** the Bento Grid SHALL display only tools whose name contains the query, with the layout recalculated for the filtered set


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
### Requirement: Mini preview on large cards

Large cards (favorited tools) SHALL display a mini preview relevant to the tool's function when space permits. The mini preview SHALL be lightweight and non-interactive.

#### Scenario: Large calculator card shows last result

- **WHEN** calculator is favorited and displayed as a large card
- **THEN** the card SHALL show a mini preview of the last calculation result if available

#### Scenario: Large compass card shows current heading

- **WHEN** compass is favorited and displayed as a large card
- **THEN** the card SHALL show a mini preview of the current compass heading if sensor data is available

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