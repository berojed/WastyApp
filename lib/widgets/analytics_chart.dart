import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/review.dart';

class AnalyticsChart extends StatelessWidget {
  final List<Review> reviews;
  const AnalyticsChart({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    // Count sentiments
    final positive = reviews.where((r) => r.sentiment == 'Positive').length;
    final neutral  = reviews.where((r) => r.sentiment == 'Neutral').length;
    final negative = reviews.where((r) => r.sentiment == 'Negative').length;
    final important = reviews.where((r) => r.isImportant==true).length;

    final maxCount = [positive, neutral, negative,important].reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 450,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceEvenly,
          maxY: (maxCount + 1).toDouble(),
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Positive');
                    case 1:
                      return const Text('Neutral');
                    case 2:
                      return const Text('Negative');
                    case 3:
                      return const Text('Important');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
          ),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: positive.toDouble(), width: 28, borderRadius: BorderRadius.circular(8))]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: neutral.toDouble(), width: 28, borderRadius: BorderRadius.circular(8))]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: negative.toDouble(), width: 28, borderRadius: BorderRadius.circular(8))]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: important.toDouble(), width: 28, borderRadius: BorderRadius.circular(8))]),
          ],
        ),
      ),
    );
  }
}
