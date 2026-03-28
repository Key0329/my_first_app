import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/config/ad_config.dart';
import 'package:my_first_app/services/pro_service.dart';

/// 底部 Banner 廣告 Widget。
///
/// - Pro 用戶：回傳零高度的 [SizedBox]，不載入廣告
/// - 免費用戶：載入並顯示 320×50 AdMob Banner
/// - 廣告載入失敗：自動 collapse 至零高度
///
/// 使用方式（於 [ImmersiveToolScaffold] 底部插入）：
/// ```dart
/// bottomNavigationBar: const BannerAdWidget(),
/// ```
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _ad;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    final isPro = context.read<ProService>().isPro;
    if (!isPro) _loadAd();
  }

  void _loadAd() {
    final ad = BannerAd(
      adUnitId: AdConfig.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          if (mounted) setState(() => _loaded = false);
        },
      ),
    );
    ad.load();
    _ad = ad;
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  void _disposeAd() {
    _ad?.dispose();
    _ad = null;
    _loaded = false;
  }

  @override
  Widget build(BuildContext context) {
    final isPro = context.watch<ProService>().isPro;

    if (isPro) {
      // 升級 Pro 後立即釋放已載入的廣告
      if (_ad != null) _disposeAd();
      return const SizedBox.shrink(key: Key('banner_ad_empty'));
    }

    if (!_loaded || _ad == null) {
      return const SizedBox.shrink(key: Key('banner_ad_empty'));
    }

    return SizedBox(
      key: const Key('banner_ad_container'),
      width: _ad!.size.width.toDouble(),
      height: _ad!.size.height.toDouble(),
      child: AdWidget(ad: _ad!),
    );
  }
}
