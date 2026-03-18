## ADDED Requirements

### Requirement: Unit conversion categories

The unit converter SHALL support the following categories: length, weight, area, and temperature. Each category SHALL provide a dropdown to select source and target units.

#### Scenario: User converts length

- **WHEN** user selects "公尺" as source, "公分" as target, and inputs "1"
- **THEN** the result SHALL display "100"

### Requirement: Taiwan-specific units

The unit converter SHALL include Taiwan-specific units:
- Area: 坪 ↔ 平方公尺 (1 坪 = 3.305785 m²)
- Weight: 台斤 ↔ 公斤 (1 台斤 = 0.6 kg)
- Date: 民國年 ↔ 西元年 (民國年 + 1911 = 西元年)

#### Scenario: User converts ping to square meters

- **WHEN** user selects "坪" as source, "平方公尺" as target, and inputs "10"
- **THEN** the result SHALL display "33.05785"

#### Scenario: User converts ROC year to CE year

- **WHEN** user selects "民國年" as source, "西元年" as target, and inputs "113"
- **THEN** the result SHALL display "2024"

### Requirement: Real-time conversion

The converter SHALL update the result in real-time as the user types the input value. No submit button SHALL be required.

#### Scenario: User types input value

- **WHEN** user types each digit of the input
- **THEN** the converted result SHALL update immediately after each keystroke
