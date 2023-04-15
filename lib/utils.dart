import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';

import 'colors.dart';
import 'screens/categories/category_model.dart';
import 'screens/widgets/txn_text.dart';

class Utils {
  static List<Category> getCategories(List<Category> categories, CategoryType categoryType) {
    return categories.where((element) => element.categoryType == categoryType).toList();
  }

  static Widget dateChip(String label, Color color, double total) {
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
          child: TxnText(
            amount: total,
          ),
        ),
      ],
    );
  }

  static void showBottomSnackBar({
    required String title,
    required String message,
    required Icon ic,
  }) {
    Get.snackbar(
      Const.errorTitle,
      message,
      icon: ic,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.darkGreyColor,
    );
  }

  static Color getPieChartColor(double percentage) {
    if (percentage < 0.1) {
      return Colors.grey;
    } else if (percentage < 0.2) {
      return Colors.blueGrey;
    } else if (percentage < 0.3) {
      return Colors.blue;
    } else if (percentage < 0.4) {
      return Colors.green;
    } else if (percentage < 0.5) {
      return Colors.yellow;
    } else if (percentage < 0.6) {
      return Colors.orange;
    } else if (percentage < 0.7) {
      return Colors.deepOrange;
    } else if (percentage < 0.8) {
      return Colors.red;
    } else if (percentage < 0.9) {
      return Colors.pink;
    } else {
      return Colors.purple;
    }
  }
}
