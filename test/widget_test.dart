// Smoke test cơ bản cho app Thoát Nợ.
//
// Engine (phần lõi tính toán) được kiểm thử kỹ trong test/engine_test.dart.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thoat_no/l10n/generated/app_localizations.dart';
import 'package:thoat_no/screens/onboarding_screen.dart';

void main() {
  testWidgets('Onboarding hiển thị tagline', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: OnboardingScreen(),
    ));
    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(find.text(l10n.onboardTitle1), findsOneWidget);
    expect(find.text(l10n.continueLabel), findsOneWidget);
  });
}
