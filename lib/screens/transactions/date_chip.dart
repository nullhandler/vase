import 'package:flutter/material.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/transactions/trans_model.dart';

import '../widgets/txn_text.dart';

class DateChip extends StatelessWidget {
  final String label;
  final TransStats? transStats;

  const DateChip({Key? key, required this.label, required this.transStats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: [
              SizedBox(
                width: 85,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: TxnText(
                    amount: transStats?.income ?? 0,
                    customColor: AppColors.accentColor,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: TxnText(
                    amount: transStats?.expense ?? 0,
                    customColor: AppColors.errorColor,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
