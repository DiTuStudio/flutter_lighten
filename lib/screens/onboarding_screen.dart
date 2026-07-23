import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/generated/app_localizations.dart';
import '../theme.dart';
import 'dashboard_screen.dart';
import 'edit_debt_screen.dart';

const kOnboardingSeenKey = 'onboarding_seen';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  List<_OnboardPage> _pages(AppLocalizations l10n) => [
        _OnboardPage(
          icon: Icons.savings_outlined,
          title: l10n.onboardTitle1,
          body: l10n.onboardBody1,
        ),
        _OnboardPage(
          icon: Icons.lock_outline,
          title: l10n.onboardTitle2,
          body: l10n.onboardBody2,
          highlight: true,
        ),
        _OnboardPage(
          icon: Icons.route_outlined,
          title: l10n.onboardTitle3,
          body: l10n.onboardBody3,
        ),
      ];

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kOnboardingSeenKey, true);
    if (!mounted) return;
    // Vào thẳng màn thêm khoản nợ (app vô nghĩa khi chưa có dữ liệu).
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditDebtScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pages = _pages(l10n);
    final isLast = _page == pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == _page ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _page
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: FilledButton(
                onPressed: () {
                  if (isLast) {
                    _finish();
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                },
                child: Text(isLast ? l10n.start : l10n.continueLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final bool highlight;

  const _OnboardPage({
    required this.icon,
    required this.title,
    required this.body,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: highlight
                  ? AppColors.primary
                  : AppColors.primaryLight.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                size: 60,
                color: highlight ? Colors.white : AppColors.primary),
          ),
          const SizedBox(height: 32),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          Text(body,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}
