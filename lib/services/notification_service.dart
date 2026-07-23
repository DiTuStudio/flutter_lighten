import 'dart:ui' show Locale, PlatformDispatcher;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../l10n/generated/app_localizations.dart';
import '../models/debt.dart';

/// Nhắc lịch thanh toán bằng thông báo cục bộ (không cần server).
/// Mỗi khoản nợ được nhắc hàng tháng vào đúng ngày đến hạn.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _ready = false;

  Future<void> init() async {
    if (_ready) return;
    try {
      tz.initializeTimeZones();
      const androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosInit = DarwinInitializationSettings();
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: androidInit,
          iOS: iosInit,
        ),
      );
      _ready = true;
    } catch (e) {
      debugPrint('NotificationService init failed: $e');
    }
  }

  Future<void> requestPermission() async {
    try {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } catch (e) {
      debugPrint('requestPermission failed: $e');
    }
  }

  /// Ngôn ngữ đã chọn trong Settings ('en', 'vi', ...) hoặc null = theo hệ thống.
  /// NotificationService không có BuildContext (lịch nhắc chạy dù app đóng),
  /// nên tra cứu localization trực tiếp qua [lookupAppLocalizations] thay vì
  /// `AppLocalizations.of(context)`.
  AppLocalizations _resolveL10n(String? languageCode) {
    final code = languageCode ??
        PlatformDispatcher.instance.locale.languageCode;
    if (AppLocalizations.supportedLocales
        .any((l) => l.languageCode == code)) {
      return lookupAppLocalizations(Locale(code));
    }
    return lookupAppLocalizations(const Locale('en'));
  }

  /// Huỷ toàn bộ và lên lịch lại cho tất cả khoản nợ theo giờ nhắc.
  Future<void> rescheduleAll({
    required List<Debt> debts,
    required bool enabled,
    required int hour,
    required int minute,
    String? languageCode,
  }) async {
    if (!_ready) await init();
    try {
      await _plugin.cancelAll();
      if (!enabled) return;
      final l10n = _resolveL10n(languageCode);
      for (final debt in debts) {
        if (debt.id == null || debt.balance <= 0) continue;
        await _scheduleMonthly(debt, hour, minute, l10n);
      }
    } catch (e) {
      debugPrint('rescheduleAll failed: $e');
    }
  }

  Future<void> _scheduleMonthly(
      Debt debt, int hour, int minute, AppLocalizations l10n) async {
    final next = _nextOccurrence(debt.dueDay, hour, minute);
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'payment_reminders',
        l10n.reminderChannelName,
        channelDescription: l10n.reminderChannelDesc,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      id: debt.id!,
      title: l10n.reminderNotifTitle(debt.name),
      body: l10n.reminderNotifBody(debt.name),
      scheduledDate: next,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
  }

  tz.TZDateTime _nextOccurrence(int day, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    // Kẹp ngày về tối đa số ngày trong tháng để tránh lỗi (VD ngày 31 ở tháng 2).
    int safeDay(int year, int month) {
      final lastDay = DateTime(year, month + 1, 0).day;
      return day > lastDay ? lastDay : day;
    }

    var scheduled = tz.TZDateTime(
        tz.local, now.year, now.month, safeDay(now.year, now.month), hour, minute);
    if (scheduled.isBefore(now)) {
      final nm = now.month == 12 ? 1 : now.month + 1;
      final ny = now.month == 12 ? now.year + 1 : now.year;
      scheduled =
          tz.TZDateTime(tz.local, ny, nm, safeDay(ny, nm), hour, minute);
    }
    return scheduled;
  }
}
