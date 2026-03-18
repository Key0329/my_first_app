## ADDED Requirements

### Requirement: QR Code and Barcode scanning

The scanner SHALL use the device camera to scan QR Codes and Barcodes in real-time. The scanner SHALL display the decoded content after a successful scan.

#### Scenario: User scans a QR Code

- **WHEN** user points the camera at a QR Code
- **THEN** the decoded text SHALL be displayed with options to copy or open (if URL)

### Requirement: QR Code generation

The scanner SHALL allow users to generate QR Codes from text input. The generated QR Code SHALL be displayed on screen.

#### Scenario: User generates a QR Code

- **WHEN** user enters text and taps the generate button
- **THEN** a QR Code encoding the input text SHALL be displayed

### Requirement: Camera permission handling

The scanner SHALL request camera permission before accessing the camera. If permission is denied, a message SHALL explain why the permission is needed.

#### Scenario: Camera permission denied

- **WHEN** user denies camera permission
- **THEN** the scanner SHALL display a message explaining camera access is required for scanning and provide a button to open system settings
