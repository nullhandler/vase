import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';
import 'package:vase/screens/dialogs/list_dialog.dart';
import 'package:vase/screens/transactions/new_trans_controller.dart';

import '../accounts/accounts_model.dart';
import '../widgets/form_item.dart';

class NewTransaction extends StatelessWidget {
  const NewTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Transaction"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: GetBuilder<NewTransController>(
          init: NewTransController(),
          builder: (controller){
            return Column(
              children: [
                FormItem(question: "Account", controller: controller.accountController, onTap: () async{
                  Account? account = await ListDialog<Account>().showListDialog(Get.find<DbController>().accounts.value,);
                  print(account?.accountName);
                },),
                // FormItem(
                //   question: "Account Type",
                //   controller: accountType,
                //   onTap: () async {
                //     String? newAccountType = await Get.dialog(AlertDialog(
                //         content: AccountsDialog(
                //           selectedAccount: account.value.accountType.toS(),
                //           accounts: accountTypeMap.values.toList(),
                //         )));
                //     if (newAccountType != null) {
                //       account.update((a) {
                //         a?.accountType = accountTypeFromString(newAccountType);
                //       });
                //       accountType.text = newAccountType;
                //     }
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {
                        // account.value.accountName = accountName.text;
                        // controller.save(account.value);
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
            );
          },
        ),
      ),
    );
  }
}
