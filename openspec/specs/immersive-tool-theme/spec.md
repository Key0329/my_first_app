# immersive-tool-theme Specification

## Purpose

TBD - created by archiving change 'design-overhaul-bento'. Update Purpose after archive.

## Requirements

### Requirement: ImmersiveToolScaffold shared base widget

All 15 tool pages SHALL use an ImmersiveToolScaffold widget as their base layout. This scaffold SHALL provide a two-section layout: an upper header area with gradient background using the tool's color, and a lower body area with a rounded-corner surface container. The AppBar SHALL be transparent and overlay the gradient header. The body area SHALL use `DT.toolBodyPadding` for outer padding and SHALL organize content using ToolSectionCard containers.

#### Scenario: Tool page renders with immersive layout

- **WHEN** user opens any tool page
- **THEN** the page SHALL display with a gradient header area at the top and a rounded-corner body area at the bottom with content organized in ToolSectionCard containers

#### Scenario: AppBar is transparent over gradient

- **WHEN** user views a tool page
- **THEN** the AppBar SHALL be transparent with the tool title and back button visible over the gradient background


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