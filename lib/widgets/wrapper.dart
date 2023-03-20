import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vase/colors.dart';

class ThemeWrapper extends StatelessWidget {
  final Widget child;
  const ThemeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: AppColors.darkGreyColor,
            systemNavigationBarColor: AppColors.darkGreyColor,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        child: child);
  }
}
