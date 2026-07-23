import '../models/debt.dart';
import '../models/enums.dart';

/// Giới hạn an toàn để tránh vòng lặp vô hạn nếu dữ liệu nhập sai
/// (ví dụ trả tối thiểu < lãi phát sinh trên khoản không bao giờ được ưu tiên).
const int kMaxMonths = 600; // 50 năm

/// Trạng thái nội bộ của 1 khoản nợ trong quá trình mô phỏng.
class _SimDebt {
  final int id;
  final double annualRate;
  final bool isFixed;
  final double originalPrincipal;
  double minimum;
  double balance;

  _SimDebt({
    required this.id,
    required this.annualRate,
    required this.isFixed,
    required this.originalPrincipal,
    required this.minimum,
    required this.balance,
  });

  double get monthlyRate => annualRate / 100 / 12;

  double interestThisMonth() =>
      (isFixed ? originalPrincipal : balance) * monthlyRate;
}

/// Ảnh chụp 1 khoản nợ tại cuối 1 tháng.
class DebtMonthSnapshot {
  final int debtId;
  final double balance;
  final double interestCharged;
  final double paid;

  const DebtMonthSnapshot({
    required this.debtId,
    required this.balance,
    required this.interestCharged,
    required this.paid,
  });
}

/// Một tháng trong lộ trình.
class MonthSnapshot {
  final int monthIndex; // 0-based tính từ tháng bắt đầu
  final DateTime month;

  /// Khoản đang được ưu tiên dồn tiền trả thêm (null nếu không có/đã hết).
  final int? focusedDebtId;

  final double totalRemaining;
  final double totalInterest;
  final double totalPaid;
  final List<DebtMonthSnapshot> debts;

  const MonthSnapshot({
    required this.monthIndex,
    required this.month,
    required this.focusedDebtId,
    required this.totalRemaining,
    required this.totalInterest,
    required this.totalPaid,
    required this.debts,
  });
}

/// Kết quả mô phỏng toàn bộ lộ trình.
class PayoffResult {
  final List<MonthSnapshot> months;
  final double totalInterest;

  /// True nếu đã trả hết nợ trong giới hạn [kMaxMonths].
  final bool payoffReached;

  const PayoffResult({
    required this.months,
    required this.totalInterest,
    required this.payoffReached,
  });

  /// Số tháng cần để hết nợ (= số phần tử months nếu payoffReached).
  int get monthsToPayoff => months.length;

  /// Ngày dự kiến hết nợ (cuối tháng cuối cùng), null nếu không hết trong giới hạn.
  DateTime? get payoffDate => payoffReached && months.isNotEmpty ? months.last.month : null;
}

/// Engine mô phỏng trả nợ theo tháng.
class PayoffEngine {
  static const double _epsilon = 0.005; // dưới nửa xu coi như đã hết

