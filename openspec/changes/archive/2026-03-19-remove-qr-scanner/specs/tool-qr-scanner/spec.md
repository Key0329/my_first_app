## REMOVED Requirements

### Requirement: QR Code and Barcode scanning

**Reason**: Modern iOS and Android devices have built-in QR Code scanning in their native camera apps, making this feature redundant.
**Migration**: Users SHALL use their device's native camera app for QR Code scanning.

#### Scenario: Feature removed

- **WHEN** user opens the QR tool
- **THEN** no scanning functionality SHALL be present

### Requirement: Camera permission handling

**Reason**: Camera permission was only required for the scanning feature. With scanning removed, the app no longer needs camera access.
**Migration**: No migration needed. Camera permission declarations SHALL be removed from platform manifests.

#### Scenario: Permission removed

- **WHEN** the app is installed
- **THEN** the app SHALL NOT request camera permission

## MODIFIED Requirements

### Requirement: QR Code generation

The tool SHALL allow users to generate QR Codes from text input. The generated QR Code SHALL be rendered as an actual QR Code image using the `qr_flutter` package, encoding the user's input text. The QR Code image SHALL update to reflect different input content. The tool SHALL be named "QR Code 產生器" (zh) / "QR Generator" (en) and SHALL NOT include any scanning functionality.

#### Scenario: User generates a QR Code

- **WHEN** user enters text and taps the generate button
- **THEN** a QR Code image encoding the input text SHALL be displayed, rendered by the `qr_flutter` package

#### Scenario: User generates QR Codes with different content

- **WHEN** user generates a QR Code with text "Hello" and then generates another with text "World"
- **THEN** the two displayed QR Code images SHALL be visually different, each encoding their respective input text
