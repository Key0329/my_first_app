import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/services/in_app_purchase_service.dart';
import 'package:my_first_app/theme/design_tokens.dart';

/// Pro 升級付費牆頁面。
///
/// 顯示品牌漸層 header、三項 Pro 功能對比、NT$90 定價，
/// 提供「立即升級」及「回復購買」流程。
///
/// 使用方式（開啟 modal）：
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   builder: (_) => const PaywallScreen(),
/// );
/// ```
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  bool _isLoading = false;
  StreamSubscription<IapEvent>? _eventSub;

  // ── 功能列表 ──────────────────────────────────────────────────────────────

  static const _features = [
    (Icons.block, '去除廣告', '完全無廣告的清爽體驗'),
    (Icons.palette_outlined, '自訂主題色', '六種品牌色任意切換'),
    (Icons.widgets_outlined, '主螢幕 Widget', '計算機 & 匯率一鍵直達'),
  ];

  @override
  void initState() {
    super.initState();
    _eventSub = context.read<InAppPurchaseService>().events.listen(_onIapEvent);
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    super.dispose();
  }

  void _onIapEvent(IapEvent event) {
    if (!mounted) return;
    switch (event) {
      case IapEvent.success:
        Navigator.of(context).pop();
      case IapEvent.cancelled:
        setState(() => _isLoading = false);
      case IapEvent.error:
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('購買失敗，請稍後再試')),
        );
      case IapEvent.restoreEmpty:
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('找不到先前的購買紀錄')),
        );
      case IapEvent.loading:
        setState(() => _isLoading = true);
    }
  }

  // ── 購買 / 回復 ───────────────────────────────────────────────────────────

  Future<void> _handleUpgrade(BuildContext ctx) async {
    final iap = ctx.read<InAppPurchaseService>();
    setState(() => _isLoading = true);
    await iap.buyPro();
  }

  Future<void> _handleRestore(BuildContext ctx) async {
    final iap = ctx.read<InAppPurchaseService>();
    setState(() => _isLoading = true);
    await iap.restorePurchases();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DT.spaceLg,
              vertical: DT.spaceMd,
            ),
            child: Column(
              children: [
                _buildPriceLabel(b),
                const SizedBox(height: DT.spaceMd),
                _buildFeatureList(b),
                const SizedBox(height: DT.spaceLg),
                _buildUpgradeButton(context),
                const SizedBox(height: DT.spaceSm),
                _buildRestoreButton(context, b),
                const SizedBox(height: DT.spaceSm),
                _buildFooterNote(b),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: DT.spaceLg,
        vertical: DT.space2xl,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [DT.brandPrimary, DT.brandPrimaryLight],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(DT.radiusLg)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(DT.spaceMd),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.workspace_premium, color: Colors.white, size: 36),
          ),
          const SizedBox(height: DT.spaceMd),
          const Text(
            '升級至 Pro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: DT.spaceXs),
          Text(
            '一次買斷，永久使用',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceLabel(Brightness b) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'NT\$',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: DT.brandPrimary,
          ),
        ),
        const Text(
          '90',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: DT.brandPrimary,
          ),
        ),
        const SizedBox(width: DT.spaceXs),
        Text(
          '一次買斷',
          style: TextStyle(fontSize: 14, color: DT.subtitle(b)),
        ),
      ],
    );
  }

  Widget _buildFeatureList(Brightness b) {
    return Column(
      key: const Key('paywall_feature_list'),
      children: _features.map((f) {
        final (icon, title, desc) = f;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: DT.spaceSm),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(DT.spaceSm),
                decoration: BoxDecoration(
                  color: DT.brandPrimaryBgLight,
                  borderRadius: BorderRadius.circular(DT.radiusSm),
                ),
                child: Icon(icon, color: DT.brandPrimary, size: 20),
              ),
              const SizedBox(width: DT.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: b == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 13,
                        color: DT.subtitle(b),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.check_circle, color: DT.brandPrimary, size: 20),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpgradeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: DT.toolButtonHeight,
      child: FilledButton(
        key: const Key('paywall_upgrade_button'),
        onPressed: _isLoading ? null : () => _handleUpgrade(context),
        style: FilledButton.styleFrom(
          backgroundColor: DT.brandPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DT.toolButtonRadius),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                '立即升級 NT\$90',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildRestoreButton(BuildContext context, Brightness b) {
    return TextButton(
      key: const Key('paywall_restore_button'),
      onPressed: _isLoading ? null : () => _handleRestore(context),
      child: Text(
        '回復購買',
        style: TextStyle(color: DT.subtitle(b), fontSize: 14),
      ),
    );
  }

  Widget _buildFooterNote(Brightness b) {
    return Text(
      '購買後所有功能永久解鎖，無需訂閱',
      style: TextStyle(fontSize: 11, color: DT.subtitle(b)),
      textAlign: TextAlign.center,
    );
  }
}
