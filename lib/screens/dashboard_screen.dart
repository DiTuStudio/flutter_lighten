import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/debt.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/enum_labels.dart';
import '../utils/format.dart';
import '../widgets/banner_ad_widget.dart';
import 'debt_detail_screen.dart';
import 'edit_debt_screen.dart';
import 'settings_screen.dart';
import 'strategy_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lighten',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : state.hasDebts
          ? _DebtDashboard(state: state)
          : const _EmptyState(),
      floatingActionButton: state.hasDebts
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              onPressed: () => _openAddDebt(context),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: state.hasProAccess
          ? null
          : const SafeArea(child: BannerAdWidget()),
    );
  }

  static void _openAddDebt(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditDebtScreen()),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.savings_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context).emptyStateTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).emptyStateBody,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: () => DashboardScreen._openAddDebt(context),
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context).addFirstDebt),
            ),
          ],
        ),
      ),
    );
  }
}

class _DebtDashboard extends StatelessWidget {
  final AppState state;
  const _DebtDashboard({required this.state});

  @override
  Widget build(BuildContext context) {
    final minOnly = state.minimumOnlyResult;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      children: [
        _totalCard(context, minOnly),
        const SizedBox(height: 16),
        if (!state.settings.hasStrategy) _strategyCta(context),
        if (!state.settings.hasStrategy) const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context).debtsListTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        ...state.debts.map(
          (d) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _DebtCard(debt: d, state: state),
          ),
        ),
      ],
    );
  }

  Widget _totalCard(BuildContext context, minOnly) {
    final l10n = AppLocalizations.of(context);
    final payoffDate = minOnly.payoffDate;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.totalBalanceLabel,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            Text(
              formatMoney(state.totalBalance, state.currency),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      payoffDate != null
                          ? l10n.minOnlyInfo(
                              formatMonthYear(payoffDate),
                              formatMoney(
                                minOnly.totalInterest,
                                state.currency,
                              ),
                            )
                          : l10n.minOnlyNeverInfo,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _strategyCta(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StrategyScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.route_outlined, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                AppLocalizations.of(context).setupStrategyCta,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _DebtCard extends StatelessWidget {
  final Debt debt;
  final AppState state;
  const _DebtCard({required this.debt, required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isTrap = state.isMinimumTrap(debt);
    final paid = (debt.originalPrincipal - debt.balance).clamp(
      0,
      double.infinity,
    );
    final progress = debt.originalPrincipal > 0
        ? (paid / debt.originalPrincipal).clamp(0.0, 1.0)
        : 0.0;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DebtDetailScreen(debtId: debt.id!)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      debt.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    l10n.ratePerYear(_trimRate(debt.annualRate)),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                debt.type.label(context),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                formatMoney(debt.balance, state.currency),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: AppColors.bg,
                  valueColor: const AlwaysStoppedAnimation(AppColors.success),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.paidPercentOfPrincipal(
                  (progress * 100).toStringAsFixed(0),
                ),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              if (isTrap) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.danger,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.minimumTrapWarning,
                          style: const TextStyle(
                            color: AppColors.danger,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _trimRate(double r) =>
      r == r.roundToDouble() ? r.toStringAsFixed(0) : r.toString();
}
