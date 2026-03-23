# brand-splash-screen Specification

## Purpose

TBD - created by archiving change 'brand-visual-upgrade'. Update Purpose after archive.

## Requirements

### Requirement: Native splash screen with brand identity

The app SHALL display a native splash screen during cold start that shows the brand primary color (#6C5CE7) as the background with the app icon centered on screen. The splash screen SHALL be implemented using flutter_native_splash to ensure it displays before the Flutter engine initializes. The splash screen SHALL be configured for both Android and iOS platforms.

#### Scenario: App cold start shows branded splash

- **WHEN** the user launches the app from a cold start
- **THEN** the native splash screen SHALL display with the brand purple background and centered app icon before the Flutter UI loads

#### Scenario: Splash screen transitions to app

- **WHEN** the Flutter engine finishes initializing
- **THEN** the splash screen SHALL transition smoothly to the first Flutter screen (onboarding or home page)

<!-- @trace
source: brand-visual-upgrade
updated: 2026-03-23
code:
  - android/app/src/main/res/drawable/background.png
  - ios/Runner/Info.plist
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@2x.png
  - pubspec.yaml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@2x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png
  - ios/Runner/Base.lproj/LaunchScreen.storyboard
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-72x72@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png
  - ios/Runner/Assets.xcassets/LaunchBackground.imageset/Contents.json
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json
  - android/app/src/main/res/drawable-mdpi/splash.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png
  - android/app/src/main/res/drawable-night-xxhdpi/android12splash.png
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png
  - android/app/src/main/res/values-night-v31/styles.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png
  - android/app/src/main/res/drawable-hdpi/android12splash.png
  - android/app/src/main/res/drawable-mdpi/android12splash.png
  - ios/Runner/Assets.xcassets/LaunchBackground.imageset/background.png
  - android/app/src/main/res/drawable/launch_background.xml
  - android/app/src/main/res/drawable-xhdpi/android12splash.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-57x57@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png
  - android/app/src/main/res/values-night/styles.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-50x50@2x.png
  - android/app/src/main/res/drawable-xxxhdpi/android12splash.png
  - android/app/src/main/res/mipmap-hdpi/ic_launcher.png
  - android/app/src/main/res/drawable-night-hdpi/android12splash.png
  - assets/icon/app_icon.png
  - android/app/src/main/res/drawable-v21/background.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png
  - android/app/src/main/res/drawable-night-mdpi/android12splash.png
  - pubspec.lock
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png
  - android/app/src/main/res/drawable-v21/launch_background.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png
  - android/app/src/main/res/mipmap-mdpi/ic_launcher.png
  - android/app/src/main/res/values-v31/styles.xml
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png
  - android/app/src/main/res/drawable-xhdpi/splash.png
  - android/app/src/main/res/drawable-xxhdpi/android12splash.png
  - android/app/src/main/res/values/styles.xml
  - ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png
  - android/app/src/main/res/drawable-night-xhdpi/android12splash.png
  - android/app/src/main/res/drawable-xxhdpi/splash.png
  - android/app/src/main/res/drawable-xxxhdpi/splash.png
  - android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
  - android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
  - android/app/src/main/res/drawable-night-xxxhdpi/android12splash.png
  - lib/pages/onboarding_page.dart
  - android/app/src/main/res/drawable-hdpi/splash.png
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png
  - android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
  - ios/Runner.xcodeproj/project.pbxproj
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json
  - ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png
-->