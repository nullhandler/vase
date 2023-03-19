import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vase/colors.dart';

Widget themeWrapper({required Widget child}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
          statusBarColor: AppColors.darkGreyColor,
          systemNavigationBarColor: AppColors.darkGreyColor,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light),
      child: child);
}