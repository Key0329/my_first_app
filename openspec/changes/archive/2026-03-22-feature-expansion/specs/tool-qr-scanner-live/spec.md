## ADDED Requirements

### Requirement: QR Code live scanning

The tool SHALL provide a live camera preview using `mobile_scanner` for real-time QR Code scanning. The camera preview SHALL be displayed in the upper area of the ImmersiveToolScaffold layout with a scan frame overlay animation. When a QR Code is detected, the scanner SHALL automatically decode it and display the result.

#### Scenario: User scans a QR Code successfully

- **WHEN** user opens the QR scanner tool and points the camera at a valid QR Code
- **THEN** the system SHALL decode the QR Code and display the decoded content in the result area below the camera preview

#### Scenario: Camera preview is active

- **WHEN** user opens the QR scanner tool
- **THEN** a live camera preview SHALL be displayed with a scan frame overlay indicating the scanning area

### Requirement: QR scan result handling

The tool SHALL automatically detect the type of scanned content (URL, plain text, WiFi configuration) and display corresponding action buttons. For URL results, an "Open in browser" button SHALL be provided. For all result types, a "Copy to clipboard" button SHALL be available.

#### Scenario: User scans a URL QR Code

- **WHEN** user scans a QR Code containing a URL
- **THEN** the result area SHALL display the URL text and provide both "Open in browser" and "Copy to clipboard" action buttons

#### Scenario: User scans a plain text QR Code

- **WHEN** user scans a QR Code containing plain text
- **THEN** the result area SHALL display the text content and provide a "Copy to clipboard" action button

### Requirement: Camera permission handling

The tool SHALL request camera permission when first opened. If the user denies camera permission, the tool SHALL display a guidance message explaining why camera access is needed and provide a button to open system settings.

#### Scenario: Camera permission denied

- **WHEN** user denies camera permission
- **THEN** the tool SHALL display a message explaining that camera access is required for QR scanning and SHALL provide a button to open system settings

#### Scenario: Camera permission granted

- **WHEN** user grants camera permission
- **THEN** the camera preview SHALL start immediately and begin scanning for QR Codes
