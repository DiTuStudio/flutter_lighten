import 'package:flutter/material.dart';

/// Bảng màu & theme của app "Thoát Nợ".
///
/// Tông chủ đạo: xanh teal (tin cậy, tài chính, không phô trương) + nền sáng.
/// Đỏ chỉ dành cho cảnh báo (trễ hạn, bẫy tài chính). Xanh lá cho tiến triển tốt.
class AppColors {
  static const Color primary = Color(0xFF0E7C6B); // teal đậm
  static const Color primaryLight = Color(0xFF4DB6A5);
  static const Color bg = Color(0xFFF5F7F7);
  static const Color surface = Colors.white;
  static const Color danger = Color(0xFFD64545);
  static const Color warning = Color(0xFFE08A00);
  static const Color success = Color(0xFF2E9E5B);
  static const Color textPrimary = Color(0xFF1A2321);
  static const Color textSecondary = Color(0xFF667370);
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      error: AppColors.danger,
    ),
    scaffoldBackgroundColor: AppColors.bg,
  );

  return base.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
      ),
      margin: EdgeInsets.zero,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
  );
}
