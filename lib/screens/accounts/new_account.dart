import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';

import 'accounts_dialog.dart';
import 'accounts_model.dart';

class NewAccount extends StatelessWidget {
  NewAccount({Key? key}) : super(key: key);
  final AccountsController accountsController = Get.find();
  final TextEditingController accountName = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final Rx<Account> account =
      Account(accountName: '', accountType: AccountType.savings).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            FormItem(question: "Account Name", controller: accountName),
            Obx(
              () => Row(
                children: [
                  Text("Account Type: ${account.value.accountType.toS()}"),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      String? newAccountType = await Get.dialog(AlertDialog(
                          content: AccountsDialog(
                        selectedAccount: account.value.accountType.toS(),
                        accounts: accountTypeMap.values.toList(),
                      )));
                      if (newAccountType != null) {
                        account.update((a) {
                          a?.accountType =
                              accountTypeFromString(newAccountType);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
            // FormItem(
            //   question: "Account Type",
            //   controller: accountType,
            //   onTap: () {},
            // ),
            ElevatedButton(
                onPressed: () {
                  account.value.accountName = accountName.text;
                  accountsController.save(account.value);
                  Get.back();
                },
                child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
