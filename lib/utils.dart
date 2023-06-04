import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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

    static Future<void> openLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static void showCustomBottomSheet(BuildContext context,
      {required Widget body , bool? dismissable}) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: dismissable??true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SizedBox(
              //height: height,
              child: body,
            ),
          );
        });
  }
}
