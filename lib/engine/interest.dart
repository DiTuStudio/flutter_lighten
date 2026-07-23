/// Các hàm quy đổi & tính lãi suất.
library;

/// Quy đổi lãi suất %/tháng sang %/năm (nhân đơn giản, khớp cách hiểu phổ thông ở VN).
double monthlyToAnnual(double monthlyPercent) => monthlyPercent * 12;

/// Quy đổi lãi suất %/năm sang %/tháng.
double annualToMonthly(double annualPercent) => annualPercent / 12;

/// Quy đổi lãi suất "cố định" (tính trên gốc) sang lãi suất thực xấp xỉ (APR).
///
/// Công thức xấp xỉ chuẩn: r_thực ≈ 2 × n × r_cố_định / (n + 1)
/// với `n` = số kỳ trả góp còn lại. Trả về cùng đơn vị với [fixedRatePercent].
///
/// Ý nghĩa: vì lãi cố định luôn tính trên gốc ban đầu (dù dư nợ đã giảm),
/// lãi suất thực mà người vay gánh chịu cao hơn con số ghi trên hợp đồng.
double effectiveRateFromFixed(double fixedRatePercent, int periods) {
  if (periods <= 0) return fixedRatePercent;
  return 2 * periods * fixedRatePercent / (periods + 1);
}

/// Lãi phát sinh trong 1 tháng.
///
/// - Lãi giảm dần: tính trên [currentBalance].
/// - Lãi cố định: tính trên [originalPrincipal].
double monthlyInterest({
  required double annualRatePercent,
  required double currentBalance,
  required double originalPrincipal,
  required bool isFixed,
}) {
  final monthlyRate = annualRatePercent / 100 / 12;
  final base = isFixed ? originalPrincipal : currentBalance;
  return base * monthlyRate;
}
