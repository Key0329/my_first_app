# immersive-tool-theme Specification

## Purpose

TBD - created by archiving change 'design-overhaul-bento'. Update Purpose after archive.

## Requirements

### Requirement: ImmersiveToolScaffold shared base widget

All tool pages SHALL use an ImmersiveToolScaffold widget as their base layout. This scaffold SHALL provide a two-section layout: an upper header area with gradient background using the tool's color, and a lower body area with a rounded-corner surface container. The AppBar SHALL be transparent and overlay the gradient header. The body area SHALL use `DT.toolBodyPadding` for outer padding and SHALL organize content using ToolSectionCard containers. In light mode, ToolSectionCard SHALL apply `DT.shadowMd` for visual depth. In dark mode, ToolSectionCard SHALL continue using border-only styling without shadows.

#### Scenario: Tool page renders with immersive layout

- **WHEN** user opens any tool page
- **THEN** the page SHALL display with a gradient header area at the top and a rounded-corner body area at the bottom with content organized in ToolSectionCard containers

#### Scenario: AppBar is transparent over gradient

- **WHEN** user views a tool page
- **THEN** the AppBar SHALL be transparent with the tool title and back button visible over the gradient background

#### Scenario: ToolSectionCard has shadow in light mode

- **WHEN** a ToolSectionCard renders in light mode
- **THEN** the card container SHALL apply DT.shadowMd BoxShadow for visual depth

#### Scenario: ToolSectionCard has no shadow in dark mode

- **WHEN** a ToolSectionCard renders in dark mode
- **THEN** the card container SHALL NOT apply any BoxShadow and SHALL rely on border styling only


<!-- @trace
source: design-system-v2
updated: 2026-03-23
code:
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/pages/settings_page.dart
  - lib/l10n/app_localizations_en.dart
  - lib/widgets/tool_recommendation_bar.dart
  - lib/theme/design_tokens.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/random_wheel/wheel_result_overlay.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/word_counter/word_counter_page.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/pages/home_page.dart
  - lib/tools/level/level_page.dart
  - lib/widgets/tool_card.dart
  - lib/tools/pomodoro/pomodoro_page.dart
  - lib/tools/qr_scanner_live/qr_scanner_live_page.dart
  - lib/l10n/app_localizations.dart
  - lib/theme/app_theme.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_en.arb
  - lib/tools/date_calculator/date_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/split_bill/split_bill_page.dart
tests:
  - test/widgets/tool_card_test.dart
  - test/theme/design_tokens_v2_test.dart
  - test/theme/color_contrast_test.dart
-->

---
### Requirement: Tool-specific gradient colors

The header gradient SHALL use the tool's designated color from ToolItem.color. In light mode, the gradient SHALL transition from toolColor at 0.8 opacity to toolColor at 0.4 opacity (top to bottom). In dark mode, the gradient SHALL transition from toolColor at 0.5 opacity to toolColor at 0.2 opacity.

#### Scenario: Calculator page shows green gradient

- **WHEN** user opens the calculator tool (color: 0xFF4CAF50)
- **THEN** the header area SHALL display a green gradient background

#### Scenario: Flashlight page shows amber gradient

- **WHEN** user opens the flashlight tool (color: 0xFFFFC107)
- **THEN** the header area SHALL display an amber gradient background

#### Scenario: Gradient adapts to dark mode

- **WHEN** the app is in dark mode and user opens a tool
- **THEN** the gradient SHALL use reduced opacity values (0.5 to 0.2) for the tool color


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
### Requirement: Configurable header and body flex ratios

The ImmersiveToolScaffold SHALL accept configurable flex ratios for the header and body sections. Each tool page SHALL specify its preferred ratio based on the amount of display content vs. interactive content. Default ratio SHALL be 2:3 (header:body).

#### Scenario: Calculator uses custom flex ratio

- **WHEN** calculator page is rendered
- **THEN** the header (display area) and body (button grid) SHALL use the ratio specified by the calculator page

#### Scenario: Default ratio applies when not specified

- **WHEN** a tool page does not specify custom flex ratios
- **THEN** the scaffold SHALL use the default 2:3 ratio


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
### Requirement: Rounded corner separator between sections

