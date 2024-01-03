import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';

import 'colors.dart';
import 'screens/categories/category_model.dart';

class Utils {
  static List<Category> getCategories(
      List<Category> categories, CategoryType categoryType) {
    return categories
        .where((element) =>
            (element.categoryType == categoryType && element.isDeleted == 0))
        .toList();
  }

  static void showBottomSnackBar(
      {required String title, required String message, required Icon ic}) {
    Get.snackbar(
      title,
      message,
      icon: ic,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.darkGreyColor,
    );
  }

  static void showSnackBarV2({required String msg, bool isPositiveMsg = true}) {
    Utils.showBottomSnackBar(
        title: isPositiveMsg ? Const.successTitle : Const.errorTitle,
        message: msg,
        ic: isPositiveMsg
            ? const Icon(
                Icons.check_circle_outline,
                color: AppColors.successColor,
              )
            : const Icon(
                Icons.error_outline_rounded,
                color: AppColors.errorColor,
              ));
  }

  static Future<void> openLink(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<ShareResult> exportDb() async {
    return await Share.shareXFiles([XFile(await getDbPath())]);
  }

  static Future<bool> importDb() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles();

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        if (!file.path.endsWith('.db')) return false;
        DbController dbController = Get.find();
        await dbController.db.close();
        file.copySync(await getDbPath());
        await dbController.initDB();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  static Future<String> getDbPath() async {
    return join(await getDatabasesPath(), 'vase.db');
  }

  static void showCustomBottomSheet(BuildContext context,
      {required Widget body, bool? dismissable}) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: dismissable ?? true,
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

  static int getFirstDate(DateTime currentDate) {
    return DateTime(currentDate.year, currentDate.month, 1)
        .millisecondsSinceEpoch;
  }

  static int getLastDate(DateTime currentDate) {
    DateTime dateTime = DateTime(currentDate.year, currentDate.month + 1, 0);
    return dateTime.millisecondsSinceEpoch;
  }

  static DateTime getNextMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
  }
}
