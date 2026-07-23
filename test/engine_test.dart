import 'package:flutter_test/flutter_test.dart';
import 'package:thoat_no/engine/interest.dart';
import 'package:thoat_no/engine/payoff_engine.dart';
import 'package:thoat_no/models/debt.dart';
import 'package:thoat_no/models/enums.dart';

Debt makeDebt({
  required int id,
  required double balance,
  required double annualRate,
  required double minimum,
  InterestType type = InterestType.declining,
  double? originalPrincipal,
}) {
  return Debt(
    id: id,
    name: 'Debt $id',
    type: DebtType.other,
    balance: balance,
    originalPrincipal: originalPrincipal ?? balance,
    annualRate: annualRate,
    interestType: type,
    minimumPayment: minimum,
    dueDay: 1,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  final start = DateTime(2026, 1, 1);

  group('interest conversions', () {
    test('monthly <-> annual', () {
      expect(monthlyToAnnual(1.5), 18);
      expect(annualToMonthly(18), 1.5);
    });

    test('effective rate from fixed is higher', () {
      // 12 kỳ, lãi cố định 12%/năm → xấp xỉ 2*12*12/13 ≈ 22.15%
      final eff = effectiveRateFromFixed(12, 12);
      expect(eff, closeTo(22.15, 0.1));
      expect(eff, greaterThan(12));
    });

    test('effective rate with non-positive periods returns input', () {
      expect(effectiveRateFromFixed(10, 0), 10);
    });

    test('monthlyInterest fixed uses original principal', () {
      final i = monthlyInterest(
        annualRatePercent: 12,
        currentBalance: 5000000,
        originalPrincipal: 10000000,
        isFixed: true,
      );
      // 10tr * 1%/tháng = 100k, dùng gốc ban đầu chứ không phải dư nợ.
      expect(i, closeTo(100000, 1));
    });

    test('monthlyInterest declining uses current balance', () {
      final i = monthlyInterest(
        annualRatePercent: 12,
        currentBalance: 5000000,
        originalPrincipal: 10000000,
        isFixed: false,
      );
      expect(i, closeTo(50000, 1));
    });
  });

  group('payoff engine — basics', () {
    test('single 0% debt pays off in expected months', () {
      final debts = [makeDebt(id: 1, balance: 1000000, annualRate: 0, minimum: 250000)];
      final r = PayoffEngine.simulate(
        debts: debts,
        strategy: Strategy.avalanche,
        extraPerMonth: 0,
        rollover: false,
        startMonth: start,
      );
      expect(r.payoffReached, true);
      expect(r.monthsToPayoff, 4); // 1tr / 250k = 4 tháng
      expect(r.totalInterest, 0);
    });

    test('empty debts => reached immediately', () {
      final r = PayoffEngine.simulate(
        debts: [],
        strategy: Strategy.snowball,
        extraPerMonth: 0,
        rollover: false,
        startMonth: start,
      );
      expect(r.payoffReached, true);
      expect(r.months, isEmpty);
    });
  });

  group('edge case — minimum below interest (bẫy tài chính)', () {
    test('minimum-only never pays off => payoffReached false, stops early', () {
      // Dư 10tr, 36%/năm (3%/tháng) => lãi 300k/tháng, min chỉ 200k.
      final debts = [makeDebt(id: 1, balance: 10000000, annualRate: 36, minimum: 200000)];
      final r = PayoffEngine.simulate(
        debts: debts,
        strategy: Strategy.avalanche,
        extraPerMonth: 0,
        rollover: false,
        startMonth: start,
      );
      expect(r.payoffReached, false);
      // Dừng sớm (không chạy tới 600 tháng) vì phát hiện bế tắc.
      expect(r.monthsToPayoff, lessThan(kMaxMonths));
    });

    test('with enough extra, the same debt is paid off', () {
      final debts = [makeDebt(id: 1, balance: 10000000, annualRate: 36, minimum: 200000)];
      final r = PayoffEngine.simulate(
        debts: debts,
        strategy: Strategy.avalanche,
        extraPerMonth: 2000000,
        rollover: true,
        startMonth: start,
      );
      expect(r.payoffReached, true);
      expect(r.totalInterest, greaterThan(0));
    });
  });

  group('avalanche vs snowball', () {
    // 2 khoản: A nhỏ nhưng lãi thấp, B lớn nhưng lãi cao.
    List<Debt> two() => [
          makeDebt(id: 1, balance: 2000000, annualRate: 12, minimum: 100000), // nhỏ, lãi thấp
          makeDebt(id: 2, balance: 8000000, annualRate: 40, minimum: 300000), // lớn, lãi cao
        ];

    test('avalanche costs less total interest than snowball', () {
      final ava = PayoffEngine.simulate(
        debts: two(),
        strategy: Strategy.avalanche,
        extraPerMonth: 1000000,
        rollover: true,
        startMonth: start,
      );
      final snow = PayoffEngine.simulate(
        debts: two(),
        strategy: Strategy.snowball,
        extraPerMonth: 1000000,
        rollover: true,
        startMonth: start,
      );
      expect(ava.payoffReached, true);
      expect(snow.payoffReached, true);
      // Avalanche ưu tiên khoản lãi cao => tổng lãi thấp hơn (hoặc bằng).
      expect(ava.totalInterest, lessThanOrEqualTo(snow.totalInterest));
    });

    test('snowball focuses smallest balance first', () {
      final snow = PayoffEngine.simulate(
        debts: two(),
        strategy: Strategy.snowball,
        extraPerMonth: 1000000,
        rollover: true,
        startMonth: start,
      );
      // Tháng đầu, khoản được ưu tiên (focused) là khoản nhỏ nhất => id 1.
      expect(snow.months.first.focusedDebtId, 1);
    });

    test('avalanche focuses highest rate first', () {
      final ava = PayoffEngine.simulate(
        debts: two(),
        strategy: Strategy.avalanche,
        extraPerMonth: 1000000,
        rollover: true,
        startMonth: start,
      );
      expect(ava.months.first.focusedDebtId, 2);
    });
  });

  group('rollover accelerates payoff vs minimum-only', () {
    test('strategy pays off faster and cheaper than minimum-only', () {
      List<Debt> debts() => [
            makeDebt(id: 1, balance: 3000000, annualRate: 20, minimum: 200000),
            makeDebt(id: 2, balance: 5000000, annualRate: 30, minimum: 300000),
          ];
      final minOnly = PayoffEngine.simulate(
        debts: debts(),
        strategy: Strategy.avalanche,
        extraPerMonth: 0,
        rollover: false,
        startMonth: start,
      );
      final withStrategy = PayoffEngine.simulate(
        debts: debts(),
        strategy: Strategy.avalanche,
        extraPerMonth: 500000,
        rollover: true,
        startMonth: start,
      );
      expect(minOnly.payoffReached, true);
      expect(withStrategy.payoffReached, true);
      expect(withStrategy.monthsToPayoff, lessThan(minOnly.monthsToPayoff));
      expect(withStrategy.totalInterest, lessThan(minOnly.totalInterest));
    });
  });

  group('fixed interest uses original principal throughout', () {
    test('fixed debt accrues constant interest even as balance drops', () {
      final debts = [
        makeDebt(
          id: 1,
          balance: 12000000,
          annualRate: 12,
          minimum: 1100000,
          type: InterestType.fixed,
          originalPrincipal: 12000000,
        ),
      ];
      final r = PayoffEngine.simulate(
        debts: debts,
        strategy: Strategy.avalanche,
        extraPerMonth: 0,
        rollover: false,
        startMonth: start,
      );
      // Lãi mỗi tháng = 12tr * 1% = 120k, không đổi theo dư nợ.
      for (final m in r.months) {
        expect(m.debts.first.interestCharged, closeTo(120000, 1));
      }
      expect(r.payoffReached, true);
    });
  });
}
