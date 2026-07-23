import 'package:flutter/widgets.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/enums.dart';

extension DebtTypeLabel on DebtType {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case DebtType.creditCard:
        return l10n.debtTypeCreditCard;
      case DebtType.unsecured:
        return l10n.debtTypeUnsecured;
      case DebtType.installment:
        return l10n.debtTypeInstallment;
      case DebtType.appLoan:
        return l10n.debtTypeAppLoan;
      case DebtType.other:
        return l10n.debtTypeOther;
    }
  }
}

extension InterestTypeLabel on InterestType {
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case InterestType.declining:
        return l10n.interestTypeDeclining;
      case InterestType.fixed:
        return l10n.interestTypeFixed;
    }
  }
}
