import 'package:flutter/material.dart';
import 'package:vase/colors.dart';

class TxnText extends StatelessWidget {
  const TxnText(
      {super.key,
      required this.amount,
      required,
      this.showDynamicColor = true,
      this.customColor,
      this.textAlign});

  final double amount;
  final bool showDynamicColor;
  final Color? customColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$amount',
      textAlign: textAlign,
      style: TextStyle(
        color: customColor ??
            (showDynamicColor
                ? (amount.isNegative
                    ? AppColors.errorColor
                    : AppColors.accentColor)
                : null),
      ),
    );
  }
}
