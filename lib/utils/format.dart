import 'package:intl/intl.dart';

/// Định dạng ngày tháng (luôn dạng số, không phụ thuộc ngôn ngữ hiển thị) &
/// tiền tệ (do user tự chọn ở Settings, độc lập với ngôn ngữ UI).

final DateFormat _monthYear = DateFormat('MM/yyyy', 'en');
final DateFormat _fullDate = DateFormat('dd/MM/yyyy', 'en');

/// "07/2026"
String formatMonthYear(DateTime date) => _monthYear.format(date);

/// "20/07/2026"
String formatDate(DateTime date) => _fullDate.format(date);

/// Mô tả cách hiển thị 1 đơn vị tiền tệ: ký hiệu, vị trí, dấu phân cách hàng nghìn.
/// Số tiền trong app luôn là số nguyên (không có phần thập phân) ở mọi tiền tệ —
/// giữ đơn giản cho một app nhập liệu tay, không phải app ngân hàng.
class CurrencyInfo {
  final String code; // ISO 4217, VD "VND"
  final String symbol;
  final bool symbolBefore;
  final bool spaced; // có khoảng trắng giữa ký hiệu và số không
  final String groupingSeparator; // '.' hoặc ','

  const CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.symbolBefore,
    required this.spaced,
    required this.groupingSeparator,
  });

  /// Dùng làm `prefixText`/`suffixText` cho ô nhập liệu tiền — chỉ 1 trong 2
  /// khác null tùy vị trí ký hiệu của tiền tệ.
  String? get inputPrefix => symbolBefore ? '$symbol${spaced ? ' ' : ''}' : null;
  String? get inputSuffix => symbolBefore ? null : '${spaced ? ' ' : ''}$symbol';
}

const kSupportedCurrencies = <String, CurrencyInfo>{
  'VND': CurrencyInfo(
      code: 'VND',
      symbol: 'đ',
      symbolBefore: false,
      spaced: true,
      groupingSeparator: '.'),
  'USD': CurrencyInfo(
      code: 'USD',
      symbol: '\$',
      symbolBefore: true,
      spaced: false,
      groupingSeparator: ','),
  'EUR': CurrencyInfo(
      code: 'EUR',
      symbol: '€',
      symbolBefore: false,
      spaced: true,
      groupingSeparator: '.'),
  'BRL': CurrencyInfo(
      code: 'BRL',
      symbol: 'R\$',
      symbolBefore: true,
      spaced: true,
      groupingSeparator: '.'),
  'IDR': CurrencyInfo(
      code: 'IDR',
      symbol: 'Rp',
      symbolBefore: true,
      spaced: true,
      groupingSeparator: '.'),
};

CurrencyInfo currencyInfo(String code) =>
    kSupportedCurrencies[code] ?? kSupportedCurrencies['USD']!;

/// Đơn vị tiền gợi ý mặc định theo ngôn ngữ UI — chỉ dùng khi user chưa tự
/// chọn tiền tệ nào trong Settings.
String defaultCurrencyForLanguage(String? languageCode) {
  switch (languageCode) {
    case 'vi':
      return 'VND';
    case 'es':
      return 'EUR';
    case 'pt':
      return 'BRL';
    case 'id':
      return 'IDR';
    default:
      return 'USD';
  }
}

String _groupDigits(int value, String separator) {
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(separator);
    buf.write(s[i]);
  }
  return buf.toString();
}

/// "1.500.000" / "1,500,000" (không ký hiệu) — dùng trong ô nhập liệu.
String formatNumber(num value, CurrencyInfo currency) =>
    _groupDigits(value.round().abs(), currency.groupingSeparator);

/// "1.500.000 đ" / "\$1,500,000" — có ký hiệu tiền tệ, dùng để hiển thị.
String formatMoney(num value, CurrencyInfo currency) {
  final sign = value < 0 ? '-' : '';
  final amount = '$sign${formatNumber(value, currency)}';
  final gap = currency.spaced ? ' ' : '';
  return currency.symbolBefore
      ? '${currency.symbol}$gap$amount'
      : '$amount$gap${currency.symbol}';
}

String _trimDecimal(double v) {
  final s = v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
  return s.replaceAll('.', ',');
}

/// Rút gọn số lớn để hiện trong danh sách/lộ trình.
/// VND giữ nguyên cách rút gọn quen thuộc ở VN ("1,5tr", "2 tỷ"); các tiền tệ
/// khác dùng chuẩn quốc tế K/M/B.
String formatMoneyShort(num value, CurrencyInfo currency) {
  final v = value.abs();
  if (currency.code == 'VND') {
    String body;
    if (v >= 1000000000) {
      body = '${_trimDecimal(value / 1000000000)} tỷ';
    } else if (v >= 1000000) {
      body = '${_trimDecimal(value / 1000000)}tr';
    } else if (v >= 1000) {
      body = '${(value / 1000).toStringAsFixed(0)}k';
    } else {
      return formatMoney(value, currency);
    }
    return '$body ${currency.symbol}'.replaceAll('  ', ' ');
  }

  String body;
  if (v >= 1000000000) {
    body = '${_trimDecimal(value / 1000000000)}B';
  } else if (v >= 1000000) {
    body = '${_trimDecimal(value / 1000000)}M';
  } else if (v >= 1000) {
    body = '${_trimDecimal(value / 1000)}K';
  } else {
    return formatMoney(value, currency);
  }
  final gap = currency.spaced ? ' ' : '';
  return currency.symbolBefore
      ? '${currency.symbol}$gap$body'
      : '$body$gap${currency.symbol}';
}

/// Parse chuỗi người dùng nhập (có thể chứa dấu chấm/phẩy phân cách) thành số tiền.
double? parseMoneyInput(String raw) {
  final cleaned = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (cleaned.isEmpty) return null;
  return double.tryParse(cleaned);
}

/// Parse chuỗi lãi suất "12,5" hoặc "12.5" → 12.5.
double? parsePercentInput(String raw) {
  final cleaned = raw.trim().replaceAll(',', '.').replaceAll(RegExp(r'[^0-9.]'), '');
  if (cleaned.isEmpty) return null;
  return double.tryParse(cleaned);
}
