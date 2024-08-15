import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../screens/user/user_controller.dart';

class Heading extends StatelessWidget {
  const Heading({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        title,
        style: TextStyle(
            color: Get.find<UserController>().monet.value
                ? AppColors.monetColorScheme.primary
                : AppColors.accentColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
