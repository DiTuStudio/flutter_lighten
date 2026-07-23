// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get start => 'Começar';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get gotIt => 'Entendi';

  @override
  String get onboardTitle1 => 'Saia das dívidas, um passo de cada vez';

  @override
  String get onboardBody1 =>
      'Um planejador de quitação para quem lida com mais de um empréstimo ao mesmo tempo.';

  @override
  String get onboardTitle2 => 'Seus dados ficam só no seu celular';

  @override
  String get onboardBody2 =>
      'Sem conta. Nada é enviado a nenhum servidor. Suas informações de dívidas ficam completamente privadas.';

  @override
  String get onboardTitle3 => 'Como funciona';

  @override
  String get onboardBody3 =>
      '1. Adicione suas dívidas\n2. Escolha uma estratégia de quitação\n3. Siga o plano mês a mês';

  @override
  String get emptyStateTitle => 'Nenhuma dívida registrada ainda';

  @override
  String get emptyStateBody =>
      'Adicione sua primeira dívida para ver o panorama completo e montar seu plano de quitação.';

  @override
  String get addFirstDebt => 'Adicionar primeira dívida';

  @override
  String get totalBalanceLabel => 'Dívida total';

  @override
  String minOnlyInfo(String date, String amount) {
    return 'Pagando só o mínimo: livre de dívidas em $date, total de juros pagos $amount.';
  }

  @override
  String get minOnlyNeverInfo =>
      'Com os pagamentos mínimos atuais, essa dívida nunca vai acabar. Configure um plano de quitação.';

  @override
  String get setupStrategyCta => 'Configurar um plano de quitação';

  @override
  String get debtsListTitle => 'Suas dívidas';

  @override
  String ratePerYear(String rate) {
    return '$rate%/ano';
  }

  @override
  String paidPercentOfPrincipal(String percent) {
    return '$percent% do saldo original já pago';
  }

  @override
  String get minimumTrapWarning =>
      'Com esse pagamento, o saldo não vai diminuir — o valor pago nem cobre os juros.';

  @override
  String get debtTypeCreditCard => 'Cartão de crédito';

  @override
  String get debtTypeUnsecured => 'Empréstimo pessoal';

  @override
  String get debtTypeInstallment => 'Parcelamento';

  @override
  String get debtTypeAppLoan => 'Empréstimo por app';

  @override
  String get debtTypeOther => 'Outro';

  @override
  String get interestTypeDeclining =>
      'Saldo decrescente (sobre o saldo restante)';

  @override
  String get interestTypeFixed => 'Fixo (sobre o valor original)';

  @override
  String get editDebtTitleAdd => 'Adicionar dívida';

  @override
  String get editDebtTitleEdit => 'Editar dívida';

  @override
  String get debtNameLabel => 'Nome da dívida';

  @override
  String get debtNameHint => 'ex.: Cartão de crédito Nubank';

  @override
  String get debtNameRequired => 'Digite o nome da dívida';

  @override
  String get debtTypeLabel => 'Tipo de dívida';

  @override
  String get currentBalanceLabel => 'Saldo atual';

  @override
  String get interestRateLabel => 'Taxa de juros';

  @override
  String get perYear => '/ano';

  @override
  String get perMonth => '/mês';

  @override
  String get interestRateRequired => 'Digite a taxa de juros';

  @override
  String get interestTypeLabel => 'Como os juros são calculados';

  @override
  String get explainTooltip => 'Explicar';

  @override
  String get minPaymentLabel => 'Pagamento mínimo / mês';

  @override
  String get dueDayLabel => 'Dia de vencimento mensal';

  @override
  String dueDayItem(String day) {
    return 'Dia $day';
  }

  @override
  String get startDateLabel => 'Data de início do empréstimo (opcional)';

  @override
  String get selectDate => 'Selecionar data';

  @override
  String get noteOptionalLabel => 'Observação (opcional)';

  @override
  String get saveDebt => 'Salvar dívida';

  @override
  String get saveChanges => 'Salvar alterações';

  @override
  String get amountRequired => 'Digite um valor';

  @override
  String get effectiveRateDialogTitle => 'Sobre a taxa de juros real';

  @override
  String effectiveRateDialogBody(String nominal, String effective) {
    return 'Você digitou uma taxa fixa de $nominal%/ano.\n\nComo os juros fixos são sempre calculados sobre o valor original (mesmo com o saldo caindo), a taxa real que você paga equivale a cerca de $effective%/ano — mais alta que o número que você digitou.';
  }

  @override
  String get reviewAgain => 'Revisar de novo';

  @override
  String get understoodSave => 'Entendi, salvar';

  @override
  String get interestTypeHelpTitle => 'Duas formas de calcular juros';

  @override
  String get interestTypeHelpBody =>
      'Exemplo: empréstimo de 10.000.000 com juros de 1%/mês:\n\n• Saldo decrescente: o juro do primeiro mês é calculado sobre 10.000.000 = 100.000. Quando o saldo cai para 5.000.000, o juro passa a ser só 50.000.\n\n• Fixo: o juro é sempre calculado sobre os 10.000.000 originais = 100.000 todo mês, mesmo com o saldo já reduzido. O total de juros pagos acaba sendo bem maior.';

  @override
  String get chooseStrategyTitle => 'Escolha uma estratégia';

  @override
  String get snowballSubtitle =>
      'Pague primeiro o menor saldo — cria motivação rápida';

  @override
  String get avalancheSubtitle =>
      'Pague primeiro a maior taxa de juros — economiza mais dinheiro';

  @override
  String get extraPerMonthLabel => 'Valor extra que você pode pagar por mês';

  @override
  String get extraPerMonthHint => 'Além dos pagamentos mínimos obrigatórios.';

  @override
  String projectedPayoffDate(String date) {
    return 'Livre de dívidas em $date';
  }

  @override
  String afterMonthsDot(String months) {
    return 'Em $months meses.';
  }

  @override
  String savedInterestVsMinimum(String amount) {
    return 'Economiza $amount em juros comparado a pagar só o mínimo.';
  }

  @override
  String get notPayableWithin50Years =>
      'Com esse valor extra, a dívida não pode ser quitada em 50 anos. Tente aumentar o valor extra mensal.';

  @override
  String get viewDetailedRoadmap => 'Ver plano detalhado';

  @override
  String get roadmapTitle => 'Plano de quitação';

  @override
  String get tryAnotherScenario => 'Tentar outro cenário';

  @override
  String get roadmapNotReachable =>
      'Com o valor extra atual, a dívida não pode ser quitada dentro do limite de 50 anos.\n\nVolte e aumente o valor extra mensal.';

  @override
  String strategyLabelLine(String strategy) {
    return 'Estratégia: $strategy';
  }

  @override
  String debtFreeBy(String date) {
    return 'Livre de dívidas em $date';
  }

  @override
  String afterMonths(String months) {
    return 'Em $months meses';
  }

  @override
  String get totalInterestLabel => 'Total de juros a pagar';

  @override
  String get totalSavedLabel => 'Total economizado';

  @override
  String get monthlyRoadmapTitle => 'Plano mês a mês';

  @override
  String focusedDebtLine(String name) {
    return 'Pagamento extra focado em: $name';
  }

  @override
  String remainingAmount(String amount) {
    return 'faltam $amount';
  }

  @override
  String get debtFallbackName => 'Dívida';

  @override
  String get currentDebtBalanceLabel => 'Saldo atual';

  @override
  String get thisMonthInterestLabel => 'Juros deste mês (estimativa)';

  @override
  String get dueDateLabel => 'Data de vencimento';

  @override
  String dueDayValue(String day) {
    return 'Dia $day de cada mês';
  }

  @override
  String get noteRowLabel => 'Observação';

  @override
  String minimumTrapDetailWarning(String min, String interest) {
    return '⚠ O pagamento mínimo ($min) é menor que os juros gerados ($interest). O saldo não vai diminuir se você só pagar o mínimo.';
  }

  @override
  String get markPaidThisMonth => 'Marcar como pago este mês';

  @override
  String get paymentHistoryTitle => 'Histórico de pagamentos';

  @override
  String get recordPaymentTitle => 'Registrar pagamento';

  @override
  String get amountPaidLabel => 'Valor pago';

  @override
  String get paymentDateLabel => 'Data do pagamento';

  @override
  String get paymentRecorded => 'Pagamento registrado 👍';

  @override
  String get deleteDebtTitle => 'Excluir esta dívida?';

  @override
  String deleteDebtBody(String name) {
    return 'Remove \"$name\" da sua lista. O histórico de pagamentos dela também será excluído.';
  }

  @override
  String get paidOff => 'Já quitada';

  @override
  String get deletedByMistake => 'Excluída por engano';

  @override
  String get noPaymentsYet => 'Nenhum pagamento registrado ainda.';

  @override
  String get paywallTitle => 'Lighten Pro';

  @override
  String get paywallHeadline =>
      'Desbloqueie todas as ferramentas de quitação de dívidas';

  @override
  String get paywallSubheadline =>
      'Compra única, é seu para sempre. Sem assinatura.';

  @override
  String get proFeature1Title => 'Compare vários cenários (what-if)';

  @override
  String get proFeature1Body =>
      'Compare diferentes valores extras de pagamento lado a lado para escolher a melhor opção.';

  @override
  String get proFeature2Title => 'Gráficos de progresso avançados';

  @override
  String get proFeature2Body => 'Acompanhe seu saldo caindo ao longo do tempo.';

  @override
  String get proFeature3Title => 'Exportar relatório em PDF';

  @override
  String get proFeature3Body => 'Salve todo o seu plano de quitação.';

  @override
  String get proFeature4Title => 'Remover todos os anúncios';

  @override
  String get proFeature4Body => 'Uma experiência limpa e focada.';

  @override
  String upgradeProWithPrice(String price) {
    return 'Fazer upgrade para o Pro — $price';
  }

  @override
  String get upgradeProGeneric => 'Fazer upgrade para o Pro — compra única';

  @override
  String get or => 'ou';

  @override
  String get watchAdTempPro =>
      'Assistir a um anúncio — libera o Pro por 24 horas';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get adNotReady =>
      'O anúncio ainda não está pronto, tente novamente em instantes.';

  @override
  String get welcomeToPro => 'Bem-vindo ao Pro 💚';

  @override
  String get purchaseFailed => 'A compra não foi concluída, tente novamente.';

  @override
  String get restoredPro => 'Pro restaurado.';

  @override
  String get noPreviousPurchase => 'Nenhuma compra anterior encontrada.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get reminderSectionTitle => 'Lembretes de pagamento';

  @override
  String get enableReminder => 'Ativar lembretes';

  @override
  String get reminderSubtitle =>
      'Receba um aviso no dia de vencimento de cada dívida';

  @override
  String get reminderTimeLabel => 'Horário do lembrete';

  @override
  String get proSectionTitle => 'Lighten Pro';

  @override
  String get alreadyPro => 'Você já é Pro';

  @override
  String get tempProActive => 'Pro liberado temporariamente';

  @override
  String get upgradeProShort => 'Fazer upgrade para o Pro';

  @override
  String get thanksForSupport => 'Obrigado pelo seu apoio 💚';

  @override
  String tempProUntil(String time) {
    return 'Ativo até $time — faça upgrade para acesso permanente';
  }

  @override
  String get proSummary => 'Compare cenários, gráficos avançados, sem anúncios';

  @override
  String get restorePurchasesTitle => 'Restaurar compra anterior';

  @override
  String get checkingPurchase => 'Verificando compras...';

  @override
  String get privacySectionTitle => 'Privacidade';

  @override
  String get privacyBody =>
      'Todos os seus dados ficam só no seu aparelho. Sem conta, sem coleta de dados, nada é enviado para lugar nenhum.';

  @override
  String get languageSectionTitle => 'Idioma';

  @override
  String get systemDefaultLanguage => 'Padrão do sistema';

  @override
  String get reminderChannelName => 'Lembretes de pagamento';

  @override
  String get reminderChannelDesc => 'Lembra o dia de vencimento de cada dívida';

  @override
  String reminderNotifTitle(String name) {
    return 'Vence hoje: $name';
  }

  @override
  String reminderNotifBody(String name) {
    return 'Hoje é o vencimento do pagamento mínimo de \"$name\".';
  }

  @override
  String get currencySectionTitle => 'Moeda';

  @override
  String get currencyAuto => 'Automático (com base no idioma)';

  @override
  String get pdfMonthColumn => 'Mês';

  @override
  String get pdfInterestColumn => 'Juros';

  @override
  String get pdfBalanceColumn => 'Saldo';

  @override
  String get whatIfExtraFieldLabel => 'Extra/mês';

  @override
  String get whatIfAddScenario => 'Adicionar cenário';

  @override
  String get whatIfColumnScenario => 'Cenário';

  @override
  String get whatIfColumnPayoffDate => 'Livre de dívidas';

  @override
  String get whatIfColumnMonths => 'Meses';

  @override
  String get whatIfColumnInterest => 'Juros';

  @override
  String get proLockedCta => 'Desbloquear com o Pro';
}
