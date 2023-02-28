import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';

import 'accounts_model.dart';

class NewAccount extends StatelessWidget {
  NewAccount({Key? key}) : super(key: key);
  final AccountsController accountsController = Get.find();
  final TextEditingController accountName = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final Account account =
      Account(accountName: '', accountType: AccountType.savings);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Account"),
      ),
      body: Column(
        children: [
          FormItem(question: "Account Name", controller: accountName),
          FormItem(
            question: "Account Type",
            controller: accountType,
            onTap: () {},
          ),
          ElevatedButton(
              onPressed: () {
                account.accountName = accountName.text;
                accountsController.save(account);
                Get.back();
              },
              child: const Text("Save"))
        ],
      ),
    );
  }
}
