import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/notification_service.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import 'paywall_screen.dart';

/// Ngôn ngữ hỗ trợ, tên hiển thị luôn bằng chính ngôn ngữ đó (không dịch theo
/// ngôn ngữ hiện tại) — đúng quy ước UX chuẩn cho màn chọn ngôn ngữ.
const _kSupportedLanguages = [
  (code: 'en', name: 'English'),
  (code: 'vi', name: 'Tiếng Việt'),
  (code: 'es', name: 'Español'),
  (code: 'pt', name: 'Português'),
  (code: 'id', name: 'Bahasa Indonesia'),
];

/// Thứ tự tiền tệ hiển thị trong màn chọn — nhãn dùng mã ISO + ký hiệu, không
/// cần dịch (giống quy ước tên ngôn ngữ ở trên).
const _kSupportedCurrencyCodes = ['VND', 'USD', 'EUR', 'BRL', 'IDR'];

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final s = state.settings;
    final time = TimeOfDay(hour: s.reminderHour, minute: s.reminderMinute);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle(l10n.reminderSectionTitle),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.enableReminder),
                  subtitle: Text(l10n.reminderSubtitle),
                  value: s.reminderEnabled,
                  activeTrackColor: AppColors.primary,
                  onChanged: (v) async {
                    if (v) {
                      await NotificationService.instance.requestPermission();
                    }
                    await state.saveSettings(s.copyWith(reminderEnabled: v));
                  },
                ),
                if (s.reminderEnabled) ...[
                  const Divider(height: 1),
                  ListTile(
                    title: Text(l10n.reminderTimeLabel),
                    trailing: Text(time.format(context),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                    onTap: () async {
                      final picked = await showTimePicker(
                          context: context, initialTime: time);
                      if (picked != null) {
                        await state.saveSettings(s.copyWith(
                            reminderHour: picked.hour,
                            reminderMinute: picked.minute));
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          _sectionTitle(l10n.languageSectionTitle),
          Card(
            child: ListTile(
              leading: const Icon(Icons.language, color: AppColors.primary),
              title: Text(_currentLanguageName(s.languageCode, l10n)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _pickLanguage(context, state, l10n),
            ),
          ),
          const SizedBox(height: 20),
          _sectionTitle(l10n.currencySectionTitle),
          Card(
            child: ListTile(
              leading: const Icon(Icons.attach_money, color: AppColors.primary),
              title: Text(_currentCurrencyLabel(s.currencyCode, s.languageCode, l10n)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _pickCurrency(context, state, l10n),
            ),
          ),
          const SizedBox(height: 20),
          _sectionTitle(l10n.proSectionTitle),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    state.hasProAccess
                        ? Icons.verified
                        : Icons.workspace_premium_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text(s.isPro
                      ? l10n.alreadyPro
                      : (state.tempProExpiry != null
                          ? l10n.tempProActive
                          : l10n.upgradeProShort)),
                  subtitle: Text(s.isPro
                      ? l10n.thanksForSupport
                      : (state.tempProExpiry != null
                          ? l10n.tempProUntil(
                              _expiryLabel(state.tempProExpiry!, context))
                          : l10n.proSummary)),
                  trailing: s.isPro ? null : const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: s.isPro
                      ? null
                      : () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const PaywallScreen())),
                ),
                if (!s.isPro) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.restore),
                    title: Text(l10n.restorePurchasesTitle),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.checkingPurchase)),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          _sectionTitle(l10n.privacySectionTitle),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.lock_outline, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.privacyBody,
                      style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _currentLanguageName(String? code, AppLocalizations l10n) {
    if (code == null) return l10n.systemDefaultLanguage;
    return _kSupportedLanguages
        .firstWhere((l) => l.code == code, orElse: () => _kSupportedLanguages.first)
        .name;
  }

  Future<void> _pickLanguage(
      BuildContext context, AppState state, AppLocalizations l10n) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: RadioGroup<String?>(
          groupValue: state.settings.languageCode,
          onChanged: (code) async {
            Navigator.pop(ctx);
            await state.saveSettings(code == null
                ? state.settings.copyWith(clearLanguageCode: true)
                : state.settings.copyWith(languageCode: code));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String?>(
                value: null,
                title: Text(l10n.systemDefaultLanguage),
              ),
              for (final lang in _kSupportedLanguages)
                RadioListTile<String?>(
                  value: lang.code,
                  title: Text(lang.name),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _currentCurrencyLabel(
      String? code, String? languageCode, AppLocalizations l10n) {
    final resolved = code ?? defaultCurrencyForLanguage(languageCode);
    final info = currencyInfo(resolved);
    final suffix = code == null ? ' — ${l10n.currencyAuto}' : '';
    return '${info.code} (${info.symbol})$suffix';
  }

  Future<void> _pickCurrency(
      BuildContext context, AppState state, AppLocalizations l10n) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: RadioGroup<String?>(
          groupValue: state.settings.currencyCode,
          onChanged: (code) async {
            Navigator.pop(ctx);
            await state.saveSettings(code == null
                ? state.settings.copyWith(clearCurrencyCode: true)
                : state.settings.copyWith(currencyCode: code));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String?>(
                value: null,
                title: Text(l10n.currencyAuto),
              ),
              for (final code in _kSupportedCurrencyCodes)
                RadioListTile<String?>(
                  value: code,
                  title: Text(
                      '${currencyInfo(code).code} (${currencyInfo(code).symbol})'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _expiryLabel(DateTime expiry, BuildContext context) {
    final t = TimeOfDay.fromDateTime(expiry).format(context);
    return '${expiry.day}/${expiry.month} $t';
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4),
        child: Text(text,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary)),
      );
}
