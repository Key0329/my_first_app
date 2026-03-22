## MODIFIED Requirements

### Requirement: QR Code generation

The QR generator SHALL support multiple content types via a mode selector: Text (existing plain text input), WiFi (SSID, password, encryption type fields generating WIFI: format), and Email (recipient, subject, body fields generating mailto: format). The generated QR code SHALL encode the content in the appropriate format for each type.

#### Scenario: User generates a WiFi QR code

- **WHEN** user selects WiFi mode and fills in SSID and password
- **THEN** the QR code SHALL encode in WIFI:T:WPA;S:ssid;P:password;; format

#### Scenario: User generates an Email QR code

- **WHEN** user selects Email mode and fills in recipient and subject
- **THEN** the QR code SHALL encode in mailto: format
