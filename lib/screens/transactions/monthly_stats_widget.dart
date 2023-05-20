import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/transactions/trans_model.dart';
import 'package:vase/screens/widgets/stats_widget.dart';

class MonthlyStatsWidget extends StatelessWidget {
  final Rx<TransStats> monthlyStats;

  const MonthlyStatsWidget({Key? key, required this.monthlyStats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatsWidget(statsMap: {
      "Income": monthlyStats.value.income,
      "Expense": monthlyStats.value.expense,
      "Total": monthlyStats.value.total
    });
  }
}
