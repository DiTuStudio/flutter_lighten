import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/debt.dart';
import '../models/payment.dart';
import '../services/ad_service.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/enum_labels.dart';
import '../utils/format.dart';
import '../widgets/thousands_formatter.dart';
import 'edit_debt_screen.dart';

class DebtDetailScreen extends StatelessWidget {
  final int debtId;
  const DebtDetailScreen({super.key, required this.debtId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    Debt? debt;
    for (final d in state.debts) {
      if (d.id == debtId) debt = d;
    }
    if (debt == null) {
      // Khoản đã bị xoá — quay lại.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Navigator.of(context).maybePop();
      });
      return const Scaffold(body: SizedBox.shrink());
    }
    final d = debt;

    return Scaffold(
      appBar: AppBar(
        title: Text(d.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => EditDebtScreen(existing: d))),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmDelete(context, state, d),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _summaryCard(context, state, d),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _markPaid(context, state, d),
            icon: const Icon(Icons.check_circle_outline),
            label: Text(l10n.markPaidThisMonth),
          ),
          const SizedBox(height: 24),
          Text(l10n.paymentHistoryTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _PaymentHistory(debtId: d.id!),
        ],
      ),
    );
  }

  Widget _summaryCard(BuildContext context, AppState state, Debt d) {
    final l10n = AppLocalizations.of(context);
    final currency = state.currency;
    final interest = state.monthlyInterestOf(d);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.currentDebtBalanceLabel,
                style: const TextStyle(color: AppColors.textSecondary)),
            Text(formatMoney(d.balance, currency),
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary)),
            const Divider(height: 28),
            _row(l10n.debtTypeLabel, d.type.label(context)),
            _row(l10n.interestRateLabel, l10n.ratePerYear(_trimRate(d.annualRate))),
            _row(l10n.interestTypeLabel, d.interestType.label(context)),
            _row(l10n.thisMonthInterestLabel, formatMoney(interest, currency)),
            _row(l10n.minPaymentLabel, formatMoney(d.minimumPayment, currency)),
            _row(l10n.dueDateLabel, l10n.dueDayValue('${d.dueDay}')),
            if (d.note != null && d.note!.isNotEmpty)
              _row(l10n.noteRowLabel, d.note!),
            if (state.isMinimumTrap(d)) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  l10n.minimumTrapDetailWarning(formatMoney(d.minimumPayment, currency),
                      formatMoney(interest, currency)),
                  style: const TextStyle(
                      color: AppColors.danger,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(label,
                style: const TextStyle(color: AppColors.textSecondary)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Future<void> _markPaid(BuildContext context, AppState state, Debt d) async {
    final l10n = AppLocalizations.of(context);
    final currency = state.currency;
    final amountCtrl =
        TextEditingController(text: formatNumber(d.minimumPayment, currency));
    DateTime date = DateTime.now();

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.recordPaymentTitle,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Text(l10n.amountPaidLabel),
                const SizedBox(height: 6),
                TextField(
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [ThousandsFormatter(currency)],
                  decoration: InputDecoration(
                      prefixText: currency.inputPrefix,
                      suffixText: currency.inputSuffix),
                ),
                const SizedBox(height: 16),
                Text(l10n.paymentDateLabel),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: ctx,
                      initialDate: date,
                      firstDate: DateTime(date.year - 5),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) setModalState(() => date = picked);
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 18),
                        const SizedBox(width: 10),
                        Text(formatDate(date)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: Text(l10n.save),
                ),
              ],
            ),
          );
        });
      },
    );

    if (result == true) {
      final amount = parseMoneyInput(amountCtrl.text) ?? 0;
      if (amount > 0) {
        await state.addPayment(Payment(
          debtId: d.id!,
          amount: amount,
          date: date,
        ));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.paymentRecorded)),
          );
          // Interstitial chỉ hiện sau hành động tích cực, và chỉ khi chưa Pro.
          if (!state.hasProAccess) {
            AdService.instance.showInterstitialIfReady();
          }
        }
      }
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, AppState state, Debt d) async {
    final l10n = AppLocalizations.of(context);
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteDebtTitle),
        content: Text(l10n.deleteDebtBody(d.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'paid_off'),
            child: Text(l10n.paidOff),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(ctx, 'mistake'),
            child: Text(l10n.deletedByMistake),
          ),
        ],
      ),
    );

    if (reason != null) {
      await state.deleteDebt(d.id!);
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  String _trimRate(double r) =>
      r == r.roundToDouble() ? r.toStringAsFixed(0) : r.toString();
}

class _PaymentHistory extends StatelessWidget {
  final int debtId;
  const _PaymentHistory({required this.debtId});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return FutureBuilder<List<Payment>>(
      future: state.paymentsOf(debtId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final payments = snapshot.data!;
        if (payments.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(AppLocalizations.of(context).noPaymentsYet,
                  style: const TextStyle(color: AppColors.textSecondary)),
            ),
          );
        }
        final currency = state.currency;
        return Card(
          child: Column(
            children: [
              for (int i = 0; i < payments.length; i++) ...[
                if (i > 0) const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: AppColors.success),
                  title: Text(formatMoney(payments[i].amount, currency)),
                  subtitle: Text(formatDate(payments[i].date)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
