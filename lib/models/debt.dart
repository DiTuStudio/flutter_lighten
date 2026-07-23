import 'enums.dart';

/// Một khoản nợ. Lãi suất luôn được lưu dưới dạng %/năm để tính toán nhất quán;
/// màn nhập liệu tự quy đổi khi người dùng chọn %/tháng.
class Debt {
  final int? id;
  final String name;
  final DebtType type;

  /// Dư nợ hiện tại (VND).
  final double balance;

  /// Gốc ban đầu — mốc để tính lãi cố định (`lãi_kỳ = originalPrincipal × lãi/tháng`).
  /// Với khoản lãi giảm dần, trường này không dùng trong tính toán nhưng vẫn lưu.
  final double originalPrincipal;

  /// Lãi suất %/năm.
  final double annualRate;
  final InterestType interestType;

  /// Trả tối thiểu mỗi tháng (VND).
  final double minimumPayment;

  /// Ngày đến hạn hàng tháng (1–31).
  final int dueDay;

  final DateTime? startDate;
  final String? note;
  final DateTime createdAt;

  const Debt({
    this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.originalPrincipal,
    required this.annualRate,
    required this.interestType,
    required this.minimumPayment,
    required this.dueDay,
    this.startDate,
    this.note,
    required this.createdAt,
  });

  /// Lãi suất theo tháng (dạng thập phân, ví dụ 0.015 = 1.5%/tháng).
  double get monthlyRateDecimal => annualRate / 100 / 12;

  Debt copyWith({
    int? id,
    String? name,
    DebtType? type,
    double? balance,
    double? originalPrincipal,
    double? annualRate,
    InterestType? interestType,
    double? minimumPayment,
    int? dueDay,
    DateTime? startDate,
    bool clearStartDate = false,
    String? note,
    bool clearNote = false,
    DateTime? createdAt,
  }) {
    return Debt(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      balance: balance ?? this.balance,
      originalPrincipal: originalPrincipal ?? this.originalPrincipal,
      annualRate: annualRate ?? this.annualRate,
      interestType: interestType ?? this.interestType,
      minimumPayment: minimumPayment ?? this.minimumPayment,
      dueDay: dueDay ?? this.dueDay,
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      note: clearNote ? null : (note ?? this.note),
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'balance': balance,
      'original_principal': originalPrincipal,
      'annual_rate': annualRate,
      'interest_type': interestType.name,
      'minimum_payment': minimumPayment,
      'due_day': dueDay,
      'start_date': startDate?.millisecondsSinceEpoch,
      'note': note,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Debt.fromMap(Map<String, Object?> map) {
    return Debt(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: DebtType.fromName(map['type'] as String),
      balance: (map['balance'] as num).toDouble(),
      originalPrincipal: (map['original_principal'] as num).toDouble(),
      annualRate: (map['annual_rate'] as num).toDouble(),
      interestType: InterestType.fromName(map['interest_type'] as String),
      minimumPayment: (map['minimum_payment'] as num).toDouble(),
      dueDay: (map['due_day'] as num).toInt(),
      startDate: map['start_date'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['start_date'] as int),
      note: map['note'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }
}
