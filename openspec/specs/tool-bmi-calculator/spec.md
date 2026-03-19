# tool-bmi-calculator Specification

## Purpose

TBD - created by archiving change 'add-tools-batch-2'. Update Purpose after archive.

## Requirements

### Requirement: BMI calculation from height and weight

The BMI calculator SHALL accept height input in centimeters (range 140–220) and weight input in kilograms (range 30–200) via interactive sliders. The system SHALL calculate BMI using the formula: BMI = weight(kg) / height(m)². The result SHALL update in real-time as the user adjusts either slider.

#### Scenario: User adjusts height and weight sliders

- **WHEN** user moves the height or weight slider
- **THEN** the BMI value SHALL recalculate and display immediately without requiring a submit action

#### Scenario: Default values on first open

- **WHEN** user opens the BMI calculator for the first time
- **THEN** the height slider SHALL default to 170 cm and the weight slider SHALL default to 65 kg


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
### Requirement: BMI category classification display

The system SHALL classify the calculated BMI into four categories based on WHO standards and display the category with a corresponding color indicator:
- Underweight (< 18.5): blue
- Normal (18.5–24.9): green
- Overweight (25.0–29.9): orange
- Obese (≥ 30.0): red

The header area SHALL display a circular gauge visualization showing the BMI value with a color band representing the category ranges.

#### Scenario: BMI falls in normal range

- **WHEN** the calculated BMI is between 18.5 and 24.9
- **THEN** the system SHALL display "Normal" category label with green color indicator and the gauge pointer SHALL point to the normal range zone

#### Scenario: BMI falls in obese range

- **WHEN** the calculated BMI is 30.0 or above
- **THEN** the system SHALL display "Obese" category label with red color indicator and the gauge pointer SHALL point to the obese range zone


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
### Requirement: Healthy weight range suggestion

The system SHALL calculate and display the healthy weight range (BMI 18.5–24.9) for the currently selected height.

#### Scenario: User views healthy weight range

- **WHEN** user has set a height value
- **THEN** the system SHALL display the minimum and maximum weight values that correspond to a normal BMI for that height


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

The BMI calculator page SHALL use ImmersiveToolScaffold with tool color `Color(0xFFE91E63)`, icon `Icons.monitor_heart`, and Hero animation tag `tool_hero_bmi_calculator`.

#### Scenario: User opens BMI calculator from home page

- **WHEN** user taps the BMI calculator card on the home page
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