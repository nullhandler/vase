import 'package:flutter/material.dart';
import 'package:vase/colors.dart';

class TxnText extends StatelessWidget {
  const TxnText({super.key, required this.amount });
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text('$amount' , style: TextStyle(color: amount.isNegative?AppColors.errorColor:AppColors.accentColor),);
  }
}
