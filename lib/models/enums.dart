// Các kiểu enum dùng chung cho toàn app.

/// Loại khoản nợ.
enum DebtType {
  creditCard,
  unsecured, // vay tín chấp
  installment, // trả góp
  appLoan, // vay qua app
  other;

  static DebtType fromName(String name) =>
      DebtType.values.firstWhere((e) => e.name == name, orElse: () => DebtType.other);
}

/// Cách tính lãi.
enum InterestType {
  /// Lãi tính trên dư nợ còn lại (giảm dần theo dư nợ).
  declining,

  /// Lãi tính trên gốc ban đầu (cố định mỗi kỳ).
  fixed;

  static InterestType fromName(String name) => InterestType.values
      .firstWhere((e) => e.name == name, orElse: () => InterestType.declining);
}

/// Chiến lược trả nợ.
enum Strategy {
  snowball, // trả khoản nhỏ nhất trước
  avalanche; // trả khoản lãi cao nhất trước

  String get label {
    switch (this) {
      case Strategy.snowball:
        return 'Snowball';
      case Strategy.avalanche:
        return 'Avalanche';
    }
  }

  static Strategy fromName(String? name) => Strategy.values
      .firstWhere((e) => e.name == name, orElse: () => Strategy.avalanche);
}
