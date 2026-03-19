# tool-screen-ruler Specification

## Purpose

TBD - created by archiving change 'add-tools-batch-2'. Update Purpose after archive.

## Requirements

### Requirement: Credit card PPI calibration

On first use (or when no calibration data exists), the screen ruler SHALL display a calibration screen with a credit card outline (standard ISO/IEC 7810 ID-1: 85.6mm × 53.98mm). The user SHALL adjust the outline size using a slider until it matches a physical credit card placed on the screen. The system SHALL calculate screen PPI from the known physical dimension and the calibrated pixel dimension. The calibrated PPI value SHALL be persisted to SharedPreferences.

#### Scenario: First-time calibration

- **WHEN** user opens the screen ruler with no saved PPI value
- **THEN** the system SHALL display the calibration screen with a credit card outline and a size adjustment slider

#### Scenario: User completes calibration

- **WHEN** user adjusts the slider to match the credit card and taps "Complete Calibration"
- **THEN** the system SHALL calculate PPI as (card pixel width / 85.6mm × 25.4), save it to SharedPreferences, and transition to the ruler display

#### Scenario: Calibration data already exists

- **WHEN** user opens the screen ruler with a saved PPI value
- **THEN** the system SHALL skip calibration and display the ruler directly


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

---
### Requirement: Dual-scale ruler display

After calibration, the screen ruler SHALL display a ruler along the left edge of the screen using CustomPainter. The ruler SHALL show dual scales: centimeters on the left side and inches on the right side.

Centimeter markings:
- Every millimeter: short tick mark
- Every 5 millimeters: medium tick mark
- Every centimeter: long tick mark with number label

Inch markings:
- Every 1/16 inch: short tick mark
- Every 1/4 inch: medium tick mark
- Every inch: long tick mark with number label

#### Scenario: User views the ruler

- **WHEN** the ruler is displayed after calibration
- **THEN** the ruler SHALL show accurate centimeter and inch markings based on the calibrated PPI value

#### Scenario: User scrolls the ruler

- **WHEN** user scrolls vertically on the ruler
- **THEN** the ruler markings SHALL scroll to allow measuring lengths beyond the visible screen area


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

---
### Requirement: Recalibration option

The header area SHALL display the current PPI value and a "Recalibrate" button. Tapping the button SHALL return to the calibration screen.

#### Scenario: User initiates recalibration

- **WHEN** user taps the "Recalibrate" button
- **THEN** the system SHALL display the calibration screen with the slider preset to the current PPI value


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

---
### Requirement: ImmersiveToolScaffold integration

The screen ruler page SHALL use ImmersiveToolScaffold with tool color `Color(0xFF5C6BC0)`, icon `Icons.square_foot`, and Hero animation tag `tool_hero_screen_ruler`.

#### Scenario: User opens screen ruler from home page

- **WHEN** user taps the screen ruler card on the home page
- **THEN** the tool page SHALL open with a Hero transition animation using ImmersiveToolScaffold layout

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