# enhance-currency-converter Specification

## Purpose

TBD - created by archiving change 'enhance-currency-converter'. Update Purpose after archive.

## Requirements

### Requirement: Favorite currencies pinned at top

The currency selector SHALL display favorite currencies (TWD, USD, JPY, EUR) at the top of the list, separated from the remaining currencies by a visual divider. The remaining currencies SHALL be sorted alphabetically. Only currencies present in the loaded rates data SHALL appear.

#### Scenario: Currency selector shows favorites first

- **WHEN** user opens the currency selector dropdown
- **THEN** TWD, USD, JPY, EUR SHALL appear at the top (if available in rates)
- **AND** a divider SHALL separate them from the remaining alphabetically sorted currencies


<!-- @trace
source: enhance-currency-converter
updated: 2026-03-23
code:
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_en.arb
  - lib/tools/currency_converter/currency_api.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/l10n/app_zh.arb
-->

---
### Requirement: Multi-currency comparison mode

The tool SHALL provide a multi-currency mode that displays conversion results for multiple target currencies simultaneously. The user SHALL select one source currency and amount, and the results for all selected target currencies SHALL display in a scrollable list. The default target currencies SHALL be TWD, USD, JPY, EUR.

#### Scenario: User views multi-currency results

- **WHEN** user switches to multi-currency mode and enters 100 USD
- **THEN** conversion results for TWD, JPY, EUR (and any other selected targets) SHALL display simultaneously

#### Scenario: User adds or removes a target currency

- **WHEN** user taps a currency chip to add or remove it from the target list
- **THEN** the results list SHALL update immediately


<!-- @trace
source: enhance-currency-converter
updated: 2026-03-23
code:
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_en.arb
  - lib/tools/currency_converter/currency_api.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/l10n/app_zh.arb
-->

---
### Requirement: API request timeout

The HTTP request to fetch exchange rates SHALL have a timeout of 10 seconds. If the request exceeds this timeout, the tool SHALL display an error message and allow the user to retry.

#### Scenario: API request times out

- **WHEN** the exchange rate API does not respond within 10 seconds
- **THEN** a timeout error message SHALL display
- **AND** a retry button SHALL be available


<!-- @trace
source: enhance-currency-converter
updated: 2026-03-23
code:
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_en.arb
  - lib/tools/currency_converter/currency_api.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/l10n/app_zh.arb
-->

---
### Requirement: Cache expiry warning

When the cached exchange rate data is older than 24 hours, the tool SHALL display a visible warning indicating that rates may be outdated. The warning SHALL include a refresh button to fetch fresh rates.

#### Scenario: Cache is older than 24 hours

- **WHEN** the displayed rates are from cache older than 24 hours
- **THEN** an amber warning indicator SHALL appear stating the rates are outdated
- **AND** a refresh button SHALL be provided

<!-- @trace
source: enhance-currency-converter
updated: 2026-03-23
code:
  - lib/l10n/app_localizations_zh.dart
  - lib/l10n/app_localizations_en.dart
  - lib/l10n/app_localizations.dart
  - lib/l10n/app_en.arb
  - lib/tools/currency_converter/currency_api.dart
  - lib/tools/currency_converter/currency_converter_page.dart
  - lib/l10n/app_zh.arb
-->