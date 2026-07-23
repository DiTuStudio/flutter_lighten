import 'enums.dart';

/// Cấu hình app, lưu 1 dòng duy nhất trong DB (id = 1).
class AppSettings {
  final Strategy? strategy; // null nếu chưa thiết lập chiến lược
  final double extraPerMonth; // số tiền dư trả thêm mỗi tháng (VND)
  final bool reminderEnabled;
  final int reminderHour; // 0–23
  final int reminderMinute; // 0–59
  final bool isPro; // Pro mua đứt (vĩnh viễn)

  /// Mốc hết hạn Pro tạm thời (đổi bằng rewarded video), ms từ epoch. 0 = không có.
  final int proTempUntilEpoch;

  /// Mã ngôn ngữ do user chọn (VD "en", "vi"). Null = theo ngôn ngữ hệ thống.
  final String? languageCode;

  /// Mã tiền tệ ISO 4217 do user chọn (VD "VND", "USD"). Null = tự suy ra
  /// từ [languageCode] (xem `defaultCurrencyForLanguage` trong utils/format.dart).
  final String? currencyCode;

  const AppSettings({
    this.strategy,
    this.extraPerMonth = 0,
    this.reminderEnabled = false,
    this.reminderHour = 9,
    this.reminderMinute = 0,
    this.isPro = false,
    this.proTempUntilEpoch = 0,
    this.languageCode,
    this.currencyCode,
  });

  bool get hasStrategy => strategy != null;

  AppSettings copyWith({
    Strategy? strategy,
    bool clearStrategy = false,
    double? extraPerMonth,
    bool? reminderEnabled,
    int? reminderHour,
    int? reminderMinute,
    bool? isPro,
    int? proTempUntilEpoch,
    String? languageCode,
    bool clearLanguageCode = false,
    String? currencyCode,
    bool clearCurrencyCode = false,
  }) {
    return AppSettings(
      strategy: clearStrategy ? null : (strategy ?? this.strategy),
      extraPerMonth: extraPerMonth ?? this.extraPerMonth,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      isPro: isPro ?? this.isPro,
      proTempUntilEpoch: proTempUntilEpoch ?? this.proTempUntilEpoch,
      languageCode:
          clearLanguageCode ? null : (languageCode ?? this.languageCode),
      currencyCode:
          clearCurrencyCode ? null : (currencyCode ?? this.currencyCode),
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': 1,
      'strategy': strategy?.name,
      'extra_per_month': extraPerMonth,
      'reminder_enabled': reminderEnabled ? 1 : 0,
      'reminder_hour': reminderHour,
      'reminder_minute': reminderMinute,
      'is_pro': isPro ? 1 : 0,
      'pro_temp_until': proTempUntilEpoch,
      'language_code': languageCode,
      'currency_code': currencyCode,
    };
  }

  factory AppSettings.fromMap(Map<String, Object?> map) {
    return AppSettings(
      strategy:
          map['strategy'] == null ? null : Strategy.fromName(map['strategy'] as String),
      extraPerMonth: (map['extra_per_month'] as num?)?.toDouble() ?? 0,
      reminderEnabled: (map['reminder_enabled'] as num?)?.toInt() == 1,
      reminderHour: (map['reminder_hour'] as num?)?.toInt() ?? 9,
      reminderMinute: (map['reminder_minute'] as num?)?.toInt() ?? 0,
      isPro: (map['is_pro'] as num?)?.toInt() == 1,
      proTempUntilEpoch: (map['pro_temp_until'] as num?)?.toInt() ?? 0,
      languageCode: map['language_code'] as String?,
      currencyCode: map['currency_code'] as String?,
    );
  }
}
