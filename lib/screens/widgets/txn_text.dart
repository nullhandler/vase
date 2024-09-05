import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/extensions.dart';

class TxnText extends StatelessWidget {
  const TxnText(
      {super.key,
      required this.amount,
      required,
      this.showDynamicColor = true,
      this.showSign = false,
      this.customColor,
      this.textAlign});

  final double amount;
  final bool showDynamicColor;
  final Color? customColor;
  final TextAlign? textAlign;
  final bool showSign;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(
          amount.s,
          maxLines: 1,
          textAlign: textAlign,
          style: TextStyle(
              color: customColor ??
                  (showDynamicColor
                      ? (amount.isNegative
                          ? AppColors.errorColor
                          : AppColors.accentColor)
                      : null),
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ));
  }
}
