import 'package:flutter/services.dart';

import '../utils/format.dart';

/// Tự chèn dấu phân cách hàng nghìn (theo tiền tệ hiện dùng) khi user gõ số tiền.
class ThousandsFormatter extends TextInputFormatter {
  final CurrencyInfo currency;
  ThousandsFormatter(this.currency);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }
    final value = int.parse(digits);
    final formatted = formatNumber(value, currency);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
