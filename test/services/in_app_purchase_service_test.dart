import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_first_app/services/pro_service.dart';
import 'package:my_first_app/services/in_app_purchase_service.dart';

// ── 簡易 Fake InAppPurchase（實作輕量 IapInterface）───────────────────────────

class _FakeInAppPurchase implements IapInterface {
  final StreamController<List<PurchaseDetails>> _controller =
      StreamController.broadcast();

  @override
  Stream<List<PurchaseDetails>> get purchaseStream => _controller.stream;
  bool restoreCalled = false;
  bool completeCalled = false;
  bool buyCalled = false;

  void emitPurchases(List<PurchaseDetails> purchases) {
    _controller.add(purchases);
  }

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> restorePurchases({String? applicationUserName}) async {
    restoreCalled = true;
  }

  @override
  Future<bool> buyNonConsumable({required PurchaseParam purchaseParam}) async {
    buyCalled = true;
    return true;
  }

  @override
  Future<void> completePurchase(PurchaseDetails purchase) async {
    completeCalled = true;
  }

  @override
  Future<ProductDetailsResponse> queryProductDetails(
    Set<String> identifiers,
  ) async {
    final products = identifiers
        .map(
          (id) => ProductDetails(
            id: id,
            title: 'Pro',
            description: 'Pro features',
            price: 'NT\$90',
            rawPrice: 90.0,
            currencyCode: 'TWD',
          ),
        )
        .toList();
    return ProductDetailsResponse(
      productDetails: products,
      notFoundIDs: [],
    );
  }

  void close() => _controller.close();
}

// ── 簡易 Fake PurchaseDetails ─────────────────────────────────────────────────

class _FakePurchaseDetails extends PurchaseDetails {
  _FakePurchaseDetails({required super.status, required super.productID})
    : super(purchaseID: 'test_purchase', verificationData: _fakeVerification, transactionDate: null);

  static final PurchaseVerificationData _fakeVerification =
      PurchaseVerificationData(
        localVerificationData: 'local',
        serverVerificationData: 'server',
        source: 'test',
      );
}

// ── Tests ────────────────────────────────────────────────────────────────────

void main() {
  late _FakeInAppPurchase fakeIap;
  late ProService proService;
  late InAppPurchaseService iapService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    fakeIap = _FakeInAppPurchase();
    proService = ProService();
    await proService.init();
    iapService = InAppPurchaseService(iap: fakeIap, proService: proService);
    await iapService.init();
  });

  tearDown(() {
    fakeIap.close();
    iapService.dispose();
  });

  group('InAppPurchaseService', () {
    test('購買成功（purchased）觸發 ProService.setPro(true)', () async {
      final purchase = _FakePurchaseDetails(
        status: PurchaseStatus.purchased,
        productID: InAppPurchaseService.proProductId,
      );

      fakeIap.emitPurchases([purchase]);
      await Future.delayed(Duration.zero); // 等 stream listener 處理

      expect(proService.isPro, isTrue);
    });

    test('購買 error 不觸發 setPro', () async {
      final purchase = _FakePurchaseDetails(
        status: PurchaseStatus.error,
        productID: InAppPurchaseService.proProductId,
      );

      fakeIap.emitPurchases([purchase]);
      await Future.delayed(Duration.zero);

      expect(proService.isPro, isFalse);
    });

    test('購買 pending 不觸發 setPro', () async {
      final purchase = _FakePurchaseDetails(
        status: PurchaseStatus.pending,
        productID: InAppPurchaseService.proProductId,
      );

      fakeIap.emitPurchases([purchase]);
      await Future.delayed(Duration.zero);

      expect(proService.isPro, isFalse);
    });

    test('restorePurchases() 呼叫 IAP restore', () async {
      await iapService.restorePurchases();
      expect(fakeIap.restoreCalled, isTrue);
    });

    test('已恢復購買（restored）觸發 ProService.setPro(true)', () async {
      final purchase = _FakePurchaseDetails(
        status: PurchaseStatus.restored,
        productID: InAppPurchaseService.proProductId,
      );

      fakeIap.emitPurchases([purchase]);
      await Future.delayed(Duration.zero);

      expect(proService.isPro, isTrue);
    });

    test('buyPro() 呼叫 IAP buyNonConsumable', () async {
      await iapService.buyPro();
      expect(fakeIap.buyCalled, isTrue);
    });
  });
}
