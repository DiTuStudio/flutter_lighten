// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get start => 'Bắt đầu';

  @override
  String get continueLabel => 'Tiếp tục';

  @override
  String get cancel => 'Huỷ';

  @override
  String get save => 'Lưu';

  @override
  String get gotIt => 'Đã hiểu';

  @override
  String get onboardTitle1 => 'Thoát nợ, từng bước một';

  @override
  String get onboardBody1 =>
      'Công cụ lập kế hoạch trả nợ cho người có nhiều khoản vay cùng lúc.';

  @override
  String get onboardTitle2 => 'Dữ liệu chỉ ở trên máy bạn';

  @override
  String get onboardBody2 =>
      'Không tài khoản. Không gửi lên server nào. Mọi thông tin nợ của bạn được giữ riêng tư tuyệt đối.';

  @override
  String get onboardTitle3 => 'Cách hoạt động';

  @override
  String get onboardBody3 =>
      '1. Nhập các khoản nợ\n2. Chọn chiến lược trả nợ\n3. Theo lộ trình từng tháng';

  @override
  String get emptyStateTitle => 'Chưa có khoản nợ nào được ghi nhận';

  @override
  String get emptyStateBody =>
      'Thêm khoản nợ đầu tiên để nhìn được toàn cảnh và lập lộ trình thoát nợ.';

  @override
  String get addFirstDebt => 'Thêm khoản nợ đầu tiên';

  @override
  String get totalBalanceLabel => 'Tổng nợ hiện tại';

  @override
  String minOnlyInfo(String date, String amount) {
    return 'Nếu chỉ trả tối thiểu: hết nợ vào $date, tổng lãi phải trả $amount.';
  }

  @override
  String get minOnlyNeverInfo =>
      'Với mức trả tối thiểu hiện tại, nợ sẽ không bao giờ giảm hết. Hãy thiết lập lộ trình trả thêm.';

  @override
  String get setupStrategyCta => 'Thiết lập lộ trình trả nợ';

  @override
  String get debtsListTitle => 'Các khoản nợ';

  @override
  String ratePerYear(String rate) {
    return '$rate%/năm';
  }

  @override
  String paidPercentOfPrincipal(String percent) {
    return 'Đã trả $percent% gốc ban đầu';
  }

  @override
  String get minimumTrapWarning =>
      'Với mức trả này, nợ sẽ không giảm — tiền trả chưa đủ bù lãi.';

  @override
  String get debtTypeCreditCard => 'Thẻ tín dụng';

  @override
  String get debtTypeUnsecured => 'Vay tín chấp';

  @override
  String get debtTypeInstallment => 'Trả góp';

  @override
  String get debtTypeAppLoan => 'Vay qua app';

  @override
  String get debtTypeOther => 'Khác';

  @override
  String get interestTypeDeclining => 'Giảm dần (trên dư nợ còn lại)';

  @override
  String get interestTypeFixed => 'Cố định (trên gốc ban đầu)';

  @override
  String get editDebtTitleAdd => 'Thêm khoản nợ';

  @override
  String get editDebtTitleEdit => 'Sửa khoản nợ';

  @override
  String get debtNameLabel => 'Tên khoản nợ';

  @override
  String get debtNameHint => 'VD: Thẻ tín dụng Vietcombank';

  @override
  String get debtNameRequired => 'Nhập tên khoản nợ';

  @override
  String get debtTypeLabel => 'Loại nợ';

  @override
  String get currentBalanceLabel => 'Số dư hiện tại';

  @override
  String get interestRateLabel => 'Lãi suất';

  @override
  String get perYear => '/năm';

  @override
  String get perMonth => '/tháng';

  @override
  String get interestRateRequired => 'Nhập lãi suất';

  @override
  String get interestTypeLabel => 'Cách tính lãi';

  @override
  String get explainTooltip => 'Giải thích';

  @override
  String get minPaymentLabel => 'Trả tối thiểu / tháng';

  @override
  String get dueDayLabel => 'Ngày đến hạn hàng tháng';

  @override
  String dueDayItem(String day) {
    return 'Ngày $day';
  }

  @override
  String get startDateLabel => 'Ngày bắt đầu vay (không bắt buộc)';

  @override
  String get selectDate => 'Chọn ngày';

  @override
  String get noteOptionalLabel => 'Ghi chú (không bắt buộc)';

  @override
  String get saveDebt => 'Lưu khoản nợ';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get amountRequired => 'Nhập số tiền';

  @override
  String get effectiveRateDialogTitle => 'Lưu ý về lãi suất thực';

  @override
  String effectiveRateDialogBody(String nominal, String effective) {
    return 'Bạn nhập lãi cố định $nominal%/năm.\n\nVì lãi cố định luôn tính trên gốc ban đầu (dù dư nợ đã giảm), lãi suất thực bạn thực sự gánh tương đương khoảng $effective%/năm — cao hơn con số bạn vừa nhập.';
  }

  @override
  String get reviewAgain => 'Xem lại';

  @override
  String get understoodSave => 'Đã hiểu, lưu';

  @override
  String get interestTypeHelpTitle => 'Hai cách tính lãi';

  @override
  String get interestTypeHelpBody =>
      'Ví dụ vay 10.000.000, lãi 1%/tháng:\n\n• Giảm dần: tháng đầu lãi tính trên 10.000.000 = 100.000. Khi dư nợ giảm còn 5.000.000, lãi chỉ còn 50.000.\n\n• Cố định: lãi luôn tính trên 10.000.000 gốc ban đầu = 100.000 mỗi tháng, kể cả khi dư nợ đã giảm. Tổng lãi phải trả cao hơn nhiều.';

  @override
  String get chooseStrategyTitle => 'Chọn chiến lược';

  @override
  String get snowballSubtitle =>
      'Trả khoản nhỏ nhất trước — tạo động lực nhanh';

  @override
  String get avalancheSubtitle =>
      'Trả khoản lãi cao nhất trước — tiết kiệm tiền nhất';

  @override
  String get extraPerMonthLabel => 'Số tiền dư có thể trả thêm mỗi tháng';

  @override
  String get extraPerMonthHint => 'Ngoài các khoản trả tối thiểu bắt buộc.';

  @override
  String projectedPayoffDate(String date) {
    return 'Dự kiến hết nợ vào $date';
  }

  @override
  String afterMonthsDot(String months) {
    return 'Sau $months tháng.';
  }

  @override
  String savedInterestVsMinimum(String amount) {
    return 'Tiết kiệm $amount tiền lãi so với chỉ trả tối thiểu.';
  }

  @override
  String get notPayableWithin50Years =>
      'Với số tiền dư hiện tại, nợ vẫn chưa thể trả hết trong 50 năm. Hãy thử tăng số tiền trả thêm mỗi tháng.';

  @override
  String get viewDetailedRoadmap => 'Xem lộ trình chi tiết';

  @override
  String get roadmapTitle => 'Lộ trình trả nợ';

  @override
  String get tryAnotherScenario => 'Thử kịch bản khác';

  @override
  String get roadmapNotReachable =>
      'Với số tiền trả thêm hiện tại, nợ chưa thể trả hết trong giới hạn 50 năm.\n\nHãy quay lại và tăng số tiền trả thêm mỗi tháng.';

  @override
  String strategyLabelLine(String strategy) {
    return 'Chiến lược: $strategy';
  }

  @override
  String debtFreeBy(String date) {
    return 'Hết nợ vào $date';
  }

  @override
  String afterMonths(String months) {
    return 'Sau $months tháng';
  }

  @override
  String get totalInterestLabel => 'Tổng lãi sẽ trả';

  @override
  String get totalSavedLabel => 'Tiết kiệm được';

  @override
  String get monthlyRoadmapTitle => 'Lộ trình theo tháng';

  @override
  String focusedDebtLine(String name) {
    return 'Ưu tiên dồn tiền: $name';
  }

  @override
  String remainingAmount(String amount) {
    return 'còn $amount';
  }

  @override
  String get debtFallbackName => 'Khoản nợ';

  @override
  String get currentDebtBalanceLabel => 'Dư nợ hiện tại';

  @override
  String get thisMonthInterestLabel => 'Lãi tháng này (ước tính)';

  @override
  String get dueDateLabel => 'Ngày đến hạn';

  @override
  String dueDayValue(String day) {
    return 'Ngày $day hàng tháng';
  }

  @override
  String get noteRowLabel => 'Ghi chú';

  @override
  String minimumTrapDetailWarning(String min, String interest) {
    return '⚠ Mức trả tối thiểu ($min) thấp hơn lãi phát sinh ($interest). Nợ sẽ không giảm nếu chỉ trả tối thiểu.';
  }

  @override
  String get markPaidThisMonth => 'Đánh dấu đã trả tháng này';

  @override
  String get paymentHistoryTitle => 'Lịch sử thanh toán';

  @override
  String get recordPaymentTitle => 'Ghi nhận thanh toán';

  @override
  String get amountPaidLabel => 'Số tiền đã trả';

  @override
  String get paymentDateLabel => 'Ngày trả';

  @override
  String get paymentRecorded => 'Đã ghi nhận thanh toán 👍';

  @override
  String get deleteDebtTitle => 'Xoá khoản nợ?';

  @override
  String deleteDebtBody(String name) {
    return 'Xoá \"$name\" khỏi danh sách. Lịch sử thanh toán của khoản này cũng sẽ bị xoá.';
  }

  @override
  String get paidOff => 'Đã trả hết';

  @override
  String get deletedByMistake => 'Xoá nhầm';

  @override
  String get noPaymentsYet => 'Chưa có lần thanh toán nào được ghi nhận.';

  @override
  String get paywallTitle => 'Lighten Pro';

  @override
  String get paywallHeadline => 'Mở khoá toàn bộ công cụ thoát nợ';

  @override
  String get paywallSubheadline =>
      'Mua đứt một lần, dùng mãi mãi. Không thuê bao.';

  @override
  String get proFeature1Title => 'So sánh nhiều kịch bản (what-if)';

  @override
  String get proFeature1Body =>
      'Đặt cạnh nhau các mức tiền trả thêm khác nhau để chọn phương án tối ưu.';

  @override
  String get proFeature2Title => 'Biểu đồ tiến độ nâng cao';

  @override
  String get proFeature2Body => 'Theo dõi đường nợ giảm dần theo thời gian.';

  @override
  String get proFeature3Title => 'Xuất báo cáo PDF';

  @override
  String get proFeature3Body => 'Lưu lại toàn bộ lộ trình trả nợ.';

  @override
  String get proFeature4Title => 'Tắt toàn bộ quảng cáo';

  @override
  String get proFeature4Body => 'Trải nghiệm gọn gàng, tập trung.';

  @override
  String upgradeProWithPrice(String price) {
    return 'Nâng cấp Pro — $price';
  }

  @override
  String get upgradeProGeneric => 'Nâng cấp Pro — mua một lần';

  @override
  String get or => 'hoặc';

  @override
  String get watchAdTempPro => 'Xem quảng cáo — mở Pro 24 giờ';

  @override
  String get restorePurchase => 'Khôi phục giao dịch';

  @override
  String get adNotReady => 'Quảng cáo chưa sẵn sàng, thử lại sau giây lát.';

  @override
  String get welcomeToPro => 'Chào mừng bạn đến với Pro 💚';

  @override
  String get purchaseFailed => 'Mua chưa thành công, thử lại nhé.';

  @override
  String get restoredPro => 'Đã khôi phục Pro.';

  @override
  String get noPreviousPurchase => 'Không tìm thấy giao dịch trước đó.';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get reminderSectionTitle => 'Nhắc lịch thanh toán';

  @override
  String get enableReminder => 'Bật nhắc lịch';

  @override
  String get reminderSubtitle => 'Nhắc vào ngày đến hạn từng khoản nợ';

  @override
  String get reminderTimeLabel => 'Giờ nhắc';

  @override
  String get proSectionTitle => 'Lighten Pro';

  @override
  String get alreadyPro => 'Bạn đang dùng Pro';

  @override
  String get tempProActive => 'Đang mở Pro tạm thời';

  @override
  String get upgradeProShort => 'Nâng cấp Pro';

  @override
  String get thanksForSupport => 'Cảm ơn bạn đã ủng hộ 💚';

  @override
  String tempProUntil(String time) {
    return 'Còn hiệu lực tới $time — nâng cấp để dùng vĩnh viễn';
  }

  @override
  String get proSummary =>
      'So sánh nhiều kịch bản, biểu đồ nâng cao, tắt quảng cáo';

  @override
  String get restorePurchasesTitle => 'Khôi phục giao dịch đã mua';

  @override
  String get checkingPurchase => 'Đang kiểm tra giao dịch...';

  @override
  String get privacySectionTitle => 'Quyền riêng tư';

  @override
  String get privacyBody =>
      'Toàn bộ dữ liệu chỉ lưu trên máy bạn. Không tài khoản, không thu thập, không gửi dữ liệu đi đâu.';

  @override
  String get languageSectionTitle => 'Ngôn ngữ';

  @override
  String get systemDefaultLanguage => 'Theo hệ thống';

  @override
  String get reminderChannelName => 'Nhắc thanh toán';

  @override
  String get reminderChannelDesc => 'Nhắc ngày đến hạn các khoản nợ';

  @override
  String reminderNotifTitle(String name) {
    return 'Đến hạn: $name';
  }

  @override
  String reminderNotifBody(String name) {
    return 'Hôm nay là ngày trả tối thiểu cho khoản \"$name\".';
  }

  @override
  String get currencySectionTitle => 'Đơn vị tiền tệ';

  @override
  String get currencyAuto => 'Tự động (theo ngôn ngữ)';

  @override
  String get pdfMonthColumn => 'Tháng';

  @override
  String get pdfInterestColumn => 'Lãi';

  @override
  String get pdfBalanceColumn => 'Dư nợ';

  @override
  String get whatIfExtraFieldLabel => 'Trả thêm/tháng';

  @override
  String get whatIfAddScenario => 'Thêm kịch bản';

  @override
  String get whatIfColumnScenario => 'Kịch bản';

  @override
  String get whatIfColumnPayoffDate => 'Hết nợ';

  @override
  String get whatIfColumnMonths => 'Số tháng';

  @override
  String get whatIfColumnInterest => 'Tiền lãi';

  @override
  String get proLockedCta => 'Mở khoá với Pro';
}
