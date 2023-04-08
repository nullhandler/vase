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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FocusedLayout(
      appBarTitle: "New Account",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormItem(
                question: "Account Name",
                controller: accountName,
                validator: (acc) {
                  if (acc == null || acc.isEmpty) {
                    return 'Account has to have a name !';
                  }
                  return null;
                },
              ),
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        account.value.accountName = accountName.text;
                        accountsController.save(account.value);
                        Get.back();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
