import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import 'txn_text.dart';

class StatsWidget extends StatelessWidget {
  final Map<String, double> statsMap;
  const StatsWidget({Key? key, required this.statsMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatItem(
                title: statsMap.keys.first,
                value: statsMap.values.first,
                customColor: AppColors.accentColor,
              ),
              _StatItem(
                title: statsMap.keys.elementAt(1),
                value: statsMap.values.elementAt(1),
                customColor: AppColors.errorColor,
              ),
              _StatItem(
                title: statsMap.keys.elementAt(2),
                value: statsMap.values.elementAt(2),
                showSign: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final double value;
  final Color? customColor;
  final bool showSign;
  const _StatItem(
      {Key? key,
      required this.title,
      required this.value,
      this.customColor,
      this.showSign = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: (Get.width - 40) * 0.3,
        child: Column(
          children: [
            Text(
              title,
            ),
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
                showSign: showSign,
              ),
            )
          ],
        ),
      ),
    );
  }
}
