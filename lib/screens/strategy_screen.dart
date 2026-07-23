import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../engine/payoff_engine.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/thousands_formatter.dart';
import 'paywall_screen.dart';
import 'roadmap_screen.dart';
import 'what_if_screen.dart';

class StrategyScreen extends StatefulWidget {
  const StrategyScreen({super.key});

  @override
  State<StrategyScreen> createState() => _StrategyScreenState();
}

class _StrategyScreenState extends State<StrategyScreen> {
  late Strategy _strategy;
  late TextEditingController _extra;

  @override
  void initState() {
    super.initState();
    final appState = context.read<AppState>();
    final s = appState.settings;
    _strategy = s.strategy ?? Strategy.avalanche;
    _extra = TextEditingController(
        text: s.extraPerMonth > 0
            ? formatNumber(s.extraPerMonth, appState.currency)
            : '');
  }

  @override
  void dispose() {
    _extra.dispose();
    super.dispose();
  }

  double get _extraValue => parseMoneyInput(_extra.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final currency = state.currency;
    final preview = state.simulateWith(
        strategy: _strategy, extraPerMonth: _extraValue);
    final minOnly = state.minimumOnlyResult;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.chooseStrategyTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _StrategyCard(
            title: 'Snowball',
            subtitle: l10n.snowballSubtitle,
            icon: Icons.ac_unit,
            selected: _strategy == Strategy.snowball,
            onTap: () => setState(() => _strategy = Strategy.snowball),
          ),
          const SizedBox(height: 12),
          _StrategyCard(
            title: 'Avalanche',
            subtitle: l10n.avalancheSubtitle,
            icon: Icons.landscape,
            selected: _strategy == Strategy.avalanche,
            onTap: () => setState(() => _strategy = Strategy.avalanche),
          ),
          const SizedBox(height: 24),
          Text(l10n.extraPerMonthLabel,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(l10n.extraPerMonthHint,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 8),
          TextField(
            controller: _extra,
            keyboardType: TextInputType.number,
            inputFormatters: [ThousandsFormatter(currency)],
            decoration: InputDecoration(
                prefixText: currency.inputPrefix,
                suffixText: currency.inputSuffix),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 20),
          _previewCard(l10n, currency, preview, minOnly),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => state.hasProAccess
                    ? const WhatIfScreen()
                    : const PaywallScreen(),
              ),
            ),
            icon: Icon(state.hasProAccess ? Icons.compare_arrows : Icons.lock_outline),
            label: Text(l10n.proFeature1Title),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              await state.setStrategy(_strategy, _extraValue);
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const RoadmapScreen()),
                );
              }
            },
            child: Text(l10n.viewDetailedRoadmap),
          ),
        ],
      ),
    );
  }

  Widget _previewCard(AppLocalizations l10n, CurrencyInfo currency,
      PayoffResult preview, PayoffResult minOnly) {
    final payoff = preview.payoffDate;
    final savings = (minOnly.payoffReached ? minOnly.totalInterest : null);
    final saved = (savings != null)
        ? (savings - preview.totalInterest).clamp(0, double.infinity)
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (payoff != null) ...[
            Text(l10n.projectedPayoffDate(formatMonthYear(payoff)),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary)),
            const SizedBox(height: 6),
            Text(l10n.afterMonthsDot('${preview.monthsToPayoff}'),
                style: const TextStyle(color: AppColors.textSecondary)),
            if (saved != null && saved > 0) ...[
              const SizedBox(height: 6),
              Text(
                l10n.savedInterestVsMinimum(formatMoney(saved, currency)),
                style: const TextStyle(
                    color: AppColors.success, fontWeight: FontWeight.w600),
              ),
            ],
          ] else
            Text(
              l10n.notPayableWithin50Years,
              style: const TextStyle(color: AppColors.danger),
            ),
        ],
      ),
    );
  }
}

class _StrategyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _StrategyCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.black.withValues(alpha: 0.1),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: selected ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
