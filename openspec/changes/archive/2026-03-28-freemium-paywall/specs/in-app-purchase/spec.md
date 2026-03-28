## ADDED Requirements

### Requirement: In-app purchase initialization

The `InAppPurchaseService` SHALL initialize the `in_app_purchase` plugin during app startup. The product ID for the Pro SKU SHALL be `com.spectra.toolbox.pro`. The service SHALL listen to the `InAppPurchase.instance.purchaseStream` for all purchase state changes throughout the app lifecycle.

#### Scenario: App startup with billing available

- **WHEN** the app starts and the billing service is available
- **THEN** `InAppPurchaseService` SHALL load the product details for `com.spectra.toolbox.pro` and cache them for display in PaywallScreen

#### Scenario: App startup with billing unavailable

- **WHEN** the billing service is not available (no Play Store / App Store account, restricted device)
- **THEN** `InAppPurchaseService.isAvailable` SHALL return `false` and PaywallScreen SHALL display an error message

### Requirement: Purchase flow

`InAppPurchaseService.buyPro()` SHALL initiate a non-consumable (iOS) / one-time (Android) purchase for `com.spectra.toolbox.pro`. Upon receiving `PurchaseStatus.purchased` from the purchase stream, the service SHALL call `ProService.setPro(true)`. The purchase transaction SHALL be completed via `InAppPurchase.instance.completePurchase()` after verification.

#### Scenario: Successful iOS purchase

- **WHEN** StoreKit2 returns `PurchaseStatus.purchased`
- **THEN** `InAppPurchaseService` SHALL verify the receipt locally, call `ProService.setPro(true)`, and complete the transaction

#### Scenario: Successful Android purchase

- **WHEN** Google Play Billing returns `PurchaseStatus.purchased`
- **THEN** `InAppPurchaseService` SHALL call `ProService.setPro(true)` and acknowledge the purchase via `completePurchase()`

#### Scenario: Purchase error

- **WHEN** `PurchaseStatus.error` is received
- **THEN** the service SHALL NOT call `ProService.setPro(true)` and SHALL emit an error event for PaywallScreen to display

### Requirement: Restore purchases

`InAppPurchaseService.restorePurchases()` SHALL call `InAppPurchase.instance.restorePurchases()`. If any restored purchase has product ID `com.spectra.toolbox.pro`, the service SHALL call `ProService.setPro(true)`.

#### Scenario: Restore with prior purchase

- **WHEN** `restorePurchases()` is called and platform returns a prior purchase for the Pro SKU
- **THEN** `ProService.setPro(true)` SHALL be called

#### Scenario: Restore with no prior purchase

- **WHEN** `restorePurchases()` is called and no prior purchase exists
- **THEN** the service SHALL emit a "no purchases to restore" signal without modifying `ProService`
