import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/transactions/trans_model.dart';
import 'package:vase/screens/widgets/txn_text.dart';

class MonthlyStatsWidget extends StatelessWidget {
  final Rx<TransStats> monthlyStats;

  const MonthlyStatsWidget({Key? key, required this.monthlyStats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRowItem(
                    "Income", monthlyStats.value.income, AppColors.accentColor),
                _buildRowItem("Expense", monthlyStats.value.expense,
                    AppColors.errorColor),
                _buildRowItem("Total", monthlyStats.value.total, null)
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRowItem(String title, double value, Color? customColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: (Get.width - 40) * 0.3,
        child: Column(
          children: [
            Text(title),
            const SizedBox(
              height: 4,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: TxnText(
                amount: value,
                customColor: customColor,
                showDynamicColor: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
