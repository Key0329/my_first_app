## ADDED Requirements

### Requirement: Currency conversion with live rates

The tool SHALL fetch live exchange rates from the `frankfurter.app` API and allow users to convert between currencies. The user SHALL be able to select a source currency and a target currency from a list of supported currencies, enter an amount, and see the converted result in real-time. The conversion result SHALL update automatically when the amount or selected currencies change.

#### Scenario: User converts currency

- **WHEN** user selects USD as source currency, EUR as target currency, and enters 100 as the amount
- **THEN** the tool SHALL display the converted amount in EUR based on the latest exchange rate from the API

#### Scenario: Exchange rates are fetched on tool open

- **WHEN** user opens the currency converter tool
- **THEN** the tool SHALL fetch the latest exchange rates from the `frankfurter.app` API and display the last updated timestamp

### Requirement: Offline cache for exchange rates

The tool SHALL cache the most recently fetched exchange rates and their timestamp using `shared_preferences`. When the device has no network connectivity, the tool SHALL use the cached rates and display an "offline mode" indicator showing the cache age.

#### Scenario: Network unavailable with cached data

- **WHEN** user opens the currency converter tool without network connectivity and cached rates exist
- **THEN** the tool SHALL display the cached exchange rates and show an "offline mode" indicator with the timestamp of the cached data

#### Scenario: Network unavailable without cached data

- **WHEN** user opens the currency converter tool without network connectivity and no cached rates exist
- **THEN** the tool SHALL display an error message indicating that network connectivity is required for the first use

### Requirement: Currency swap

The tool SHALL provide a swap button that exchanges the source and target currencies. When tapped, the source currency SHALL become the target currency and vice versa, and the conversion result SHALL update immediately.

#### Scenario: User swaps currencies

- **WHEN** user has USD as source and EUR as target, then taps the swap button
- **THEN** EUR SHALL become the source currency and USD SHALL become the target currency, and the converted amount SHALL update accordingly