The body section SHALL have top-left and top-right rounded corners (radius 24px) that overlap the gradient header area by the corner radius amount, creating a sheet-like visual effect.

#### Scenario: Body section displays with rounded top corners

- **WHEN** user views any tool page
- **THEN** the body section SHALL have rounded top corners that visually overlap the gradient header

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
### Requirement: Body area Bento card organization

The ImmersiveToolScaffold body area SHALL organize its contents using ToolSectionCard containers instead of raw widget layouts. The body area SHALL use `DT.toolBodyPadding` (16dp) outer padding. Tool pages SHALL NOT use hardcoded padding or spacing values in the body area; all spacing SHALL reference DT tokens.

#### Scenario: Body content uses ToolSectionCard containers

- **WHEN** user opens any tool page
- **THEN** the body area controls SHALL be grouped inside ToolSectionCard containers with consistent spacing and styling

#### Scenario: Body area uses DT token padding

- **WHEN** user opens any tool page
- **THEN** the body area outer padding SHALL be exactly `DT.toolBodyPadding` (16dp) on all sides


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Tool gradient button replaces FilledButton for primary actions

Each tool page's primary call-to-action SHALL use ToolGradientButton instead of the default Material FilledButton. The gradient SHALL use the tool's colors from `toolGradients` map. Secondary actions (reset, swap, history) SHALL continue using standard Material buttons.

#### Scenario: Password generator uses gradient generate button

- **WHEN** user views the password generator page
- **THEN** the "Generate" button SHALL display with the tool's purple gradient background instead of the default Material primary color

#### Scenario: Secondary actions remain standard

- **WHEN** user views the stopwatch page
- **THEN** the "Reset" button SHALL remain a standard OutlinedButton while the "Start" button SHALL use ToolGradientButton


<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Result section tinted background

Tool pages following Mode A (Input-Result) layout SHALL display result sections with a tinted background using the tool's color. In light mode, the tint SHALL be the tool color at 8% opacity. In dark mode, the tint SHALL be the tool color at 15% opacity. This tinted background SHALL visually distinguish result sections from input sections.

#### Scenario: Split bill result card has tinted background

- **WHEN** user views the split bill result section
- **THEN** the result card SHALL have a teal-tinted background (tool color 0xFF26A69A at 8% opacity in light mode)

#### Scenario: Result tint adapts to dark mode

- **WHEN** user views a tool page result section in dark mode
- **THEN** the result card background SHALL use the tool color at 15% opacity

<!-- @trace
source: tool-pages-bento-redesign
updated: 2026-03-22
code:
  - lib/theme/design_tokens.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/compass/compass_page.dart
  - lib/widgets/animated_value_text.dart
  - CLAUDE.md
  - lib/tools/split_bill/split_bill_page.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/bmi_calculator/bmi_calculator_page.dart
  - lib/widgets/tool_section_card.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/level/level_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/password_generator/password_generator_page.dart
  - lib/tools/unit_converter/unit_converter_page.dart
  - lib/widgets/tool_gradient_button.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/widgets/immersive_tool_scaffold.dart
tests:
  - test/widgets/animated_value_text_test.dart
  - test/widgets/tool_section_card_test.dart
  - test/widgets/bouncing_button_test.dart
  - test/widgets/tool_gradient_button_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/password_generator_test.dart
-->

---
### Requirement: Unified error state display

Tool pages that encounter errors (sensor initialization failure, network errors, permission denied) SHALL display a standardized error state within a ToolSectionCard. The error state SHALL use `colorScheme.error` for text and icon color, SHALL display `Icons.error_outline` as the error icon, and SHALL center the error message within the card. An optional retry button SHALL be provided when the error is recoverable. The error state pattern SHALL be consistent across all tool pages.

#### Scenario: Sensor initialization failure shows error state

- **WHEN** a sensor-dependent tool (noise meter, compass, level) fails to initialize its sensor
- **THEN** the tool page SHALL display the standardized error state with the error icon, an error message in colorScheme.error color, and a retry button

#### Scenario: Error state uses consistent styling

- **WHEN** any tool page displays an error state
- **THEN** the error icon SHALL be Icons.error_outline, the text color SHALL be colorScheme.error, and the layout SHALL be centered within a ToolSectionCard

