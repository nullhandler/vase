import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';
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
        child: SingleChildScrollView(
          child: GetBuilder<NewTransController>(
            init: NewTransController(),
            builder: (controller) {
              return Column(
                children: [
                  FormItem(
                    question: "Account",
                    controller: controller.accountController,
                    onTap: () async {
                      Account? account =
                          await ListDialog<Account>().showListDialog(
                        Get.find<DbController>().accounts.value,
                      );
                      controller.setAccount(account);
                    },
                  ),
                  FormItem(
                    question: "Category",
                    controller: controller.categoryController,
                  ),
                  FormItem(
                    question: "Amount",
                    controller: controller.amountController,
                    textInputType: TextInputType.number,
                  ),
                  FormItem(
                    question: "Description",
                    controller: controller.descController,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 6,
                        child: FormItem(
                          question: "Date",
                          controller: controller.dateController,
                          onTap: () async {
                            DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000, 2, 13),
                                lastDate: DateTime(2100, 2, 13));
                            controller.setDate(dateTime);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 4,
                        child: FormItem(
                          question: "Time",
                          controller: controller.timeController,
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            controller.setTime(time);
                          },
                        ),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
