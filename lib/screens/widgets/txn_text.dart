import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/user/user_controller.dart';

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
    return GetBuilder<UserController>(builder: (controller) {
      final comma = controller.thousandSep.value;
      final decimal = controller.decimalSep.value;
      var f = NumberFormat("###,###.0#", "en_US");
      String amt = f.format(amount);
      if (decimal == 1 && comma == 0) {
        amt = amt.replaceAll('.', '@');
        amt = amt.replaceAll(',', '.');
        amt = amt.replaceAll('@', ',');
      } else if (comma == 0 && decimal == 0) {
        amt = amt.replaceAll(',', '.');
      } else if (comma == 1 && decimal == 1) {
        amt = amt.replaceAll('.', ',');
      }
      return Text(
        '${controller.currency.value}$amt',
        maxLines: 1,
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
    });
  }
}
