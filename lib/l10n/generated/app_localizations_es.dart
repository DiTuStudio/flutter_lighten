// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get start => 'Comenzar';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get gotIt => 'Entendido';

  @override
  String get onboardTitle1 => 'Sal de deudas, paso a paso';

  @override
  String get onboardBody1 =>
      'Un planificador de pagos para quienes manejan más de un préstamo a la vez.';

  @override
  String get onboardTitle2 => 'Tus datos se quedan en tu teléfono';

  @override
  String get onboardBody2 =>
      'Sin cuentas. Nada se envía a ningún servidor. Tu información de deudas permanece completamente privada.';

  @override
  String get onboardTitle3 => 'Cómo funciona';

  @override
  String get onboardBody3 =>
      '1. Agrega tus deudas\n2. Elige una estrategia de pago\n3. Sigue el plan mes a mes';

  @override
  String get emptyStateTitle => 'Aún no hay deudas registradas';

  @override
  String get emptyStateBody =>
      'Agrega tu primera deuda para ver el panorama completo y armar tu plan de pago.';

  @override
  String get addFirstDebt => 'Agregar tu primera deuda';

  @override
  String get totalBalanceLabel => 'Deuda total';

  @override
  String minOnlyInfo(String date, String amount) {
    return 'Pagando solo el mínimo: sin deudas para $date, intereses totales pagados $amount.';
  }

  @override
  String get minOnlyNeverInfo =>
      'Con los pagos mínimos actuales, esta deuda nunca desaparecerá. Configura un plan de pago.';

  @override
  String get setupStrategyCta => 'Configurar un plan de pago';

  @override
  String get debtsListTitle => 'Tus deudas';

  @override
  String ratePerYear(String rate) {
    return '$rate%/año';
  }

  @override
  String paidPercentOfPrincipal(String percent) {
    return '$percent% del saldo original pagado';
  }

  @override
  String get minimumTrapWarning =>
      'Con este pago, el saldo no bajará — el pago ni siquiera cubre los intereses.';

  @override
  String get debtTypeCreditCard => 'Tarjeta de crédito';

  @override
  String get debtTypeUnsecured => 'Préstamo personal';

  @override
  String get debtTypeInstallment => 'Préstamo a plazos';

  @override
  String get debtTypeAppLoan => 'Préstamo por app';

  @override
  String get debtTypeOther => 'Otro';

  @override
  String get interestTypeDeclining =>
      'Saldo decreciente (sobre el saldo restante)';

  @override
  String get interestTypeFixed => 'Fijo (sobre el monto original)';

  @override
  String get editDebtTitleAdd => 'Agregar deuda';

  @override
  String get editDebtTitleEdit => 'Editar deuda';

  @override
  String get debtNameLabel => 'Nombre de la deuda';

  @override
  String get debtNameHint => 'ej. Tarjeta de crédito Visa';

  @override
  String get debtNameRequired => 'Ingresa un nombre para la deuda';

  @override
  String get debtTypeLabel => 'Tipo de deuda';

  @override
  String get currentBalanceLabel => 'Saldo actual';

  @override
  String get interestRateLabel => 'Tasa de interés';

  @override
  String get perYear => '/año';

  @override
  String get perMonth => '/mes';

  @override
  String get interestRateRequired => 'Ingresa una tasa de interés';

  @override
  String get interestTypeLabel => 'Cómo se calcula el interés';

  @override
  String get explainTooltip => 'Explicar';

  @override
  String get minPaymentLabel => 'Pago mínimo / mes';

  @override
  String get dueDayLabel => 'Día de vencimiento mensual';

  @override
  String dueDayItem(String day) {
    return 'Día $day';
  }

  @override
  String get startDateLabel => 'Fecha de inicio del préstamo (opcional)';

  @override
  String get selectDate => 'Seleccionar fecha';

  @override
  String get noteOptionalLabel => 'Nota (opcional)';

  @override
  String get saveDebt => 'Guardar deuda';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get amountRequired => 'Ingresa un monto';

  @override
  String get effectiveRateDialogTitle => 'Sobre la tasa de interés real';

  @override
  String effectiveRateDialogBody(String nominal, String effective) {
    return 'Ingresaste una tasa fija de $nominal%/año.\n\nComo el interés fijo siempre se calcula sobre el monto original (aunque el saldo baje), la tasa real que realmente pagas equivale a cerca de $effective%/año — más alta que el número que ingresaste.';
  }

  @override
  String get reviewAgain => 'Revisar de nuevo';

  @override
  String get understoodSave => 'Entendido, guardar';

  @override
  String get interestTypeHelpTitle => 'Dos formas de calcular el interés';

  @override
  String get interestTypeHelpBody =>
      'Ejemplo: un préstamo de 10.000.000 con 1%/mes de interés:\n\n• Saldo decreciente: el interés del primer mes se calcula sobre 10.000.000 = 100.000. Cuando el saldo baja a 5.000.000, el interés es solo 50.000.\n\n• Fijo: el interés siempre se calcula sobre los 10.000.000 originales = 100.000 cada mes, incluso después de que el saldo haya bajado. El interés total termina siendo mucho más alto.';

  @override
  String get chooseStrategyTitle => 'Elige una estrategia';

  @override
  String get snowballSubtitle =>
      'Paga primero el saldo más pequeño — genera impulso rápido';

  @override
  String get avalancheSubtitle =>
      'Paga primero la tasa de interés más alta — ahorra más dinero';

  @override
  String get extraPerMonthLabel => 'Monto extra que puedes pagar cada mes';

  @override
  String get extraPerMonthHint => 'Además de los pagos mínimos obligatorios.';

  @override
  String projectedPayoffDate(String date) {
    return 'Sin deudas para $date';
  }

  @override
  String afterMonthsDot(String months) {
    return 'En $months meses.';
  }

  @override
  String savedInterestVsMinimum(String amount) {
    return 'Ahorra $amount en intereses comparado con pagar solo el mínimo.';
  }

  @override
  String get notPayableWithin50Years =>
      'Con este monto extra, la deuda no se puede pagar en 50 años. Intenta aumentar el monto extra mensual.';

  @override
  String get viewDetailedRoadmap => 'Ver plan detallado';

  @override
  String get roadmapTitle => 'Plan de pago';

  @override
  String get tryAnotherScenario => 'Probar otro escenario';

  @override
  String get roadmapNotReachable =>
      'Con el monto extra actual, la deuda no se puede pagar dentro del límite de 50 años.\n\nVuelve atrás y aumenta el monto extra mensual.';

  @override
  String strategyLabelLine(String strategy) {
    return 'Estrategia: $strategy';
  }

  @override
  String debtFreeBy(String date) {
    return 'Sin deudas para $date';
  }

  @override
  String afterMonths(String months) {
    return 'En $months meses';
  }

  @override
  String get totalInterestLabel => 'Interés total a pagar';

  @override
  String get totalSavedLabel => 'Total ahorrado';

  @override
  String get monthlyRoadmapTitle => 'Plan mes a mes';

  @override
  String focusedDebtLine(String name) {
    return 'Pago extra enfocado en: $name';
  }

  @override
  String remainingAmount(String amount) {
    return 'quedan $amount';
  }

  @override
  String get debtFallbackName => 'Deuda';

  @override
  String get currentDebtBalanceLabel => 'Saldo actual';

  @override
  String get thisMonthInterestLabel => 'Interés de este mes (estimado)';

  @override
  String get dueDateLabel => 'Fecha de vencimiento';

  @override
  String dueDayValue(String day) {
    return 'Día $day de cada mes';
  }

  @override
  String get noteRowLabel => 'Nota';

  @override
  String minimumTrapDetailWarning(String min, String interest) {
    return '⚠ El pago mínimo ($min) es menor que el interés generado ($interest). El saldo no bajará si solo pagas el mínimo.';
  }

  @override
  String get markPaidThisMonth => 'Marcar como pagado este mes';

  @override
  String get paymentHistoryTitle => 'Historial de pagos';

  @override
  String get recordPaymentTitle => 'Registrar un pago';

  @override
  String get amountPaidLabel => 'Monto pagado';

  @override
  String get paymentDateLabel => 'Fecha de pago';

  @override
  String get paymentRecorded => 'Pago registrado 👍';

  @override
  String get deleteDebtTitle => '¿Eliminar esta deuda?';

  @override
  String deleteDebtBody(String name) {
    return 'Se eliminará \"$name\" de tu lista. Su historial de pagos también se eliminará.';
  }

  @override
  String get paidOff => 'Ya pagada';

  @override
  String get deletedByMistake => 'Eliminada por error';

  @override
  String get noPaymentsYet => 'Aún no hay pagos registrados.';

  @override
  String get paywallTitle => 'Lighten Pro';

  @override
  String get paywallHeadline =>
      'Desbloquea todas las herramientas para salir de deudas';

  @override
  String get paywallSubheadline =>
      'Compra única, tuyo para siempre. Sin suscripción.';

  @override
  String get proFeature1Title => 'Compara varios escenarios (what-if)';

  @override
  String get proFeature1Body =>
      'Compara distintos montos de pago extra lado a lado para elegir la mejor opción.';

  @override
  String get proFeature2Title => 'Gráficos de progreso avanzados';

  @override
  String get proFeature2Body => 'Sigue cómo baja tu saldo con el tiempo.';

  @override
  String get proFeature3Title => 'Exportar informe en PDF';

  @override
  String get proFeature3Body => 'Guarda todo tu plan de pago.';

  @override
  String get proFeature4Title => 'Elimina todos los anuncios';

  @override
  String get proFeature4Body => 'Una experiencia limpia y enfocada.';

  @override
  String upgradeProWithPrice(String price) {
    return 'Mejorar a Pro — $price';
  }

  @override
  String get upgradeProGeneric => 'Mejorar a Pro — pago único';

  @override
  String get or => 'o';

  @override
  String get watchAdTempPro => 'Ver un anuncio — desbloquea Pro por 24 horas';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get adNotReady =>
      'El anuncio aún no está listo, intenta de nuevo en un momento.';

  @override
  String get welcomeToPro => 'Bienvenido a Pro 💚';

  @override
  String get purchaseFailed => 'La compra no se completó, intenta de nuevo.';

  @override
  String get restoredPro => 'Pro restaurado.';

  @override
  String get noPreviousPurchase => 'No se encontró ninguna compra anterior.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get reminderSectionTitle => 'Recordatorios de pago';

  @override
  String get enableReminder => 'Activar recordatorios';

  @override
  String get reminderSubtitle =>
      'Recibe un aviso en el día de vencimiento de cada deuda';

  @override
  String get reminderTimeLabel => 'Hora del recordatorio';

  @override
  String get proSectionTitle => 'Lighten Pro';

  @override
  String get alreadyPro => 'Tienes Pro';

  @override
  String get tempProActive => 'Pro desbloqueado temporalmente';

  @override
  String get upgradeProShort => 'Mejorar a Pro';

  @override
  String get thanksForSupport => 'Gracias por tu apoyo 💚';

  @override
  String tempProUntil(String time) {
    return 'Activo hasta $time — mejora para acceso permanente';
  }

  @override
  String get proSummary =>
      'Compara escenarios, gráficos avanzados, sin anuncios';

  @override
  String get restorePurchasesTitle => 'Restaurar compra anterior';

  @override
  String get checkingPurchase => 'Buscando compras...';

  @override
  String get privacySectionTitle => 'Privacidad';

  @override
  String get privacyBody =>
      'Todos tus datos permanecen en tu dispositivo. Sin cuentas, sin recopilación de datos, nada se envía a ningún lado.';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get systemDefaultLanguage => 'Predeterminado del sistema';

  @override
  String get reminderChannelName => 'Recordatorios de pago';

  @override
  String get reminderChannelDesc =>
      'Te recuerda el día de vencimiento de cada deuda';

  @override
  String reminderNotifTitle(String name) {
    return 'Vence hoy: $name';
  }

  @override
  String reminderNotifBody(String name) {
    return 'Hoy es la fecha límite del pago mínimo de \"$name\".';
  }

  @override
  String get currencySectionTitle => 'Moneda';

  @override
  String get currencyAuto => 'Automático (según el idioma)';

  @override
  String get pdfMonthColumn => 'Mes';

  @override
  String get pdfInterestColumn => 'Interés';

  @override
  String get pdfBalanceColumn => 'Saldo';

  @override
  String get whatIfExtraFieldLabel => 'Extra/mes';

  @override
  String get whatIfAddScenario => 'Agregar escenario';

  @override
  String get whatIfColumnScenario => 'Escenario';

  @override
  String get whatIfColumnPayoffDate => 'Sin deudas';

  @override
  String get whatIfColumnMonths => 'Meses';

  @override
  String get whatIfColumnInterest => 'Interés';

  @override
  String get proLockedCta => 'Desbloquear con Pro';
}
