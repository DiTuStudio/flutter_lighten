/// Một lần thanh toán cho một khoản nợ.
class Payment {
  final int? id;
  final int debtId;
  final double amount;
  final DateTime date;
  final String? note;

  const Payment({
    this.id,
    required this.debtId,
    required this.amount,
    required this.date,
    this.note,
  });

  Payment copyWith({
    int? id,
    int? debtId,
    double? amount,
    DateTime? date,
    String? note,
  }) {
    return Payment(
      id: id ?? this.id,
      debtId: debtId ?? this.debtId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'debt_id': debtId,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'note': note,
    };
  }

  factory Payment.fromMap(Map<String, Object?> map) {
    return Payment(
      id: map['id'] as int?,
      debtId: (map['debt_id'] as num).toInt(),
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      note: map['note'] as String?,
    );
  }
}