#### Scenario: Retry button triggers re-initialization

- **WHEN** user taps the retry button on an error state display
- **THEN** the tool SHALL attempt to re-initialize the failed resource and show a loading indicator during the attempt


<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: Confirmation dialog for destructive actions

Tool pages with destructive actions SHALL display a confirmation dialog before executing the action. The confirmation dialog SHALL use `showAdaptiveDialog` with `AlertDialog.adaptive` for platform-appropriate styling. The destructive action button SHALL use `colorScheme.error` color. The following actions SHALL require confirmation: calculator clear history, stopwatch reset, and random wheel delete option.

#### Scenario: Calculator clear history shows confirmation

- **WHEN** user taps the clear history button in the calculator
- **THEN** a confirmation dialog SHALL appear asking the user to confirm the action before clearing the history

#### Scenario: Stopwatch reset shows confirmation

- **WHEN** user taps the reset button on the stopwatch while it has recorded time or laps
- **THEN** a confirmation dialog SHALL appear asking the user to confirm the reset action

#### Scenario: Random wheel delete option shows confirmation

- **WHEN** user attempts to delete an option from the random wheel
- **THEN** a confirmation dialog SHALL appear asking the user to confirm the deletion

#### Scenario: Destructive button uses error color

- **WHEN** a confirmation dialog is displayed for any destructive action
- **THEN** the confirm/delete button SHALL use colorScheme.error as its text or background color


<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->

---
### Requirement: NumberPicker controller lifecycle fix

All widget pages that create controllers (TextEditingController, ScrollController, or similar) for NumberPicker or other input widgets SHALL create the controller in `initState` and call `controller.dispose()` in the `dispose` method. Controllers SHALL NOT be created inside the `build` method. The random wheel page SHALL be the primary target for this fix.

#### Scenario: Random wheel page disposes controllers properly

- **WHEN** the random wheel page is removed from the widget tree
- **THEN** all controllers created by the page SHALL be disposed via the dispose method

#### Scenario: Controllers are not recreated on rebuild

- **WHEN** the random wheel page widget rebuilds due to state changes
- **THEN** existing controllers SHALL be reused and SHALL NOT be recreated in the build method

<!-- @trace
source: quality-hardening
updated: 2026-03-22
code:
  - lib/tools/compass/compass_logic.dart
  - CLAUDE.md
  - lib/widgets/confirm_dialog.dart
  - lib/tools/calculator/calculator_page.dart
  - lib/pages/home_page.dart
  - .agents/skills/spectra-propose/SKILL.md
  - lib/pages/tool_search_delegate.dart
  - lib/widgets/error_state.dart
  - lib/tools/protractor/protractor_logic.dart
  - lib/theme/design_tokens.dart
  - lib/tools/flashlight/flashlight_page.dart
  - lib/tools/screen_ruler/screen_ruler_page.dart
  - lib/tools/noise_meter/noise_meter_logic.dart
  - lib/tools/level/level_logic.dart
  - lib/tools/protractor/protractor_page.dart
  - lib/tools/color_picker/color_picker_page.dart
  - lib/tools/level/level_page.dart
  - lib/utils/platform_check.dart
  - lib/tools/random_wheel/random_wheel_page.dart
  - lib/tools/stopwatch_timer/stopwatch_timer_page.dart
  - lib/tools/flashlight/flashlight_logic.dart
  - lib/tools/screen_ruler/screen_ruler_logic.dart
  - lib/tools/compass/compass_page.dart
  - lib/tools/noise_meter/noise_meter_page.dart
  - .mcp.json
  - lib/tools/color_picker/color_picker_logic.dart
tests:
  - test/tools/compass_logic_test.dart
  - test/tools/calculator_page_test.dart
  - test/tools/level_logic_test.dart
  - test/tools/stopwatch_timer_widget_test.dart
  - test/pages/tool_search_test.dart
  - test/utils/platform_check_test.dart
  - test/theme/design_tokens_test.dart
  - test/tools/color_picker_logic_test.dart
  - test/tools/noise_meter_logic_test.dart
  - test/tools/protractor_logic_test.dart
  - test/tools/screen_ruler_logic_test.dart
  - test/tools/flashlight_logic_test.dart
-->