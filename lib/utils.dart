import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';

import 'colors.dart';
import 'screens/categories/category_model.dart';

class Utils {
  static List<Category> getCategories(
      List<Category> categories, CategoryType categoryType) {
    return categories
        .where((element) => element.categoryType == categoryType)
        .toList();
  }

  static Widget dateChip(String label, Color color) {
    return Row(
      children: [
        const SizedBox(
          width: 40,
          child: Divider(color: Colors.grey, thickness: 0.4),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const Expanded(
          child: Divider(color: Colors.grey, thickness: 0.4),
        ),
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
