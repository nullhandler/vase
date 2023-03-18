import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/widgets/focused_layout.dart';

import 'accounts_dialog.dart';
import 'accounts_model.dart';

class NewAccount extends StatelessWidget {
  NewAccount({Key? key}) : super(key: key);
  final AccountsController accountsController = Get.find();
  final TextEditingController accountName = TextEditingController();
  final TextEditingController accountType =
      TextEditingController(text: AccountType.savings.toS());
  final Rx<Account> account =
      Account(accountName: '', accountType: AccountType.savings).obs;

  @override
  Widget build(BuildContext context) {
    return FocusedLayout(
      appBarTitle: "New Account",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            FormItem(question: "Account Name", controller: accountName),
            FormItem(
              question: "Account Type",
              controller: accountType,
              onTap: () async {
                String? newAccountType = await Get.dialog(AlertDialog(
                    content: AccountsDialog<String>(
                  selectedAccount: account.value.accountType.toS(),
                  accounts: accountTypeMap.values.toList(),
                )));
                if (newAccountType != null) {
                  account.update((a) {
                    a?.accountType = accountTypeFromString(newAccountType);
                  });
                  accountType.text = newAccountType;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    account.value.accountName = accountName.text;
                    accountsController.save(account.value);
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Save"),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
