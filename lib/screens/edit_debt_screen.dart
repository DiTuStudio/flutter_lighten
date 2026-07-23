import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../engine/interest.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/debt.dart';
import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/enum_labels.dart';
import '../utils/format.dart';
import '../widgets/thousands_formatter.dart';

/// Màn Thêm/Sửa khoản nợ. Truyền [existing] để sửa; null để thêm mới.
class EditDebtScreen extends StatefulWidget {
  final Debt? existing;
  const EditDebtScreen({super.key, this.existing});

  @override
  State<EditDebtScreen> createState() => _EditDebtScreenState();
}

class _EditDebtScreenState extends State<EditDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _balance;
  late final TextEditingController _rate;
  late final TextEditingController _minimum;
  late final TextEditingController _note;

  DebtType _type = DebtType.creditCard;
  InterestType _interestType = InterestType.declining;
  bool _rateIsMonthly = false; // false = %/năm, true = %/tháng
  int _dueDay = 1;
  DateTime? _startDate;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    final currency = context.read<AppState>().currency;
    _name = TextEditingController(text: e?.name ?? '');
    _balance = TextEditingController(
        text: e != null ? formatNumber(e.balance, currency) : '');
    _rate = TextEditingController(text: e != null ? _trimRate(e.annualRate) : '');
    _minimum = TextEditingController(
        text: e != null ? formatNumber(e.minimumPayment, currency) : '');
    _note = TextEditingController(text: e?.note ?? '');
    if (e != null) {
      _type = e.type;
      _interestType = e.interestType;
      _dueDay = e.dueDay;
      _startDate = e.startDate;
    }
  }

  String _trimRate(double r) {
    return r == r.roundToDouble()
        ? r.toStringAsFixed(0)
        : r.toString().replaceAll('.', ',');
  }

  @override
  void dispose() {
    _name.dispose();
    _balance.dispose();
    _rate.dispose();
    _minimum.dispose();
    _note.dispose();
    super.dispose();
  }

  double get _annualRateFromInput {
    final r = parsePercentInput(_rate.text) ?? 0;
    return _rateIsMonthly ? monthlyToAnnual(r) : r;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final balance = parseMoneyInput(_balance.text)!;
    final minimum = parseMoneyInput(_minimum.text)!;
    final annualRate = _annualRateFromInput;

    // Nếu lãi cố định, cảnh báo lãi suất thực trước khi lưu.
    if (_interestType == InterestType.fixed && annualRate > 0) {
      final periods = minimum > 0 ? (balance / minimum).ceil() : 12;
      final effective = effectiveRateFromFixed(annualRate, periods);
      final proceed = await _showEffectiveRateDialog(annualRate, effective);
      if (proceed != true) return;
    }

    if (!mounted) return;
    final state = context.read<AppState>();
    final existing = widget.existing;
    if (existing == null) {
      final debt = Debt(
        name: _name.text.trim(),
        type: _type,
        balance: balance,
        originalPrincipal: balance, // gốc ban đầu = dư nợ lúc tạo
        annualRate: annualRate,
        interestType: _interestType,
        minimumPayment: minimum,
        dueDay: _dueDay,
        startDate: _startDate,
        note: _note.text.trim().isEmpty ? null : _note.text.trim(),
        createdAt: DateTime.now(),
      );
      await state.addDebt(debt);
    } else {
      final debt = existing.copyWith(
        name: _name.text.trim(),
        type: _type,
        balance: balance,
        annualRate: annualRate,
        interestType: _interestType,
        minimumPayment: minimum,
        dueDay: _dueDay,
        startDate: _startDate,
        clearStartDate: _startDate == null,
        note: _note.text.trim().isEmpty ? null : _note.text.trim(),
        clearNote: _note.text.trim().isEmpty,
      );
      await state.updateDebt(debt);
    }
    if (mounted) Navigator.of(context).pop();
  }

  Future<bool?> _showEffectiveRateDialog(double nominal, double effective) {
    final l10n = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.effectiveRateDialogTitle),
        content: Text(
          l10n.effectiveRateDialogBody(_trimRate(nominal),
              effective.toStringAsFixed(1).replaceAll('.', ',')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.reviewAgain),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.understoodSave),
          ),
        ],
      ),
    );
  }

  void _showInterestTypeHelp() {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.interestTypeHelpTitle),
        content: Text(l10n.interestTypeHelpBody),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.gotIt),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currency = context.watch<AppState>().currency;
    return Scaffold(
      appBar: AppBar(
          title:
              Text(_isEdit ? l10n.editDebtTitleEdit : l10n.editDebtTitleAdd)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _label(l10n.debtNameLabel),
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: l10n.debtNameHint,
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? l10n.debtNameRequired
                  : null,
            ),
            _label(l10n.debtTypeLabel),
            DropdownButtonFormField<DebtType>(
              initialValue: _type,
              items: DebtType.values
                  .map((t) => DropdownMenuItem(
                      value: t, child: Text(t.label(context))))
                  .toList(),
              onChanged: (v) => setState(() => _type = v ?? _type),
            ),
            _label(l10n.currentBalanceLabel),
            TextFormField(
              controller: _balance,
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsFormatter(currency)],
              decoration: InputDecoration(
                  prefixText: currency.inputPrefix,
                  suffixText: currency.inputSuffix),
              validator: (v) => _moneyValidator(v, l10n),
            ),
            _label(l10n.interestRateLabel),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _rate,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    decoration: const InputDecoration(suffixText: '%'),
                    validator: (v) {
                      final r = parsePercentInput(v ?? '');
                      if (r == null) return l10n.interestRateRequired;
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                _rateUnitToggle(l10n),
              ],
            ),
            _label(l10n.interestTypeLabel),
            Row(
              children: [
                Expanded(child: _interestTypeSelector()),
                IconButton(
                  onPressed: _showInterestTypeHelp,
                  icon: const Icon(Icons.help_outline),
                  color: AppColors.textSecondary,
                  tooltip: l10n.explainTooltip,
                ),
              ],
            ),
            _label(l10n.minPaymentLabel),
            TextFormField(
              controller: _minimum,
              keyboardType: TextInputType.number,
              inputFormatters: [ThousandsFormatter(currency)],
              decoration: InputDecoration(
                  prefixText: currency.inputPrefix,
                  suffixText: currency.inputSuffix),
              validator: (v) => _moneyValidator(v, l10n),
            ),
            _label(l10n.dueDayLabel),
            DropdownButtonFormField<int>(
              initialValue: _dueDay,
              items: List.generate(31, (i) => i + 1)
                  .map((d) => DropdownMenuItem(
                      value: d, child: Text(l10n.dueDayItem('$d'))))
                  .toList(),
              onChanged: (v) => setState(() => _dueDay = v ?? _dueDay),
            ),
            _label(l10n.startDateLabel),
            _startDatePicker(l10n),
            _label(l10n.noteOptionalLabel),
            TextFormField(
              controller: _note,
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              child: Text(_isEdit ? l10n.saveChanges : l10n.saveDebt),
            ),
          ],
        ),
      ),
    );
  }

  String? _moneyValidator(String? v, AppLocalizations l10n) {
    final n = parseMoneyInput(v ?? '');
    if (n == null || n <= 0) return l10n.amountRequired;
    return null;
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 6),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      );

  Widget _rateUnitToggle(AppLocalizations l10n) {
    return SegmentedButton<bool>(
      segments: [
        ButtonSegment(value: false, label: Text(l10n.perYear)),
        ButtonSegment(value: true, label: Text(l10n.perMonth)),
      ],
      selected: {_rateIsMonthly},
      onSelectionChanged: (s) => setState(() => _rateIsMonthly = s.first),
      showSelectedIcon: false,
    );
  }

  Widget _interestTypeSelector() {
    return RadioGroup<InterestType>(
      groupValue: _interestType,
      onChanged: (v) => setState(() => _interestType = v ?? _interestType),
      child: Column(
        children: InterestType.values.map((t) {
          return RadioListTile<InterestType>(
            contentPadding: EdgeInsets.zero,
            value: t,
            title: Text(t.label(context), style: const TextStyle(fontSize: 14)),
            dense: true,
          );
        }).toList(),
      ),
    );
  }

  Widget _startDatePicker(AppLocalizations l10n) {
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: _startDate ?? now,
          firstDate: DateTime(now.year - 20),
          lastDate: now,
        );
        if (picked != null) setState(() => _startDate = picked);
      },
      child: InputDecorator(
        decoration: const InputDecoration(),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 10),
            Text(
              _startDate == null ? l10n.selectDate : formatDate(_startDate!),
              style: TextStyle(
                color: _startDate == null
                    ? AppColors.textSecondary
                    : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (_startDate != null)
              GestureDetector(
                onTap: () => setState(() => _startDate = null),
                child: const Icon(Icons.close, size: 18),
              ),
          ],
        ),
      ),
    );
  }
}
