## MODIFIED Requirements

### Requirement: QR Code generation

The scanner SHALL allow users to generate QR Codes from text input. The generated QR Code SHALL be rendered as an actual QR Code image using the `qr_flutter` package, encoding the user's input text. The QR Code image SHALL update to reflect different input content.

#### Scenario: User generates a QR Code

- **WHEN** user enters text and taps the generate button
- **THEN** a QR Code image encoding the input text SHALL be displayed, rendered by the `qr_flutter` package

#### Scenario: User generates QR Codes with different content

- **WHEN** user generates a QR Code with text "Hello" and then generates another with text "World"
- **THEN** the two displayed QR Code images SHALL be visually different, each encoding their respective input text
