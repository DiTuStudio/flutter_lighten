import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/ad_service.dart';
import '../services/iap_service.dart';
import '../state/app_state.dart';
import '../theme.dart';

/// Màn giới thiệu & mua gói Pro (mua đứt 1 lần).
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  final IapService _iap = createIapService();
  bool _busy = false;
  String? _priceString;

  @override
  void initState() {
    super.initState();
    _iap.proPriceString().then((price) {
      if (mounted) setState(() => _priceString = price);
    });
  }

  List<(String, String)> _features(AppLocalizations l10n) => [
    (l10n.proFeature1Title, l10n.proFeature1Body),
    (l10n.proFeature2Title, l10n.proFeature2Body),
    (l10n.proFeature3Title, l10n.proFeature3Body),
    (l10n.proFeature4Title, l10n.proFeature4Body),
  ];

  Future<void> _watchAdForTempPro() async {
    final l10n = AppLocalizations.of(context);
    final state = context.read<AppState>();
    final messenger = ScaffoldMessenger.of(context);
    final shown = await AdService.instance.showRewarded(
      onReward: () => state.grantTempPro(const Duration(hours: 24)),
    );
    if (!shown) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.adNotReady)));
    }
  }

  Future<void> _buy() async {
    final l10n = AppLocalizations.of(context);
    // setState(() => _busy = true);
    // final ok = await _iap.buyPro();
    // if (!mounted) return;
    // if (ok) {
    await context.read<AppState>().saveSettings(
      context.read<AppState>().settings.copyWith(isPro: true),
    );
    //   if (mounted) {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.welcomeToPro)));
    // }
    // } else {
    //   setState(() => _busy = false);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(l10n.purchaseFailed)),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.paywallTitle)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.paywallHeadline,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.paywallSubheadline,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          ..._features(l10n).map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          f.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          f.$2,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _busy ? null : _buy,
            child: _busy
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    _priceString != null
                        ? l10n.upgradeProWithPrice(_priceString!)
                        : l10n.upgradeProGeneric,
                  ),
          ),
          if (AdService.adsEnabled) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    l10n.or,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _busy ? null : _watchAdForTempPro,
              icon: const Icon(Icons.play_circle_outline),
              label: Text(l10n.watchAdTempPro),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: _busy
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final ok = await _iap.restore();
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            ok ? l10n.restoredPro : l10n.noPreviousPurchase,
                          ),
                        ),
                      );
                    },
              child: Text(l10n.restorePurchase),
            ),
          ),
        ],
      ),
    );
  }
}
