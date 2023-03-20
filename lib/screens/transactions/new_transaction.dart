import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/dialogs/list_dialog.dart';
import 'package:vase/screens/transactions/new_trans_controller.dart';
import 'package:vase/screens/widgets/category_type_selector.dart';
import 'package:vase/widgets/focused_layout.dart';

import '../../utils.dart';
import '../accounts/accounts_model.dart';
import '../categories/category_model.dart';
import '../widgets/form_item.dart';

class NewTransaction extends StatelessWidget {
  const NewTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedLayout(
      appBarTitle: "New Transaction",
      isScrollable: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: GetBuilder<NewTransController>(
            init: NewTransController(),
            builder: (controller) {
              return Column(
                children: [
                  CategoryTypeSelector(
                    onSelect: controller.setTransactionType,
                    currentType: controller.transactionType,
                  ),
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
                    onTap: () async {
                      Category? category =
                          await ListDialog<Category>().showListDialog(
                        Utils.getCategories(
                            Get.find<DbController>().categories.value,
                            categoryTypeMap[
                                    controller.transactionType.toLowerCase()] ??
                                CategoryType.expense),
                      );
                      controller.setCategory(category);
                    },
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
                                initialDate: controller.transactionDate,
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
                                context: context,
                                initialTime: controller.transactionTime);
                            controller.setTime(time);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          controller.saveTransaction();
                          Get.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Add Transaction"),
                          ],
                        )),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
