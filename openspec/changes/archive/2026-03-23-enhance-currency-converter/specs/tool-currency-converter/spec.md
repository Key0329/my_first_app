## MODIFIED Requirements

### Requirement: Currency conversion with live rates

The tool SHALL fetch live exchange rates from the `frankfurter.app` API and allow users to convert between currencies. The user SHALL be able to select a source currency and a target currency from a list of supported currencies, enter an amount, and see the converted result in real-time. The conversion result SHALL update automatically when the amount or selected currencies change. If a selected currency is not present in the fetched rates data, the tool SHALL throw an `ArgumentError` and display an error message to the user instead of silently producing incorrect results. The HTTP request SHALL have a timeout of 10 seconds. The currency selector SHALL display favorite currencies (TWD, USD, JPY, EUR) at the top, separated by a divider from alphabetically sorted remaining currencies.

#### Scenario: User converts currency

- **WHEN** user selects USD as source currency, EUR as target currency, and enters 100 as the amount
- **THEN** the converted amount in EUR SHALL display based on the fetched exchange rate

#### Scenario: Currency selector shows favorites first

- **WHEN** user opens the currency selector
- **THEN** TWD, USD, JPY, EUR SHALL appear at the top with a divider below
