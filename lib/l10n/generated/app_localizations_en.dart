// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get start => 'Get started';

  @override
  String get continueLabel => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get gotIt => 'Got it';

  @override
  String get onboardTitle1 => 'Get out of debt, one step at a time';

  @override
  String get onboardBody1 =>
      'A payoff planner for anyone juggling more than one loan at once.';

  @override
  String get onboardTitle2 => 'Your data stays on your phone';

  @override
  String get onboardBody2 =>
      'No account. Nothing sent to any server. Your debt information stays completely private.';

  @override
  String get onboardTitle3 => 'How it works';

  @override
  String get onboardBody3 =>
      '1. Add your debts\n2. Pick a payoff strategy\n3. Follow the month-by-month plan';

  @override
  String get emptyStateTitle => 'No debts recorded yet';

  @override
  String get emptyStateBody =>
      'Add your first debt to see the full picture and build your payoff plan.';

  @override
  String get addFirstDebt => 'Add your first debt';

  @override
  String get totalBalanceLabel => 'Total debt';

  @override
  String minOnlyInfo(String date, String amount) {
    return 'Paying only the minimum: debt-free by $date, total interest paid $amount.';
  }

  @override
  String get minOnlyNeverInfo =>
      'At the current minimum payments, this debt will never go away. Set up a payoff plan.';

  @override
  String get setupStrategyCta => 'Set up a payoff plan';

  @override
  String get debtsListTitle => 'Your debts';

  @override
  String ratePerYear(String rate) {
    return '$rate%/yr';
  }

  @override
  String paidPercentOfPrincipal(String percent) {
    return '$percent% of original balance paid off';
  }

  @override
  String get minimumTrapWarning =>
      'At this payment, the balance won\'t go down — the payment doesn\'t even cover the interest.';

  @override
  String get debtTypeCreditCard => 'Credit card';

  @override
  String get debtTypeUnsecured => 'Personal loan';

  @override
  String get debtTypeInstallment => 'Installment loan';

  @override
  String get debtTypeAppLoan => 'App loan';

  @override
  String get debtTypeOther => 'Other';

  @override
  String get interestTypeDeclining =>
      'Declining balance (on remaining balance)';

  @override
  String get interestTypeFixed => 'Fixed (on original amount)';

  @override
  String get editDebtTitleAdd => 'Add debt';

  @override
  String get editDebtTitleEdit => 'Edit debt';

  @override
  String get debtNameLabel => 'Debt name';

  @override
  String get debtNameHint => 'e.g. Visa credit card';

  @override
  String get debtNameRequired => 'Enter a debt name';

  @override
  String get debtTypeLabel => 'Debt type';

  @override
  String get currentBalanceLabel => 'Current balance';

  @override
  String get interestRateLabel => 'Interest rate';

  @override
  String get perYear => '/year';

  @override
  String get perMonth => '/month';

  @override
  String get interestRateRequired => 'Enter an interest rate';

  @override
  String get interestTypeLabel => 'How interest is calculated';

  @override
  String get explainTooltip => 'Explain';

  @override
  String get minPaymentLabel => 'Minimum payment / month';

  @override
  String get dueDayLabel => 'Monthly due day';

  @override
  String dueDayItem(String day) {
    return 'Day $day';
  }

  @override
  String get startDateLabel => 'Loan start date (optional)';

  @override
  String get selectDate => 'Select date';

  @override
  String get noteOptionalLabel => 'Note (optional)';

  @override
  String get saveDebt => 'Save debt';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get amountRequired => 'Enter an amount';

  @override
  String get effectiveRateDialogTitle => 'About the real interest rate';

  @override
  String effectiveRateDialogBody(String nominal, String effective) {
    return 'You entered a fixed rate of $nominal%/year.\n\nBecause fixed-rate interest is always calculated on the original amount (even as the balance goes down), the real rate you actually pay works out to about $effective%/year — higher than the number you entered.';
  }

  @override
  String get reviewAgain => 'Review again';

  @override
  String get understoodSave => 'Understood, save';

  @override
  String get interestTypeHelpTitle => 'Two ways to calculate interest';

  @override
  String get interestTypeHelpBody =>
      'Example: borrowing 10,000,000 at 1%/month interest:\n\n• Declining balance: the first month\'s interest is calculated on 10,000,000 = 100,000. Once the balance drops to 5,000,000, interest is only 50,000.\n\n• Fixed: interest is always calculated on the original 10,000,000 = 100,000 every month, even after the balance has gone down. Total interest paid ends up much higher.';

  @override
  String get chooseStrategyTitle => 'Choose a strategy';

  @override
  String get snowballSubtitle =>
      'Pay off the smallest balance first — builds momentum fast';

  @override
  String get avalancheSubtitle =>
      'Pay off the highest interest rate first — saves the most money';

  @override
  String get extraPerMonthLabel => 'Extra amount you can pay each month';

  @override
  String get extraPerMonthHint => 'On top of the required minimum payments.';

  @override
  String projectedPayoffDate(String date) {
    return 'Debt-free by $date';
  }

  @override
  String afterMonthsDot(String months) {
    return 'In $months months.';
  }

  @override
  String savedInterestVsMinimum(String amount) {
    return 'Saves $amount in interest compared to paying only the minimum.';
  }

  @override
  String get notPayableWithin50Years =>
      'At this extra payment amount, the debt can\'t be paid off within 50 years. Try increasing the extra amount per month.';

  @override
  String get viewDetailedRoadmap => 'View detailed roadmap';

  @override
  String get roadmapTitle => 'Payoff roadmap';

  @override
  String get tryAnotherScenario => 'Try another scenario';

  @override
  String get roadmapNotReachable =>
      'At the current extra payment amount, the debt can\'t be paid off within the 50-year limit.\n\nGo back and increase the extra amount per month.';

  @override
  String strategyLabelLine(String strategy) {
    return 'Strategy: $strategy';
  }

  @override
  String debtFreeBy(String date) {
    return 'Debt-free by $date';
  }

  @override
  String afterMonths(String months) {
    return 'In $months months';
  }

  @override
  String get totalInterestLabel => 'Total interest to be paid';

  @override
  String get totalSavedLabel => 'Total saved';

  @override
  String get monthlyRoadmapTitle => 'Month-by-month plan';

  @override
  String focusedDebtLine(String name) {
    return 'Extra payment focused on: $name';
  }

  @override
  String remainingAmount(String amount) {
    return '$amount left';
  }

  @override
  String get debtFallbackName => 'Debt';

  @override
  String get currentDebtBalanceLabel => 'Current balance';

  @override
  String get thisMonthInterestLabel => 'This month\'s interest (estimate)';

  @override
  String get dueDateLabel => 'Due date';

  @override
  String dueDayValue(String day) {
    return 'Day $day of every month';
  }

  @override
  String get noteRowLabel => 'Note';

  @override
  String minimumTrapDetailWarning(String min, String interest) {
    return '⚠ The minimum payment ($min) is lower than the interest charged ($interest). The balance won\'t go down if you only pay the minimum.';
  }

  @override
  String get markPaidThisMonth => 'Mark this month as paid';

  @override
  String get paymentHistoryTitle => 'Payment history';

  @override
  String get recordPaymentTitle => 'Record a payment';

  @override
  String get amountPaidLabel => 'Amount paid';

  @override
  String get paymentDateLabel => 'Payment date';

  @override
  String get paymentRecorded => 'Payment recorded 👍';

  @override
  String get deleteDebtTitle => 'Delete this debt?';

  @override
  String deleteDebtBody(String name) {
    return 'Remove \"$name\" from your list. Its payment history will also be deleted.';
  }

  @override
  String get paidOff => 'Paid off';

  @override
  String get deletedByMistake => 'Deleted by mistake';

  @override
  String get noPaymentsYet => 'No payments recorded yet.';

  @override
  String get paywallTitle => 'Lighten Pro';

  @override
  String get paywallHeadline => 'Unlock the full debt payoff toolkit';

  @override
  String get paywallSubheadline =>
      'One-time purchase, yours forever. No subscription.';

  @override
  String get proFeature1Title => 'Compare multiple scenarios (what-if)';

  @override
  String get proFeature1Body =>
      'Line up different extra-payment amounts side by side to pick the best option.';

  @override
  String get proFeature2Title => 'Advanced progress charts';

  @override
  String get proFeature2Body => 'Track your balance trending down over time.';

  @override
  String get proFeature3Title => 'Export PDF report';

  @override
  String get proFeature3Body => 'Save your entire payoff roadmap.';

  @override
  String get proFeature4Title => 'Remove all ads';

  @override
  String get proFeature4Body => 'A clean, focused experience.';

  @override
  String upgradeProWithPrice(String price) {
    return 'Upgrade to Pro — $price';
  }

  @override
  String get upgradeProGeneric => 'Upgrade to Pro — one-time purchase';

  @override
  String get or => 'or';

  @override
  String get watchAdTempPro => 'Watch an ad — unlock Pro for 24 hours';

  @override
  String get restorePurchase => 'Restore purchase';

  @override
  String get adNotReady => 'Ad isn\'t ready yet, try again in a moment.';

  @override
  String get welcomeToPro => 'Welcome to Pro 💚';

  @override
  String get purchaseFailed => 'Purchase didn\'t go through, please try again.';

  @override
  String get restoredPro => 'Pro restored.';

  @override
  String get noPreviousPurchase => 'No previous purchase found.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get reminderSectionTitle => 'Payment reminders';

  @override
  String get enableReminder => 'Enable reminders';

  @override
  String get reminderSubtitle => 'Get reminded on each debt\'s due day';

  @override
  String get reminderTimeLabel => 'Reminder time';

  @override
  String get proSectionTitle => 'Lighten Pro';

  @override
  String get alreadyPro => 'You\'re on Pro';

  @override
  String get tempProActive => 'Pro temporarily unlocked';

  @override
  String get upgradeProShort => 'Upgrade to Pro';

  @override
  String get thanksForSupport => 'Thanks for your support 💚';

  @override
  String tempProUntil(String time) {
    return 'Active until $time — upgrade for permanent access';
  }

  @override
  String get proSummary => 'Compare scenarios, advanced charts, no ads';

  @override
  String get restorePurchasesTitle => 'Restore previous purchase';

  @override
  String get checkingPurchase => 'Checking for purchases...';

  @override
  String get privacySectionTitle => 'Privacy';

  @override
  String get privacyBody =>
      'All your data stays on your device. No account, no data collection, nothing ever sent anywhere.';

  @override
  String get languageSectionTitle => 'Language';

  @override
  String get systemDefaultLanguage => 'System default';

  @override
  String get reminderChannelName => 'Payment reminders';

  @override
  String get reminderChannelDesc => 'Reminds you of each debt\'s due day';

  @override
  String reminderNotifTitle(String name) {
    return 'Due today: $name';
  }

  @override
  String reminderNotifBody(String name) {
    return 'Today is the minimum payment due date for \"$name\".';
  }

  @override
  String get currencySectionTitle => 'Currency';

  @override
  String get currencyAuto => 'Automatic (based on language)';

  @override
  String get pdfMonthColumn => 'Month';

  @override
  String get pdfInterestColumn => 'Interest';

  @override
  String get pdfBalanceColumn => 'Balance';

  @override
  String get whatIfExtraFieldLabel => 'Extra/month';

  @override
  String get whatIfAddScenario => 'Add scenario';

  @override
  String get whatIfColumnScenario => 'Scenario';

  @override
  String get whatIfColumnPayoffDate => 'Debt-free';

  @override
  String get whatIfColumnMonths => 'Months';

  @override
  String get whatIfColumnInterest => 'Interest';

  @override
  String get proLockedCta => 'Unlock with Pro';
}
