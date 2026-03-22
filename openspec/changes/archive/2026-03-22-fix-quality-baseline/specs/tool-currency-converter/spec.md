## MODIFIED Requirements

### Requirement: Currency conversion with live rates

The tool SHALL fetch live exchange rates from the `frankfurter.app` API and allow users to convert between currencies. The user SHALL be able to select a source currency and a target currency from a list of supported currencies, enter an amount, and see the converted result in real-time. The conversion result SHALL update automatically when the amount or selected currencies change. If a selected currency is not present in the fetched rates data, the tool SHALL throw an `ArgumentError` and display an error message to the user instead of silently producing incorrect results.

#### Scenario: User converts currency

- **WHEN** user selects USD as source currency, EUR as target currency, and enters 100 as the amount
- **THEN** the tool SHALL display the converted amount in EUR based on the latest exchange rate from the API

#### Scenario: Exchange rates are fetched on tool open

- **WHEN** user opens the currency converter tool
- **THEN** the tool SHALL fetch the latest exchange rates from the `frankfurter.app` API and display the last updated timestamp

#### Scenario: Unknown currency selected

- **WHEN** user selects a currency that is not present in the fetched rates data
- **THEN** the tool SHALL throw an `ArgumentError` and the UI SHALL display an error message indicating the currency is not supported
