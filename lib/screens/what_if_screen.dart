import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/thousands_formatter.dart';

/// So sánh nhiều kịch bản "trả thêm bao nhiêu mỗi tháng" cạnh nhau (Pro).
/// Mỗi kịch bản dùng cùng 1 chiến lược (đã chọn ở màn Chiến lược), chỉ khác
/// số tiền trả thêm — để user thấy ngay đánh đổi giữa các mức tiền.
class WhatIfScreen extends StatefulWidget {
  const WhatIfScreen({super.key});

  @override
  State<WhatIfScreen> createState() => _WhatIfScreenState();
}

class _WhatIfScreenState extends State<WhatIfScreen> {
  late final Strategy _strategy;
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    final appState = context.read<AppState>();
    _strategy = appState.settings.strategy ?? Strategy.avalanche;
    final currency = appState.currency;
    final base = appState.settings.extraPerMonth;
    final seeds = base > 0 ? [base, base * 1.5, base * 2] : [0.0, 500000.0, 1000000.0];
    for (final s in seeds) {
      _controllers
          .add(TextEditingController(text: s > 0 ? formatNumber(s, currency) : ''));
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addScenario() => setState(() => _controllers.add(TextEditingController()));

  void _removeScenario(int index) => setState(() {
        _controllers[index].dispose();
        _controllers.removeAt(index);
      });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final currency = state.currency;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.proFeature1Title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (int i = 0; i < _controllers.length; i++)
            _scenarioCard(l10n, state, currency, i),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _addScenario,
            icon: const Icon(Icons.add),
            label: Text(l10n.whatIfAddScenario),
          ),
        ],
      ),
    );
  }

  Widget _scenarioCard(
      AppLocalizations l10n, AppState state, CurrencyInfo currency, int index) {
    final extra = parseMoneyInput(_controllers[index].text) ?? 0;
    final result = state.simulateWith(strategy: _strategy, extraPerMonth: extra);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    inputFormatters: [ThousandsFormatter(currency)],
                    decoration: InputDecoration(
                      labelText: l10n.whatIfExtraFieldLabel,
                      prefixText: currency.inputPrefix,
                      suffixText: currency.inputSuffix,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                if (_controllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.close),
                    color: AppColors.textSecondary,
                    onPressed: () => _removeScenario(index),
                  ),
              ],
            ),
            const Divider(height: 24),
            if (result.payoffDate != null) ...[
              _statRow(l10n.whatIfColumnPayoffDate, formatMonthYear(result.payoffDate!)),
              _statRow(l10n.whatIfColumnMonths, '${result.monthsToPayoff}'),
              _statRow(
                  l10n.whatIfColumnInterest, formatMoney(result.totalInterest, currency)),
            ] else
              Text(l10n.notPayableWithin50Years,
                  style: const TextStyle(color: AppColors.danger)),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textSecondary)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      );
}
