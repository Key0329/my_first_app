import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:my_first_app/services/pro_service.dart';

/// IAP 購買狀態事件，供 PaywallScreen 訂閱。
enum IapEvent { loading, success, cancelled, error, restoreEmpty }

/// 輕量介面，讓 InAppPurchaseService 可在測試中注入 fake。
abstract class IapInterface {
  Stream<List<PurchaseDetails>> get purchaseStream;
  Future<bool> isAvailable();
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam});
  Future<void> completePurchase(PurchaseDetails purchase);
  Future<void> restorePurchases({String? applicationUserName});
  Future<ProductDetailsResponse> queryProductDetails(Set<String> identifiers);
}

/// 正式實作：包裝 InAppPurchase.instance。
class _RealIap implements IapInterface {
  final InAppPurchase _iap;
  _RealIap(this._iap);

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => _iap.purchaseStream;

  @override
  Future<bool> isAvailable() => _iap.isAvailable();

  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) =>
      _iap.buyNonConsumable(purchaseParam: purchaseParam);

  @override
  Future<void> completePurchase(PurchaseDetails purchase) =>
      _iap.completePurchase(purchase);

  @override
  Future<void> restorePurchases({String? applicationUserName}) =>
      _iap.restorePurchases(applicationUserName: applicationUserName);

  @override
  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> identifiers,
  ) => _iap.queryProductDetails(identifiers);
}

/// 管理應用內購買（StoreKit2 / Google Play Billing）。
///
/// 使用 Flutter 官方 `in_app_purchase` 套件，不依賴第三方服務。
/// 購買/回復購買成功後呼叫 [ProService.setPro(true)]。
class InAppPurchaseService {
  static const proProductId = 'com.spectra.toolbox.pro';

  final IapInterface _iap;
  final ProService _proService;

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  ProductDetails? _proProduct;
  bool _isAvailable = false;

  final StreamController<IapEvent> _eventController =
      StreamController.broadcast();

  Stream<IapEvent> get events => _eventController.stream;
  bool get isAvailable => _isAvailable;
  ProductDetails? get proProduct => _proProduct;

  InAppPurchaseService({
    IapInterface? iap,
    required ProService proService,
  }) : _iap = iap ?? _RealIap(InAppPurchase.instance),
       _proService = proService;

  /// 初始化 IAP：檢查可用性、載入商品資訊、監聽 purchaseStream。
  Future<void> init() async {
    _isAvailable = await _iap.isAvailable();
    if (!_isAvailable) return;

    // 訂閱購買流
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdates,
      onError: (Object error) {
        debugPrint('[IAP] purchaseStream error: $error');
      },
    );

    // 載入商品資訊
    final response = await _iap.queryProductDetails({proProductId});
    if (response.productDetails.isNotEmpty) {
      _proProduct = response.productDetails.first;
    }
  }

  /// 發起 Pro 一次性購買（NT$90）。
  Future<void> buyPro() async {
    if (!_isAvailable) return;
    final product = _proProduct;
    if (product == null) return;
    _eventController.add(IapEvent.loading);
    await _iap.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: product),
    );
  }

  bool _restorePending = false;

  /// 回復先前購買。
  ///
  /// 若 5 秒內無 restored 事件回傳，視為無購買紀錄，emit [IapEvent.restoreEmpty]。
  Future<void> restorePurchases() async {
    if (!_isAvailable) return;
    _restorePending = true;
    _eventController.add(IapEvent.loading);
    await _iap.restorePurchases();

    // 平台回傳無購買時不會有任何 purchaseStream 事件，需 timeout 處理
    Future.delayed(const Duration(seconds: 5), () {
      if (_restorePending) {
        _restorePending = false;
        _eventController.add(IapEvent.restoreEmpty);
      }
    });
  }

  // ── 購買狀態處理 ──────────────────────────────────────────────────────────

  void _onPurchaseUpdates(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.productID != proProductId) continue;
      _handlePurchase(purchase);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchase) async {
    switch (purchase.status) {
      case PurchaseStatus.purchased:
      case PurchaseStatus.restored:
        _restorePending = false;
        await _proService.setPro(true);
        await _iap.completePurchase(purchase);
        _eventController.add(IapEvent.success);

      case PurchaseStatus.pending:
        _eventController.add(IapEvent.loading);

      case PurchaseStatus.canceled:
        _eventController.add(IapEvent.cancelled);

      case PurchaseStatus.error:
        debugPrint('[IAP] purchase error: ${purchase.error}');
        _eventController.add(IapEvent.error);
    }
  }

  void dispose() {
    _subscription?.cancel();
    _eventController.close();
  }
}
