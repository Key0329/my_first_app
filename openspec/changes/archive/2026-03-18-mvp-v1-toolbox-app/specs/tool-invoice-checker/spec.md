## ADDED Requirements

### Requirement: Invoice QR Code scanning

The invoice checker SHALL scan Taiwan Uniform Invoice QR Codes using the device camera. The system SHALL parse the first 10 characters of the QR Code data to extract the invoice number (2 uppercase letters + 8 digits).

#### Scenario: User scans an invoice QR Code

- **WHEN** user scans a valid invoice QR Code
- **THEN** the invoice number SHALL be extracted and displayed

#### Scenario: User scans an invalid QR Code

- **WHEN** user scans a QR Code that does not match the invoice format
- **THEN** the system SHALL display an error message indicating the QR Code is not a valid invoice

### Requirement: Winning number retrieval

The invoice checker SHALL fetch the latest winning invoice numbers from the Taiwan Ministry of Finance Electronic Invoice API. The system SHALL display the period covered by the winning numbers.

#### Scenario: User checks winning numbers online

- **WHEN** user has network connectivity
- **THEN** the system SHALL fetch and display the latest winning numbers

#### Scenario: Network unavailable

- **WHEN** user has no network connectivity
- **THEN** the system SHALL display previously cached winning numbers if available, or inform the user that network is required

### Requirement: Prize matching

The invoice checker SHALL compare the scanned invoice number against the winning numbers and determine if the invoice has won a prize. The system SHALL display the prize tier and amount.

#### Scenario: Invoice wins a prize

- **WHEN** the scanned invoice number matches a winning number
- **THEN** the system SHALL display the prize tier (特別獎/特獎/頭獎/etc.) and the prize amount

#### Scenario: Invoice does not win

- **WHEN** the scanned invoice number does not match any winning number
- **THEN** the system SHALL display a message indicating no prize

### Requirement: Manual invoice number input

The invoice checker SHALL allow users to manually input an invoice number as an alternative to scanning.

#### Scenario: User inputs invoice number manually

- **WHEN** user types a 10-character invoice number (2 letters + 8 digits)
- **THEN** the system SHALL validate the format and check against winning numbers
