import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:habit_wallet_lite/features/summary/presentation/providers/summary_provider.dart'; // for charts

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});
@override
Widget build(BuildContext context, WidgetRef ref) {
  final summary = ref.watch(summaryProvider); 
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monthly Transaction Details',style: TextStyle(fontWeight:FontWeight.bold),),
          SizedBox(height: 5,),
          Text('Total Income: ₹${summary.totalIncome.toStringAsFixed(2)}'),
          Text('Total Expense: ₹${summary.totalExpense.toStringAsFixed(2)}'),
          Text('Balance: ₹${summary.balance.toStringAsFixed(2)}'),
          const SizedBox(height: 20),
          const Text('Category Breakdown:'),
          const SizedBox(height: 10),
          // Chart widget
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: summary.categoryBreakdown.values.isEmpty
                    ? 0
                    : summary.categoryBreakdown.values.reduce((a, b) => a > b ? a : b) * 1.2,
                barGroups: summary.categoryBreakdown.entries
                    .map(
                      (e) => BarChartGroupData(
                        x: summary.categoryBreakdown.keys.toList().indexOf(e.key),
                        barRods: [
                          BarChartRodData(
                            toY: e.value,
                            color: Colors.blue,
                            width: 20,
                          )
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    )
                    .toList(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final keyList = summary.categoryBreakdown.keys.toList();
                        if (value.toInt() < keyList.length) {
                          return Text(keyList[value.toInt()]);
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}