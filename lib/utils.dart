import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';

import 'colors.dart';
import 'screens/categories/category_model.dart';
import 'screens/widgets/txn_text.dart';

class Utils {
  static List<Category> getCategories(
      List<Category> categories, CategoryType categoryType) {
    return categories
        .where((element) => element.categoryType == categoryType)
        .toList();
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
        // const Expanded(
        //   child: Divider(color: Colors.grey, thickness: 0.4),
        // ),
      ],
    );
  }

  static void showBottomSnackBar(
      {required String title, required String message, required Icon ic}) {
    Get.snackbar(
      Const.errorTitle,
      message,
      icon: ic,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.darkGreyColor,
    );
  }
}
