import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';

import 'accounts_model.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({Key? key}) : super(key: key);
  final DbController dbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountsController>(
      init: AccountsController(),
      builder: (GetxController controller) {
        return Obx(() {
          return ListView.builder(
              itemCount: dbController.accounts.length,
              itemBuilder: (context, pos) {
                Account account = dbController.accounts[pos];
                return Text("${account.accountName} ${account.accountType}");
              });
        });
      },
    );
  }
}
