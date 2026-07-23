// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get start => 'Mulai';

  @override
  String get continueLabel => 'Lanjut';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get gotIt => 'Mengerti';

  @override
  String get onboardTitle1 => 'Bebas utang, selangkah demi selangkah';

  @override
  String get onboardBody1 =>
      'Perencana pelunasan utang untuk siapa saja yang punya lebih dari satu pinjaman sekaligus.';

  @override
  String get onboardTitle2 => 'Data kamu tetap di ponsel kamu';

  @override
  String get onboardBody2 =>
      'Tanpa akun. Tidak ada yang dikirim ke server mana pun. Informasi utang kamu sepenuhnya privat.';

  @override
  String get onboardTitle3 => 'Cara kerjanya';

  @override
  String get onboardBody3 =>
      '1. Tambahkan utang kamu\n2. Pilih strategi pelunasan\n3. Ikuti rencana bulan demi bulan';

  @override
  String get emptyStateTitle => 'Belum ada utang yang dicatat';

  @override
  String get emptyStateBody =>
      'Tambahkan utang pertamamu untuk melihat gambaran lengkap dan menyusun rencana pelunasan.';

  @override
  String get addFirstDebt => 'Tambahkan utang pertama';

  @override
  String get totalBalanceLabel => 'Total utang';

  @override
  String minOnlyInfo(String date, String amount) {
    return 'Jika hanya bayar minimum: lunas pada $date, total bunga yang dibayar $amount.';
  }

  @override
  String get minOnlyNeverInfo =>
      'Dengan pembayaran minimum saat ini, utang ini tidak akan pernah lunas. Susun rencana pelunasan.';

  @override
  String get setupStrategyCta => 'Susun rencana pelunasan';

  @override
  String get debtsListTitle => 'Daftar utang';

  @override
  String ratePerYear(String rate) {
    return '$rate%/tahun';
  }

  @override
  String paidPercentOfPrincipal(String percent) {
    return '$percent% dari pokok awal telah dibayar';
  }

  @override
  String get minimumTrapWarning =>
      'Dengan pembayaran ini, saldo tidak akan berkurang — pembayaran belum cukup menutup bunga.';

  @override
  String get debtTypeCreditCard => 'Kartu kredit';

  @override
  String get debtTypeUnsecured => 'Pinjaman tanpa agunan';

  @override
  String get debtTypeInstallment => 'Cicilan';

  @override
  String get debtTypeAppLoan => 'Pinjaman online (pinjol)';

  @override
  String get debtTypeOther => 'Lainnya';

  @override
  String get interestTypeDeclining => 'Menurun (atas sisa saldo)';

  @override
  String get interestTypeFixed => 'Tetap (atas pokok awal)';

  @override
  String get editDebtTitleAdd => 'Tambah utang';

  @override
  String get editDebtTitleEdit => 'Edit utang';

  @override
  String get debtNameLabel => 'Nama utang';

  @override
  String get debtNameHint => 'cth. Kartu kredit BCA';

  @override
  String get debtNameRequired => 'Masukkan nama utang';

  @override
  String get debtTypeLabel => 'Jenis utang';

  @override
  String get currentBalanceLabel => 'Saldo saat ini';

  @override
  String get interestRateLabel => 'Suku bunga';

  @override
  String get perYear => '/tahun';

  @override
  String get perMonth => '/bulan';

  @override
  String get interestRateRequired => 'Masukkan suku bunga';

  @override
  String get interestTypeLabel => 'Cara perhitungan bunga';

  @override
  String get explainTooltip => 'Penjelasan';

  @override
  String get minPaymentLabel => 'Pembayaran minimum / bulan';

  @override
  String get dueDayLabel => 'Tanggal jatuh tempo bulanan';

  @override
  String dueDayItem(String day) {
    return 'Tanggal $day';
  }

  @override
  String get startDateLabel => 'Tanggal mulai pinjaman (opsional)';

  @override
  String get selectDate => 'Pilih tanggal';

  @override
  String get noteOptionalLabel => 'Catatan (opsional)';

  @override
  String get saveDebt => 'Simpan utang';

  @override
  String get saveChanges => 'Simpan perubahan';

  @override
  String get amountRequired => 'Masukkan jumlah';

  @override
  String get effectiveRateDialogTitle => 'Tentang bunga efektif sebenarnya';

  @override
  String effectiveRateDialogBody(String nominal, String effective) {
    return 'Kamu memasukkan bunga tetap $nominal%/tahun.\n\nKarena bunga tetap selalu dihitung dari pokok awal (meskipun saldo sudah berkurang), bunga efektif yang sebenarnya kamu tanggung setara dengan sekitar $effective%/tahun — lebih tinggi dari angka yang kamu masukkan.';
  }

  @override
  String get reviewAgain => 'Tinjau lagi';

  @override
  String get understoodSave => 'Mengerti, simpan';

  @override
  String get interestTypeHelpTitle => 'Dua cara menghitung bunga';

  @override
  String get interestTypeHelpBody =>
      'Contoh: pinjam 10.000.000 dengan bunga 1%/bulan:\n\n• Menurun: bunga bulan pertama dihitung dari 10.000.000 = 100.000. Saat saldo turun jadi 5.000.000, bunga tinggal 50.000.\n\n• Tetap: bunga selalu dihitung dari pokok awal 10.000.000 = 100.000 setiap bulan, meskipun saldo sudah berkurang. Total bunga yang dibayar jadi jauh lebih besar.';

  @override
  String get chooseStrategyTitle => 'Pilih strategi';

  @override
  String get snowballSubtitle =>
      'Lunasi saldo terkecil dulu — cepat membangun motivasi';

  @override
  String get avalancheSubtitle =>
      'Lunasi bunga tertinggi dulu — paling hemat uang';

  @override
  String get extraPerMonthLabel =>
      'Jumlah ekstra yang bisa kamu bayar tiap bulan';

  @override
  String get extraPerMonthHint => 'Di luar pembayaran minimum wajib.';

  @override
  String projectedPayoffDate(String date) {
    return 'Diperkirakan lunas pada $date';
  }

  @override
  String afterMonthsDot(String months) {
    return 'Dalam $months bulan.';
  }

  @override
  String savedInterestVsMinimum(String amount) {
    return 'Menghemat $amount bunga dibanding hanya bayar minimum.';
  }

  @override
  String get notPayableWithin50Years =>
      'Dengan jumlah ekstra ini, utang belum bisa lunas dalam 50 tahun. Coba naikkan jumlah ekstra per bulan.';

  @override
  String get viewDetailedRoadmap => 'Lihat rencana lengkap';

  @override
  String get roadmapTitle => 'Rencana pelunasan';

  @override
  String get tryAnotherScenario => 'Coba skenario lain';

  @override
  String get roadmapNotReachable =>
      'Dengan jumlah ekstra saat ini, utang belum bisa lunas dalam batas 50 tahun.\n\nKembali dan naikkan jumlah ekstra per bulan.';

  @override
  String strategyLabelLine(String strategy) {
    return 'Strategi: $strategy';
  }

  @override
  String debtFreeBy(String date) {
    return 'Lunas pada $date';
  }

  @override
  String afterMonths(String months) {
    return 'Dalam $months bulan';
  }

  @override
  String get totalInterestLabel => 'Total bunga yang harus dibayar';

  @override
  String get totalSavedLabel => 'Total hemat';

  @override
  String get monthlyRoadmapTitle => 'Rencana per bulan';

  @override
  String focusedDebtLine(String name) {
    return 'Pembayaran ekstra difokuskan ke: $name';
  }

  @override
  String remainingAmount(String amount) {
    return 'sisa $amount';
  }

  @override
  String get debtFallbackName => 'Utang';

  @override
  String get currentDebtBalanceLabel => 'Saldo saat ini';

  @override
  String get thisMonthInterestLabel => 'Bunga bulan ini (perkiraan)';

  @override
  String get dueDateLabel => 'Tanggal jatuh tempo';

  @override
  String dueDayValue(String day) {
    return 'Tanggal $day tiap bulan';
  }

  @override
  String get noteRowLabel => 'Catatan';

  @override
  String minimumTrapDetailWarning(String min, String interest) {
    return '⚠ Pembayaran minimum ($min) lebih rendah dari bunga yang timbul ($interest). Saldo tidak akan berkurang jika hanya bayar minimum.';
  }

  @override
  String get markPaidThisMonth => 'Tandai sudah dibayar bulan ini';

  @override
  String get paymentHistoryTitle => 'Riwayat pembayaran';

  @override
  String get recordPaymentTitle => 'Catat pembayaran';

  @override
  String get amountPaidLabel => 'Jumlah dibayar';

  @override
  String get paymentDateLabel => 'Tanggal pembayaran';

  @override
  String get paymentRecorded => 'Pembayaran tercatat 👍';

  @override
  String get deleteDebtTitle => 'Hapus utang ini?';

  @override
  String deleteDebtBody(String name) {
    return 'Hapus \"$name\" dari daftar. Riwayat pembayarannya juga akan terhapus.';
  }

  @override
  String get paidOff => 'Sudah lunas';

  @override
  String get deletedByMistake => 'Terhapus tidak sengaja';

  @override
  String get noPaymentsYet => 'Belum ada pembayaran yang tercatat.';

  @override
  String get paywallTitle => 'Lighten Pro';

  @override
  String get paywallHeadline => 'Buka semua alat pelunasan utang';

  @override
  String get paywallSubheadline =>
      'Beli sekali, milikmu selamanya. Tanpa langganan.';

  @override
  String get proFeature1Title => 'Bandingkan beberapa skenario (what-if)';

  @override
  String get proFeature1Body =>
      'Bandingkan berbagai jumlah pembayaran ekstra berdampingan untuk memilih opsi terbaik.';

  @override
  String get proFeature2Title => 'Grafik progres tingkat lanjut';

  @override
  String get proFeature2Body =>
      'Pantau saldo yang terus menurun dari waktu ke waktu.';

  @override
  String get proFeature3Title => 'Ekspor laporan PDF';

  @override
  String get proFeature3Body => 'Simpan seluruh rencana pelunasanmu.';

  @override
  String get proFeature4Title => 'Hilangkan semua iklan';

  @override
  String get proFeature4Body => 'Pengalaman yang bersih dan fokus.';

  @override
  String upgradeProWithPrice(String price) {
    return 'Upgrade ke Pro — $price';
  }

  @override
  String get upgradeProGeneric => 'Upgrade ke Pro — beli sekali';

  @override
  String get or => 'atau';

  @override
  String get watchAdTempPro => 'Tonton iklan — buka Pro selama 24 jam';

  @override
  String get restorePurchase => 'Pulihkan pembelian';

  @override
  String get adNotReady => 'Iklan belum siap, coba lagi sesaat lagi.';

  @override
  String get welcomeToPro => 'Selamat datang di Pro 💚';

  @override
  String get purchaseFailed => 'Pembelian belum berhasil, coba lagi ya.';

  @override
  String get restoredPro => 'Pro berhasil dipulihkan.';

  @override
  String get noPreviousPurchase => 'Tidak ditemukan pembelian sebelumnya.';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get reminderSectionTitle => 'Pengingat pembayaran';

  @override
  String get enableReminder => 'Aktifkan pengingat';

  @override
  String get reminderSubtitle =>
      'Diingatkan pada tanggal jatuh tempo tiap utang';

  @override
  String get reminderTimeLabel => 'Waktu pengingat';

  @override
  String get proSectionTitle => 'Lighten Pro';

  @override
  String get alreadyPro => 'Kamu sudah Pro';

  @override
  String get tempProActive => 'Pro terbuka sementara';

  @override
  String get upgradeProShort => 'Upgrade ke Pro';

  @override
  String get thanksForSupport => 'Terima kasih atas dukunganmu 💚';

  @override
  String tempProUntil(String time) {
    return 'Aktif sampai $time — upgrade untuk akses permanen';
  }

  @override
  String get proSummary => 'Bandingkan skenario, grafik lanjutan, tanpa iklan';

  @override
  String get restorePurchasesTitle => 'Pulihkan pembelian sebelumnya';

  @override
  String get checkingPurchase => 'Memeriksa pembelian...';

  @override
  String get privacySectionTitle => 'Privasi';

  @override
  String get privacyBody =>
      'Semua datamu tetap di perangkatmu. Tanpa akun, tanpa pengumpulan data, tidak ada yang dikirim ke mana pun.';

  @override
  String get languageSectionTitle => 'Bahasa';

  @override
  String get systemDefaultLanguage => 'Default sistem';

  @override
  String get reminderChannelName => 'Pengingat pembayaran';

  @override
  String get reminderChannelDesc =>
      'Mengingatkan tanggal jatuh tempo tiap utang';

  @override
  String reminderNotifTitle(String name) {
    return 'Jatuh tempo hari ini: $name';
  }

  @override
  String reminderNotifBody(String name) {
    return 'Hari ini adalah tanggal jatuh tempo pembayaran minimum untuk \"$name\".';
  }

  @override
  String get currencySectionTitle => 'Mata uang';

  @override
  String get currencyAuto => 'Otomatis (berdasarkan bahasa)';

  @override
  String get pdfMonthColumn => 'Bulan';

  @override
  String get pdfInterestColumn => 'Bunga';

  @override
  String get pdfBalanceColumn => 'Saldo';

  @override
  String get whatIfExtraFieldLabel => 'Ekstra/bulan';

  @override
  String get whatIfAddScenario => 'Tambah skenario';

  @override
  String get whatIfColumnScenario => 'Skenario';

  @override
  String get whatIfColumnPayoffDate => 'Lunas';

  @override
  String get whatIfColumnMonths => 'Bulan';

  @override
  String get whatIfColumnInterest => 'Bunga';

  @override
  String get proLockedCta => 'Buka dengan Pro';
}
