import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../engine/payoff_engine.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/enums.dart';
import '../utils/format.dart';

/// Xuất lộ trình trả nợ ra PDF (tính năng Pro). Dùng package `printing` để mở
/// thẳng sheet chia sẻ/in/lưu file — không cần tự xin quyền file system.
class PdfReportService {
  static Future<void> exportRoadmap({
    required AppLocalizations l10n,
    required CurrencyInfo currency,
    required Strategy strategy,
    required PayoffResult result,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Lighten',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text(l10n.roadmapTitle, style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 8),
            pw.Divider(),
          ],
        ),
        build: (context) => [
          pw.Text(l10n.strategyLabelLine(strategy.label)),
          pw.SizedBox(height: 4),
          if (result.payoffDate != null)
            pw.Text(l10n.debtFreeBy(formatMonthYear(result.payoffDate!)),
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.Text(l10n.afterMonths('${result.monthsToPayoff}')),
          pw.SizedBox(height: 4),
          pw.Text(
              '${l10n.totalInterestLabel}: ${formatMoney(result.totalInterest, currency)}'),
          pw.SizedBox(height: 16),
          pw.Text(l10n.monthlyRoadmapTitle,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            cellStyle: const pw.TextStyle(fontSize: 9),
            headers: [
              l10n.pdfMonthColumn,
              l10n.pdfInterestColumn,
              l10n.pdfBalanceColumn,
            ],
            data: result.months
                .map((m) => [
                      formatMonthYear(m.month),
                      formatMoney(m.totalInterest, currency),
                      formatMoney(m.totalRemaining, currency),
                    ])
                .toList(),
          ),
        ],
      ),
    );

    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'lighten_roadmap.pdf');
  }
}