  /// Mô phỏng lộ trình trả nợ.
  ///
  /// - [debts]: danh sách khoản nợ hiện tại (dư nợ > 0).
  /// - [strategy]: thứ tự ưu tiên dồn tiền (snowball/avalanche).
  /// - [extraPerMonth]: số tiền dư trả thêm mỗi tháng ngoài các mức tối thiểu.
  /// - [rollover]: nếu true, dồn tiền tối thiểu được giải phóng (khi 1 khoản hết)
  ///   + [extraPerMonth] vào khoản mục tiêu. Nếu false → mô phỏng "chỉ trả tối thiểu"
  ///   (mỗi khoản trả đúng mức tối thiểu, không dồn).
  /// - [startMonth]: tháng bắt đầu (mặc định tháng hiện tại truyền vào từ ngoài).
  static PayoffResult simulate({
    required List<Debt> debts,
    required Strategy strategy,
    required double extraPerMonth,
    required bool rollover,
    required DateTime startMonth,
  }) {
    final active = debts
        .where((d) => d.balance > _epsilon)
        .map((d) => _SimDebt(
              id: d.id ?? d.hashCode,
              annualRate: d.annualRate,
              isFixed: d.interestType == InterestType.fixed,
              originalPrincipal: d.originalPrincipal,
              minimum: d.minimumPayment,
              balance: d.balance,
            ))
        .toList();

    final months = <MonthSnapshot>[];
    double totalInterest = 0;

    if (active.isEmpty) {
      return const PayoffResult(months: [], totalInterest: 0, payoffReached: true);
    }

    // Tổng ngân sách cố định mỗi tháng khi bật rollover:
    // extra + tổng các mức tối thiểu ban đầu. Ngân sách này giữ nguyên khi
    // các khoản lần lượt hết, nhờ đó tiền được giải phóng dồn vào khoản mục tiêu.
    final double budget =
        rollover ? extraPerMonth + active.fold<double>(0, (s, d) => s + d.minimum) : 0;

    bool reached = true;
    int monthIndex = 0;
    double? prevTotalRemaining;

    while (active.isNotEmpty) {
      if (monthIndex >= kMaxMonths) {
        reached = false;
        break;
      }

      final month = DateTime(startMonth.year, startMonth.month + monthIndex, 1);

      // 1) Tính & cộng lãi cho từng khoản.
      final interestByDebt = <int, double>{};
      double monthInterest = 0;
      for (final d in active) {
        final interest = d.interestThisMonth();
        d.balance += interest;
        interestByDebt[d.id] = interest;
        monthInterest += interest;
      }
      totalInterest += monthInterest;

      // 2) Thanh toán.
      final paidByDebt = <int, double>{for (final d in active) d.id: 0};

      if (rollover) {
        double remaining = budget;
        // 2a) Trả tối thiểu cho mọi khoản trước.
        for (final d in active) {
          if (remaining <= 0) break;
          final pay = _min3(d.minimum, d.balance, remaining);
          d.balance -= pay;
          remaining -= pay;
          paidByDebt[d.id] = paidByDebt[d.id]! + pay;
        }
        // 2b) Dồn phần còn lại vào khoản mục tiêu theo chiến lược.
        final ordered = _orderByStrategy(active, strategy);
        for (final d in ordered) {
          if (remaining <= _epsilon) break;
          if (d.balance <= _epsilon) continue;
          final pay = _min2(d.balance, remaining);
          d.balance -= pay;
          remaining -= pay;
          paidByDebt[d.id] = paidByDebt[d.id]! + pay;
        }
      } else {
        // Chỉ trả tối thiểu: mỗi khoản trả đúng mức tối thiểu (giới hạn bởi dư nợ).
        for (final d in active) {
          final pay = _min2(d.minimum, d.balance);
          d.balance -= pay;
          paidByDebt[d.id] = pay;
        }
      }

      // 3) Xác định khoản đang được ưu tiên (focused) — khoản mục tiêu còn nợ.
      int? focusedId;
      if (rollover) {
        final ordered = _orderByStrategy(active, strategy);
        focusedId = ordered.isNotEmpty ? ordered.first.id : null;
      }

      // 4) Ghi snapshot của tháng (gồm cả các khoản vừa được trả trong tháng này).
      double monthPaid = 0;
      final debtSnaps = <DebtMonthSnapshot>[];
      for (final d in active) {
        final paid = paidByDebt[d.id] ?? 0;
        monthPaid += paid;
        debtSnaps.add(DebtMonthSnapshot(
          debtId: d.id,
          balance: d.balance < _epsilon ? 0 : d.balance,
          interestCharged: interestByDebt[d.id] ?? 0,
          paid: paid,
        ));
      }

      final totalRemaining = active.fold<double>(0, (s, d) => s + d.balance);

      // Phát hiện bế tắc: nếu tổng dư nợ không giảm so với tháng trước, nghĩa là
      // tiền trả không đủ bù lãi → sẽ không bao giờ hết nợ. Dừng sớm.
      if (prevTotalRemaining != null &&
          totalRemaining >= prevTotalRemaining - _epsilon) {
        reached = false;
        break;
      }
      prevTotalRemaining = totalRemaining;

      months.add(MonthSnapshot(
        monthIndex: monthIndex,
        month: month,
        focusedDebtId: focusedId,
        totalRemaining: totalRemaining < _epsilon ? 0 : totalRemaining,
        totalInterest: monthInterest,
        totalPaid: monthPaid,
        debts: debtSnaps,
      ));

      // 5) Loại các khoản đã hết.
      active.removeWhere((d) => d.balance <= _epsilon);

      monthIndex++;
    }

    return PayoffResult(
      months: months,
      totalInterest: totalInterest,
      payoffReached: reached && active.isEmpty,
    );
  }

  /// Sắp xếp khoản nợ theo chiến lược, trên bản dư nợ hiện tại.
  static List<_SimDebt> _orderByStrategy(List<_SimDebt> debts, Strategy strategy) {
    final list = List<_SimDebt>.from(debts);
    switch (strategy) {
      case Strategy.snowball:
        // Dư nợ nhỏ nhất trước; hòa thì lãi cao trước.
        list.sort((a, b) {
          final c = a.balance.compareTo(b.balance);
          return c != 0 ? c : b.annualRate.compareTo(a.annualRate);
        });
        break;
      case Strategy.avalanche:
        // Lãi cao nhất trước; hòa thì dư nợ nhỏ trước.
        list.sort((a, b) {
          final c = b.annualRate.compareTo(a.annualRate);
          return c != 0 ? c : a.balance.compareTo(b.balance);
        });
        break;
    }
    return list;
  }

  static double _min2(double a, double b) => a < b ? a : b;
  static double _min3(double a, double b, double c) => _min2(_min2(a, b), c);
}
