# tool-qr-scanner Specification

## Purpose

TBD - created by archiving change 'mvp-v1-toolbox-app'. Update Purpose after archive.

## Requirements

### Requirement: QR Code generation

The tool SHALL allow users to generate QR Codes from text input. The generated QR Code SHALL be rendered as an actual QR Code image using the `qr_flutter` package, encoding the user's input text. The QR Code image SHALL update to reflect different input content. The tool SHALL be named "QR Code 產生器" (zh) / "QR Generator" (en) and SHALL NOT include any scanning functionality.

#### Scenario: User generates a QR Code

- **WHEN** user enters text and taps the generate button
- **THEN** a QR Code image encoding the input text SHALL be displayed, rendered by the `qr_flutter` package

#### Scenario: User generates QR Codes with different content

- **WHEN** user generates a QR Code with text "Hello" and then generates another with text "World"
- **THEN** the two displayed QR Code images SHALL be visually different, each encoding their respective input text

<!-- @trace
source: remove-qr-scanner
updated: 2026-03-19
code:
  - ios/Runner/Info.plist
  - lib/l10n/app_en.arb
  - pubspec.lock
  - lib/tools/flashlight/flashlight_page.dart
  - android/app/src/main/AndroidManifest.xml
  - pubspec.yaml
  - lib/models/tool_item.dart
  - lib/app.dart
  - lib/l10n/app_zh.arb
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_localizations_zh.dart
  - lib/tools/qr_generator/qr_generator_page.dart
  - lib/tools/qr_scanner/qr_scanner_page.dart
  - lib/l10n/app_localizations_en.dart
tests:
  - test/tools/qr_generator_test.dart
-->