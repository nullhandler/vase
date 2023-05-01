import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../colors.dart';

class DeleteAction extends StatelessWidget {
  const DeleteAction({Key? key, required this.onTap, required this.thing})
      : super(key: key);
  final Function() onTap;
  final String thing;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outlined, color: AppColors.errorColor),
      onPressed: () {
        Get.dialog(AlertDialog(
          title: const Text("Are you sure ? "),
          content: Text("This will delete the $thing permanently"),
          actions: [
            TextButton(
                onPressed: (){
                  onTap();
                  Get.back();
                },
                child: const Text(
                  "Yes , Delete",
                  style: TextStyle(color: AppColors.errorColor),
                )),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("No"))
          ],
        ));
      },
    );
  }
}
