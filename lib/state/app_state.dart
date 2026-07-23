import 'package:flutter/foundation.dart';

import '../data/repository.dart';
import '../engine/interest.dart';
import '../engine/payoff_engine.dart';
import '../models/app_settings.dart';
import '../models/debt.dart';
import '../models/enums.dart';
import '../models/payment.dart';
import '../services/notification_service.dart';
import '../utils/format.dart';

/// State trung tâm: giữ danh sách nợ + cấu hình, và cung cấp các giá trị tính toán
/// (tổng nợ, lộ trình, cảnh báo bẫy tài chính). Dùng qua Provider.
class AppState extends ChangeNotifier {
  final Repository _repo;
  AppState({Repository? repo}) : _repo = repo ?? Repository();

  bool _loading = true;
  bool get loading => _loading;

  List<Debt> _debts = [];
  List<Debt> get debts => List.unmodifiable(_debts);

  AppSettings _settings = const AppSettings();
  AppSettings get settings => _settings;

  Future<void> load() async {
    _loading = true;
    notifyListeners();
    _debts = await _repo.getDebts();
    _settings = await _repo.getSettings();
    _loading = false;
    notifyListeners();
    // Đồng bộ lịch nhắc mỗi khi dữ liệu thay đổi.
    await NotificationService.instance.rescheduleAll(
      debts: _debts,
      enabled: _settings.reminderEnabled,
      hour: _settings.reminderHour,
      minute: _settings.reminderMinute,
      languageCode: _settings.languageCode,
    );
  }

  // ---- Derived ----

  bool get hasDebts => _debts.isNotEmpty;

  /// Tiền tệ hiện dùng: theo lựa chọn tay của user, hoặc suy ra từ ngôn ngữ
  /// UI nếu user chưa từng chọn (xem [defaultCurrencyForLanguage]).
  CurrencyInfo get currency => currencyInfo(
      _settings.currencyCode ?? defaultCurrencyForLanguage(_settings.languageCode));

  /// True nếu có quyền Pro: mua đứt vĩnh viễn HOẶC Pro tạm (rewarded) còn hạn.
  bool get hasProAccess =>
      _settings.isPro ||
      _settings.proTempUntilEpoch > DateTime.now().millisecondsSinceEpoch;

  /// Thời điểm hết hạn Pro tạm (null nếu không có / đã hết / đã mua vĩnh viễn).
  DateTime? get tempProExpiry {
    if (_settings.isPro || _settings.proTempUntilEpoch == 0) return null;
    final until =
        DateTime.fromMillisecondsSinceEpoch(_settings.proTempUntilEpoch);
    return until.isAfter(DateTime.now()) ? until : null;
  }

  double get totalBalance => _debts.fold(0, (s, d) => s + d.balance);

  /// Tháng bắt đầu mô phỏng (đầu tháng hiện tại).
  DateTime get _startMonth {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  /// Lãi phát sinh tháng này của 1 khoản.
  double monthlyInterestOf(Debt d) => monthlyInterest(
        annualRatePercent: d.annualRate,
        currentBalance: d.balance,
        originalPrincipal: d.originalPrincipal,
        isFixed: d.interestType == InterestType.fixed,
      );

  /// Bẫy tài chính: trả tối thiểu không đủ bù lãi → dư nợ không giảm.
  bool isMinimumTrap(Debt d) =>
      d.balance > 0 && d.minimumPayment < monthlyInterestOf(d);

  bool get hasAnyTrap => _debts.any(isMinimumTrap);

  /// Lộ trình nếu chỉ trả tối thiểu (baseline để so sánh).
  PayoffResult get minimumOnlyResult => PayoffEngine.simulate(
        debts: _debts,
        strategy: _settings.strategy ?? Strategy.avalanche,
        extraPerMonth: 0,
        rollover: false,
        startMonth: _startMonth,
      );

  /// Lộ trình theo chiến lược đã chọn (dùng extra hiện tại trong settings).
  PayoffResult get strategyResult => simulateWith(
        strategy: _settings.strategy ?? Strategy.avalanche,
        extraPerMonth: _settings.extraPerMonth,
      );

  /// Mô phỏng tùy biến (dùng cho preview/what-if trên màn chiến lược).
  PayoffResult simulateWith({
    required Strategy strategy,
    required double extraPerMonth,
  }) {
    return PayoffEngine.simulate(
      debts: _debts,
      strategy: strategy,
      extraPerMonth: extraPerMonth,
      rollover: true,
      startMonth: _startMonth,
    );
  }

  // ---- Mutations ----

  Future<void> addDebt(Debt debt) async {
    await _repo.insertDebt(debt);
    await load();
  }

  Future<void> updateDebt(Debt debt) async {
    await _repo.updateDebt(debt);
    await load();
  }

  Future<void> deleteDebt(int id) async {
    await _repo.deleteDebt(id);
    await load();
  }

  Future<List<Payment>> paymentsOf(int debtId) => _repo.getPayments(debtId);

  Future<void> addPayment(Payment payment) async {
    await _repo.addPayment(payment);
    await load();
  }

  Future<void> deletePayment(int paymentId) async {
    await _repo.deletePayment(paymentId);
    await load();
  }

  Future<void> setStrategy(Strategy strategy, double extraPerMonth) async {
    _settings = _settings.copyWith(strategy: strategy, extraPerMonth: extraPerMonth);
    await _repo.saveSettings(_settings);
    notifyListeners();
  }

  /// Cập nhật trạng thái Pro (nguồn sự thật là Apple/RevenueCat; đây là cache local).
  Future<void> setPro(bool value) async {
    if (_settings.isPro == value) return;
    await saveSettings(_settings.copyWith(isPro: value));
  }

  /// Cấp Pro tạm thời (đổi bằng rewarded video). Cộng dồn nếu còn hạn.
  Future<void> grantTempPro(Duration duration) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final base = _settings.proTempUntilEpoch > now ? _settings.proTempUntilEpoch : now;
    await saveSettings(
        _settings.copyWith(proTempUntilEpoch: base + duration.inMilliseconds));
  }

  Future<void> saveSettings(AppSettings settings) async {
    _settings = settings;
    await _repo.saveSettings(settings);
    notifyListeners();
    await NotificationService.instance.rescheduleAll(
      debts: _debts,
      enabled: _settings.reminderEnabled,
      hour: _settings.reminderHour,
      minute: _settings.reminderMinute,
      languageCode: _settings.languageCode,
    );
  }
}
