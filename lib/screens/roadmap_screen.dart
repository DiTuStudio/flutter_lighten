import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../engine/payoff_engine.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/enums.dart';
import '../services/pdf_report_service.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/debt_progress_chart.dart';
import 'paywall_screen.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final result = state.strategyResult;
    final minOnly = state.minimumOnlyResult;
    final names = {for (final d in state.debts) d.id!: d.name};

    final saved = minOnly.payoffReached
        ? (minOnly.totalInterest - result.totalInterest).clamp(0, double.infinity)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.roadmapTitle),
        actions: [
          IconButton(
            icon: Icon(state.hasProAccess ? Icons.picture_as_pdf_outlined : Icons.lock_outline),
            tooltip: l10n.proFeature3Title,
            onPressed: () => _exportPdf(context, l10n, state, result),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.tune, size: 18),
            label: Text(l10n.tryAnotherScenario),
          ),
        ],
      ),
      body: !result.payoffReached
          ? _notReachable(l10n)
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                _overview(l10n, state, result, saved),
                const SizedBox(height: 20),
                _progressChartOrTeaser(context, l10n, state, result),
                const SizedBox(height: 20),
                Text(l10n.monthlyRoadmapTitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                ...result.months.map((m) => _MonthTile(
                    month: m, names: names, l10n: l10n, currency: state.currency)),
              ],
            ),
    );
  }

  Widget _progressChartOrTeaser(
      BuildContext context, AppLocalizations l10n, AppState state, PayoffResult result) {
    if (state.hasProAccess) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.proFeature2Title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              DebtProgressChart(months: result.months, currency: state.currency),
            ],
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lock_outline, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(l10n.proFeature2Title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 4),
            Text(l10n.proFeature2Body,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PaywallScreen())),
              child: Text(l10n.proLockedCta),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportPdf(BuildContext context, AppLocalizations l10n, AppState state,
      PayoffResult result) async {
    if (!state.hasProAccess) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
      return;
    }
    await PdfReportService.exportRoadmap(
      l10n: l10n,
      currency: state.currency,
      strategy: state.settings.strategy ?? Strategy.avalanche,
      result: result,
    );
  }

  Widget _notReachable(AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          l10n.roadmapNotReachable,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
        ),
      ),
    );
  }

  Widget _overview(
      AppLocalizations l10n, AppState state, PayoffResult result, num? saved) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.strategyLabelLine(state.settings.strategy?.label ?? ''),
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 8),
            if (result.payoffDate != null)
              Text(l10n.debtFreeBy(formatMonthYear(result.payoffDate!)),
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary)),
            const SizedBox(height: 4),
            Text(l10n.afterMonths('${result.monthsToPayoff}'),
                style: const TextStyle(color: AppColors.textSecondary)),
            const Divider(height: 28),
            _stat(l10n.totalInterestLabel,
                formatMoney(result.totalInterest, state.currency)),
            if (saved != null && saved > 0)
              _stat(l10n.totalSavedLabel, formatMoney(saved, state.currency),
                  color: AppColors.success),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color ?? AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _MonthTile extends StatelessWidget {
  final MonthSnapshot month;
  final Map<int, String> names;
  final AppLocalizations l10n;
  final CurrencyInfo currency;
  const _MonthTile(
      {required this.month,
      required this.names,
      required this.l10n,
      required this.currency});

  @override
  Widget build(BuildContext context) {
    final focusedName =
        month.focusedDebtId != null ? names[month.focusedDebtId] : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(formatMonthYear(month.month),
            style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: focusedName != null
            ? Text(l10n.focusedDebtLine(focusedName),
                style: const TextStyle(fontSize: 12))
            : null,
        trailing: Text(
          formatMoneyShort(month.totalRemaining, currency),
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppColors.primary),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: [
          for (final d in month.debts)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      names[d.debtId] ?? l10n.debtFallbackName,
                      style: TextStyle(
                        fontSize: 13,
                        color: d.debtId == month.focusedDebtId
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        fontWeight: d.debtId == month.focusedDebtId
                            ? FontWeight.w700
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  Text(l10n.remainingAmount(formatMoneyShort(d.balance, currency)),
                      style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
