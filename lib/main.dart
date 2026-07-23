import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'l10n/generated/app_localizations.dart';
import 'screens/dashboard_screen.dart';
import 'screens/onboarding_screen.dart';
import 'services/ad_service.dart';
import 'services/iap_service.dart';
import 'services/notification_service.dart';
import 'state/app_state.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Trên desktop (Windows/Linux/macOS) sqflite cần khởi tạo qua FFI.
  // Mobile (Android/iOS) dùng plugin sqflite gốc — không cần bước này.
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Date formatters trong utils/format.dart luôn dùng locale 'en' (chỉ hiện
  // số, không phụ thuộc ngôn ngữ UI) nên chỉ cần khởi tạo dữ liệu 'en'.
  await initializeDateFormatting('en', null);
  await NotificationService.instance.init();
  await AdService.instance.init();
  AdService.instance.preloadInterstitial();
  AdService.instance.preloadRewarded();
  await configureIap();

  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool(kOnboardingSeenKey) ?? false;

  final appState = AppState();
  await appState.load(); // đọc sqlite (nhanh) → home hiện data ngay, không quay tròn

  // Đồng bộ trạng thái Pro CHẠY NỀN, không chặn khởi động UI.
  unawaited(_syncProInBackground(appState, prefs));

  runApp(ThoatNoApp(appState: appState, seenOnboarding: seenOnboarding));
}

/// Đồng bộ quyền Pro từ store mà không làm chậm màn hình đầu tiên.
///
/// - Nếu đã Pro (cache trong sqlite) → bỏ qua, không gọi store.
/// - Đọc entitlement im lặng (không hiện popup).
/// - Tự khôi phục (restore) MỘT LẦN mỗi lần cài app, để lấy lại Pro sau khi
///   cài lại/đổi máy mà không làm phiền user bằng popup đăng nhập mỗi lần mở.
Future<void> _syncProInBackground(
    AppState state, SharedPreferences prefs) async {
  if (state.settings.isPro) return;

  final iap = createIapService();

  // 1) Kiểm tra im lặng (getCustomerInfo — không hiện popup đăng nhập).
  if (await iap.isProActive()) {
    await state.setPro(true);
    return;
  }

  // 2) Tự restore đúng 1 lần cho mỗi lần cài (prefs bị xoá khi gỡ app → lần
  //    cài lại sẽ chạy lại đúng 1 lần, khớp kịch bản khôi phục sau reinstall).
  const kAutoRestore = 'auto_restore_attempted';
  if (prefs.getBool(kAutoRestore) ?? false) return;
  await prefs.setBool(kAutoRestore, true);

  if (await iap.restore()) {
    await state.setPro(true);
  }
}

class ThoatNoApp extends StatelessWidget {
  final AppState appState;
  final bool seenOnboarding;

  const ThoatNoApp({
    super.key,
    required this.appState,
    required this.seenOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appState,
      child: Consumer<AppState>(
        builder: (context, state, _) {
          final languageCode = state.settings.languageCode;
          return MaterialApp(
            title: 'Lighten',
            debugShowCheckedModeBanner: false,
            theme: buildAppTheme(),
            locale: languageCode != null ? Locale(languageCode) : null,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: seenOnboarding
                ? const DashboardScreen()
                : const OnboardingScreen(),
          );
        },
      ),
    );
  }
}
