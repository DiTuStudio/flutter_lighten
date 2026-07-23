import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_id.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('id'),
    Locale('pt'),
    Locale('vi'),
  ];

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get start;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @onboardTitle1.
  ///
  /// In en, this message translates to:
  /// **'Get out of debt, one step at a time'**
  String get onboardTitle1;

  /// No description provided for @onboardBody1.
  ///
  /// In en, this message translates to:
  /// **'A payoff planner for anyone juggling more than one loan at once.'**
  String get onboardBody1;

  /// No description provided for @onboardTitle2.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on your phone'**
  String get onboardTitle2;

  /// No description provided for @onboardBody2.
  ///
  /// In en, this message translates to:
  /// **'No account. Nothing sent to any server. Your debt information stays completely private.'**
  String get onboardBody2;

  /// No description provided for @onboardTitle3.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get onboardTitle3;

  /// No description provided for @onboardBody3.
  ///
  /// In en, this message translates to:
  /// **'1. Add your debts\n2. Pick a payoff strategy\n3. Follow the month-by-month plan'**
  String get onboardBody3;

  /// No description provided for @emptyStateTitle.
  ///
  /// In en, this message translates to:
  /// **'No debts recorded yet'**
  String get emptyStateTitle;

  /// No description provided for @emptyStateBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first debt to see the full picture and build your payoff plan.'**
  String get emptyStateBody;

  /// No description provided for @addFirstDebt.
  ///
  /// In en, this message translates to:
  /// **'Add your first debt'**
  String get addFirstDebt;

  /// No description provided for @totalBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Total debt'**
  String get totalBalanceLabel;

  /// No description provided for @minOnlyInfo.
  ///
  /// In en, this message translates to:
  /// **'Paying only the minimum: debt-free by {date}, total interest paid {amount}.'**
  String minOnlyInfo(String date, String amount);

  /// No description provided for @minOnlyNeverInfo.
  ///
  /// In en, this message translates to:
  /// **'At the current minimum payments, this debt will never go away. Set up a payoff plan.'**
  String get minOnlyNeverInfo;

  /// No description provided for @setupStrategyCta.
  ///
  /// In en, this message translates to:
  /// **'Set up a payoff plan'**
  String get setupStrategyCta;

  /// No description provided for @debtsListTitle.
  ///
  /// In en, this message translates to:
  /// **'Your debts'**
  String get debtsListTitle;

  /// No description provided for @ratePerYear.
  ///
  /// In en, this message translates to:
  /// **'{rate}%/yr'**
  String ratePerYear(String rate);

  /// No description provided for @paidPercentOfPrincipal.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of original balance paid off'**
  String paidPercentOfPrincipal(String percent);

  /// No description provided for @minimumTrapWarning.
  ///
  /// In en, this message translates to:
  /// **'At this payment, the balance won\'t go down — the payment doesn\'t even cover the interest.'**
  String get minimumTrapWarning;

  /// No description provided for @debtTypeCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get debtTypeCreditCard;

  /// No description provided for @debtTypeUnsecured.
  ///
  /// In en, this message translates to:
  /// **'Personal loan'**
  String get debtTypeUnsecured;

  /// No description provided for @debtTypeInstallment.
  ///
  /// In en, this message translates to:
  /// **'Installment loan'**
  String get debtTypeInstallment;

  /// No description provided for @debtTypeAppLoan.
  ///
  /// In en, this message translates to:
  /// **'App loan'**
  String get debtTypeAppLoan;

  /// No description provided for @debtTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get debtTypeOther;

  /// No description provided for @interestTypeDeclining.
  ///
  /// In en, this message translates to:
  /// **'Declining balance (on remaining balance)'**
  String get interestTypeDeclining;

  /// No description provided for @interestTypeFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed (on original amount)'**
  String get interestTypeFixed;

  /// No description provided for @editDebtTitleAdd.
  ///
  /// In en, this message translates to:
  /// **'Add debt'**
  String get editDebtTitleAdd;

  /// No description provided for @editDebtTitleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit debt'**
  String get editDebtTitleEdit;

  /// No description provided for @debtNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Debt name'**
  String get debtNameLabel;

  /// No description provided for @debtNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Visa credit card'**
  String get debtNameHint;

  /// No description provided for @debtNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a debt name'**
  String get debtNameRequired;

  /// No description provided for @debtTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Debt type'**
  String get debtTypeLabel;

  /// No description provided for @currentBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get currentBalanceLabel;

  /// No description provided for @interestRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Interest rate'**
  String get interestRateLabel;

  /// No description provided for @perYear.
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get perYear;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get perMonth;

  /// No description provided for @interestRateRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an interest rate'**
  String get interestRateRequired;

  /// No description provided for @interestTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'How interest is calculated'**
  String get interestTypeLabel;

  /// No description provided for @explainTooltip.
  ///
  /// In en, this message translates to:
  /// **'Explain'**
  String get explainTooltip;

  /// No description provided for @minPaymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Minimum payment / month'**
  String get minPaymentLabel;

  /// No description provided for @dueDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly due day'**
  String get dueDayLabel;

  /// No description provided for @dueDayItem.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String dueDayItem(String day);

  /// No description provided for @startDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Loan start date (optional)'**
  String get startDateLabel;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @noteOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptionalLabel;

  /// No description provided for @saveDebt.
  ///
  /// In en, this message translates to:
  /// **'Save debt'**
  String get saveDebt;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount'**
  String get amountRequired;

  /// No description provided for @effectiveRateDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'About the real interest rate'**
  String get effectiveRateDialogTitle;

  /// No description provided for @effectiveRateDialogBody.
  ///
  /// In en, this message translates to:
  /// **'You entered a fixed rate of {nominal}%/year.\n\nBecause fixed-rate interest is always calculated on the original amount (even as the balance goes down), the real rate you actually pay works out to about {effective}%/year — higher than the number you entered.'**
  String effectiveRateDialogBody(String nominal, String effective);

  /// No description provided for @reviewAgain.
  ///
  /// In en, this message translates to:
  /// **'Review again'**
  String get reviewAgain;

  /// No description provided for @understoodSave.
  ///
  /// In en, this message translates to:
  /// **'Understood, save'**
  String get understoodSave;

  /// No description provided for @interestTypeHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Two ways to calculate interest'**
  String get interestTypeHelpTitle;

  /// No description provided for @interestTypeHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Example: borrowing 10,000,000 at 1%/month interest:\n\n• Declining balance: the first month\'s interest is calculated on 10,000,000 = 100,000. Once the balance drops to 5,000,000, interest is only 50,000.\n\n• Fixed: interest is always calculated on the original 10,000,000 = 100,000 every month, even after the balance has gone down. Total interest paid ends up much higher.'**
  String get interestTypeHelpBody;

  /// No description provided for @chooseStrategyTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a strategy'**
  String get chooseStrategyTitle;

  /// No description provided for @snowballSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay off the smallest balance first — builds momentum fast'**
  String get snowballSubtitle;

  /// No description provided for @avalancheSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay off the highest interest rate first — saves the most money'**
  String get avalancheSubtitle;

  /// No description provided for @extraPerMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'Extra amount you can pay each month'**
  String get extraPerMonthLabel;

  /// No description provided for @extraPerMonthHint.
  ///
  /// In en, this message translates to:
  /// **'On top of the required minimum payments.'**
  String get extraPerMonthHint;

  /// No description provided for @projectedPayoffDate.
  ///
  /// In en, this message translates to:
  /// **'Debt-free by {date}'**
  String projectedPayoffDate(String date);

  /// No description provided for @afterMonthsDot.
  ///
  /// In en, this message translates to:
  /// **'In {months} months.'**
  String afterMonthsDot(String months);

  /// No description provided for @savedInterestVsMinimum.
  ///
  /// In en, this message translates to:
  /// **'Saves {amount} in interest compared to paying only the minimum.'**
  String savedInterestVsMinimum(String amount);

  /// No description provided for @notPayableWithin50Years.
  ///
  /// In en, this message translates to:
  /// **'At this extra payment amount, the debt can\'t be paid off within 50 years. Try increasing the extra amount per month.'**
  String get notPayableWithin50Years;

  /// No description provided for @viewDetailedRoadmap.
  ///
  /// In en, this message translates to:
  /// **'View detailed roadmap'**
  String get viewDetailedRoadmap;

  /// No description provided for @roadmapTitle.
  ///
  /// In en, this message translates to:
  /// **'Payoff roadmap'**
  String get roadmapTitle;

  /// No description provided for @tryAnotherScenario.
  ///
  /// In en, this message translates to:
  /// **'Try another scenario'**
  String get tryAnotherScenario;

  /// No description provided for @roadmapNotReachable.
  ///
  /// In en, this message translates to:
  /// **'At the current extra payment amount, the debt can\'t be paid off within the 50-year limit.\n\nGo back and increase the extra amount per month.'**
  String get roadmapNotReachable;

  /// No description provided for @strategyLabelLine.
  ///
  /// In en, this message translates to:
  /// **'Strategy: {strategy}'**
  String strategyLabelLine(String strategy);

  /// No description provided for @debtFreeBy.
  ///
  /// In en, this message translates to:
  /// **'Debt-free by {date}'**
  String debtFreeBy(String date);

  /// No description provided for @afterMonths.
  ///
  /// In en, this message translates to:
  /// **'In {months} months'**
  String afterMonths(String months);

  /// No description provided for @totalInterestLabel.
  ///
  /// In en, this message translates to:
  /// **'Total interest to be paid'**
  String get totalInterestLabel;

  /// No description provided for @totalSavedLabel.
  ///
  /// In en, this message translates to:
  /// **'Total saved'**
  String get totalSavedLabel;

  /// No description provided for @monthlyRoadmapTitle.
  ///
  /// In en, this message translates to:
  /// **'Month-by-month plan'**
  String get monthlyRoadmapTitle;

  /// No description provided for @focusedDebtLine.
  ///
  /// In en, this message translates to:
  /// **'Extra payment focused on: {name}'**
  String focusedDebtLine(String name);

  /// No description provided for @remainingAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} left'**
  String remainingAmount(String amount);

  /// No description provided for @debtFallbackName.
  ///
  /// In en, this message translates to:
  /// **'Debt'**
  String get debtFallbackName;

  /// No description provided for @currentDebtBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get currentDebtBalanceLabel;

  /// No description provided for @thisMonthInterestLabel.
  ///
  /// In en, this message translates to:
  /// **'This month\'s interest (estimate)'**
  String get thisMonthInterestLabel;

  /// No description provided for @dueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDateLabel;

  /// No description provided for @dueDayValue.
  ///
  /// In en, this message translates to:
  /// **'Day {day} of every month'**
  String dueDayValue(String day);

  /// No description provided for @noteRowLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteRowLabel;

  /// No description provided for @minimumTrapDetailWarning.
  ///
  /// In en, this message translates to:
  /// **'⚠ The minimum payment ({min}) is lower than the interest charged ({interest}). The balance won\'t go down if you only pay the minimum.'**
  String minimumTrapDetailWarning(String min, String interest);

  /// No description provided for @markPaidThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Mark this month as paid'**
  String get markPaidThisMonth;

  /// No description provided for @paymentHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get paymentHistoryTitle;

  /// No description provided for @recordPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Record a payment'**
  String get recordPaymentTitle;

  /// No description provided for @amountPaidLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount paid'**
  String get amountPaidLabel;

  /// No description provided for @paymentDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment date'**
  String get paymentDateLabel;

  /// No description provided for @paymentRecorded.
  ///
  /// In en, this message translates to:
  /// **'Payment recorded 👍'**
  String get paymentRecorded;

  /// No description provided for @deleteDebtTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this debt?'**
  String get deleteDebtTitle;

  /// No description provided for @deleteDebtBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from your list. Its payment history will also be deleted.'**
  String deleteDebtBody(String name);

  /// No description provided for @paidOff.
  ///
  /// In en, this message translates to:
  /// **'Paid off'**
  String get paidOff;

  /// No description provided for @deletedByMistake.
  ///
  /// In en, this message translates to:
  /// **'Deleted by mistake'**
  String get deletedByMistake;

  /// No description provided for @noPaymentsYet.
  ///
  /// In en, this message translates to:
  /// **'No payments recorded yet.'**
  String get noPaymentsYet;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Lighten Pro'**
  String get paywallTitle;

  /// No description provided for @paywallHeadline.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full debt payoff toolkit'**
  String get paywallHeadline;

  /// No description provided for @paywallSubheadline.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase, yours forever. No subscription.'**
  String get paywallSubheadline;

  /// No description provided for @proFeature1Title.
  ///
  /// In en, this message translates to:
  /// **'Compare multiple scenarios (what-if)'**
  String get proFeature1Title;

  /// No description provided for @proFeature1Body.
  ///
  /// In en, this message translates to:
  /// **'Line up different extra-payment amounts side by side to pick the best option.'**
  String get proFeature1Body;

  /// No description provided for @proFeature2Title.
  ///
  /// In en, this message translates to:
  /// **'Advanced progress charts'**
  String get proFeature2Title;

  /// No description provided for @proFeature2Body.
  ///
  /// In en, this message translates to:
  /// **'Track your balance trending down over time.'**
  String get proFeature2Body;

  /// No description provided for @proFeature3Title.
  ///
  /// In en, this message translates to:
  /// **'Export PDF report'**
  String get proFeature3Title;

  /// No description provided for @proFeature3Body.
  ///
  /// In en, this message translates to:
  /// **'Save your entire payoff roadmap.'**
  String get proFeature3Body;

  /// No description provided for @proFeature4Title.
  ///
  /// In en, this message translates to:
  /// **'Remove all ads'**
  String get proFeature4Title;

  /// No description provided for @proFeature4Body.
  ///
  /// In en, this message translates to:
  /// **'A clean, focused experience.'**
  String get proFeature4Body;

  /// No description provided for @upgradeProWithPrice.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro — {price}'**
  String upgradeProWithPrice(String price);

  /// No description provided for @upgradeProGeneric.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro — one-time purchase'**
  String get upgradeProGeneric;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @watchAdTempPro.
  ///
  /// In en, this message translates to:
  /// **'Watch an ad — unlock Pro for 24 hours'**
  String get watchAdTempPro;

  /// No description provided for @restorePurchase.
  ///
  /// In en, this message translates to:
  /// **'Restore purchase'**
  String get restorePurchase;

  /// No description provided for @adNotReady.
  ///
  /// In en, this message translates to:
  /// **'Ad isn\'t ready yet, try again in a moment.'**
  String get adNotReady;

  /// No description provided for @welcomeToPro.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Pro 💚'**
  String get welcomeToPro;

  /// No description provided for @purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase didn\'t go through, please try again.'**
  String get purchaseFailed;

  /// No description provided for @restoredPro.
  ///
  /// In en, this message translates to:
  /// **'Pro restored.'**
  String get restoredPro;

  /// No description provided for @noPreviousPurchase.
  ///
  /// In en, this message translates to:
  /// **'No previous purchase found.'**
  String get noPreviousPurchase;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @reminderSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment reminders'**
  String get reminderSectionTitle;

  /// No description provided for @enableReminder.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders'**
  String get enableReminder;

  /// No description provided for @reminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get reminded on each debt\'s due day'**
  String get reminderSubtitle;

  /// No description provided for @reminderTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get reminderTimeLabel;

  /// No description provided for @proSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Lighten Pro'**
  String get proSectionTitle;

  /// No description provided for @alreadyPro.
  ///
  /// In en, this message translates to:
  /// **'You\'re on Pro'**
  String get alreadyPro;

  /// No description provided for @tempProActive.
  ///
  /// In en, this message translates to:
  /// **'Pro temporarily unlocked'**
  String get tempProActive;

  /// No description provided for @upgradeProShort.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeProShort;

  /// No description provided for @thanksForSupport.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your support 💚'**
  String get thanksForSupport;

  /// No description provided for @tempProUntil.
  ///
  /// In en, this message translates to:
  /// **'Active until {time} — upgrade for permanent access'**
  String tempProUntil(String time);

  /// No description provided for @proSummary.
  ///
  /// In en, this message translates to:
  /// **'Compare scenarios, advanced charts, no ads'**
  String get proSummary;

  /// No description provided for @restorePurchasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore previous purchase'**
  String get restorePurchasesTitle;

  /// No description provided for @checkingPurchase.
  ///
  /// In en, this message translates to:
  /// **'Checking for purchases...'**
  String get checkingPurchase;

  /// No description provided for @privacySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacySectionTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'All your data stays on your device. No account, no data collection, nothing ever sent anywhere.'**
  String get privacyBody;

  /// No description provided for @languageSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSectionTitle;

  /// No description provided for @systemDefaultLanguage.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefaultLanguage;

  /// No description provided for @reminderChannelName.
  ///
  /// In en, this message translates to:
  /// **'Payment reminders'**
  String get reminderChannelName;

  /// No description provided for @reminderChannelDesc.
  ///
  /// In en, this message translates to:
  /// **'Reminds you of each debt\'s due day'**
  String get reminderChannelDesc;

  /// No description provided for @reminderNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Due today: {name}'**
  String reminderNotifTitle(String name);

  /// No description provided for @reminderNotifBody.
  ///
  /// In en, this message translates to:
  /// **'Today is the minimum payment due date for \"{name}\".'**
  String reminderNotifBody(String name);

  /// No description provided for @currencySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencySectionTitle;

  /// No description provided for @currencyAuto.
  ///
  /// In en, this message translates to:
  /// **'Automatic (based on language)'**
  String get currencyAuto;

  /// No description provided for @pdfMonthColumn.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get pdfMonthColumn;

  /// No description provided for @pdfInterestColumn.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get pdfInterestColumn;

  /// No description provided for @pdfBalanceColumn.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get pdfBalanceColumn;

  /// No description provided for @whatIfExtraFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Extra/month'**
  String get whatIfExtraFieldLabel;

  /// No description provided for @whatIfAddScenario.
  ///
  /// In en, this message translates to:
  /// **'Add scenario'**
  String get whatIfAddScenario;

  /// No description provided for @whatIfColumnScenario.
  ///
  /// In en, this message translates to:
  /// **'Scenario'**
  String get whatIfColumnScenario;

  /// No description provided for @whatIfColumnPayoffDate.
  ///
  /// In en, this message translates to:
  /// **'Debt-free'**
  String get whatIfColumnPayoffDate;

  /// No description provided for @whatIfColumnMonths.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get whatIfColumnMonths;

  /// No description provided for @whatIfColumnInterest.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get whatIfColumnInterest;

  /// No description provided for @proLockedCta.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Pro'**
  String get proLockedCta;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'id', 'pt', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'id':
      return AppLocalizationsId();
    case 'pt':
      return AppLocalizationsPt();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
