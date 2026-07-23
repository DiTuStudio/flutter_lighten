import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../engine/payoff_engine.dart';
import '../theme.dart';
import '../utils/format.dart';

/// Biểu đồ đường thể hiện tổng dư nợ giảm dần theo từng tháng trong lộ trình
/// (tính năng Pro — xem `proFeature2Title`/`proFeature2Body`).
class DebtProgressChart extends StatelessWidget {
  final List<MonthSnapshot> months;
  final CurrencyInfo currency;

  const DebtProgressChart({super.key, required this.months, required this.currency});

  @override
  Widget build(BuildContext context) {
    if (months.isEmpty) return const SizedBox.shrink();

    final spots = <FlSpot>[
      for (int i = 0; i < months.length; i++) FlSpot(i.toDouble(), months[i].totalRemaining),
    ];
    final maxY =
        months.map((m) => m.totalRemaining).fold<double>(0, (a, b) => b > a ? b : a);
    final xStep = (months.length / 4).ceil().clamp(1, months.length).toDouble();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxY <= 0 ? 1 : maxY * 1.1,
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: xStep,
                getTitlesWidget: (value, meta) {
                  final i = value.round();
                  if (i < 0 || i >= months.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(formatMonthYear(months[i].month),
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.textSecondary)),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 52,
                getTitlesWidget: (value, meta) => Text(
                  formatMoneyShort(value, currency),
                  style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true, color: AppColors.primary.withValues(alpha: 0.12)),
            ),
          ],
        ),
      ),
    );
  }
}
