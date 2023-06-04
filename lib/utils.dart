import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vase/const.dart';
import 'colors.dart';
import 'screens/categories/category_model.dart';

class Utils {
  static List<Category> getCategories(List<Category> categories, CategoryType categoryType) {
    return categories.where((element) => element.categoryType == categoryType).toList();
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


    static Future<void> openLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
