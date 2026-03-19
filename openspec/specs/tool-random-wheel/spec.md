# tool-random-wheel Specification

## Purpose

TBD - created by archiving change 'add-tools-batch-2'. Update Purpose after archive.

## Requirements

### Requirement: Spinning wheel with custom options

The random wheel SHALL display a circular wheel divided into equal-sized colored segments, one per option. The wheel SHALL be rendered using CustomPainter. A fixed triangular pointer at the top of the wheel SHALL indicate the selected segment. The system SHALL support a minimum of 2 and a maximum of 20 options.

#### Scenario: Wheel displays with default options

- **WHEN** user opens the random wheel for the first time
- **THEN** the wheel SHALL display with two default options: "Option 1" and "Option 2" (localized)

#### Scenario: User adds a new option

- **WHEN** user types an option name in the input field and taps the add button
- **THEN** the wheel SHALL add a new segment and redistribute all segments equally

#### Scenario: User removes an option

- **WHEN** user swipes left on an option in the list
- **THEN** the option SHALL be removed from the wheel and segments SHALL redistribute equally

#### Scenario: User attempts to remove below minimum

- **WHEN** only 2 options remain and user attempts to delete one
- **THEN** the deletion SHALL be prevented and the system SHALL display a message that at least 2 options are required


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
### Requirement: Spin animation with deceleration

The wheel SHALL spin when the user taps the spin button. The spin animation SHALL use AnimationController with CurvedAnimation and Curves.decelerate to create a natural deceleration effect. The spin duration SHALL be randomized between 2 and 4 seconds. The final resting angle SHALL determine the selected option.

#### Scenario: User spins the wheel

- **WHEN** user taps the spin button
- **THEN** the wheel SHALL rotate with a decelerating animation and stop at a random position after 2–4 seconds

#### Scenario: Spin completes

- **WHEN** the wheel stops spinning
- **THEN** the system SHALL display a dialog showing the selected option name

#### Scenario: User taps spin while already spinning

- **WHEN** user taps the spin button while the wheel is animating
- **THEN** the button SHALL be disabled and the tap SHALL be ignored


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
### Requirement: Option list management

The body area SHALL display a scrollable list of all current options. Each option SHALL show a color indicator matching its wheel segment color. New options SHALL be added via a text input field with an add button at the bottom of the list.

#### Scenario: User views option list

- **WHEN** the wheel has N options
- **THEN** the list SHALL show N items, each with a color dot matching the wheel segment


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

The random wheel page SHALL use ImmersiveToolScaffold with tool color `Color(0xFFFF7043)`, icon `Icons.casino`, and Hero animation tag `tool_hero_random_wheel`.

#### Scenario: User opens random wheel from home page

- **WHEN** user taps the random wheel card on the home page
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