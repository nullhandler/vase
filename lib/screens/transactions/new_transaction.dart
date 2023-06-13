import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/dialogs/list_dialog.dart';
import 'package:vase/screens/transactions/new_trans_controller.dart';
import 'package:vase/screens/widgets/category_type_selector.dart';
import 'package:vase/widgets/focused_layout.dart';

import '../../utils.dart';
import '../../widgets/delete_action.dart';
import '../accounts/accounts_model.dart';
import '../categories/category_model.dart';
import '../widgets/form_item.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewTransController>(
        init: NewTransController(),
        builder: (controller) {
          return FocusedLayout(
            appBarTitle: "New Transaction",
            actions: controller.isEdit.value
                ? [
                    DeleteAction(
                        onTap: () {
                          controller.deleteTransaction();
                          Get.back();
                        },
                        thing:
                            'transaction ${Get.arguments['transaction'].desc}'),
                  ]
                : null,
            isScrollable: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CategoryTypeSelector(
                      onSelect: (categoryType) {
                        _formKey.currentState?.reset();
                        controller.setTransactionType(categoryType);
                      },
                      currentType: controller.categoryType,
                      showTransfer: true,
                    ),
                    Obx(() {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.categoryType.value ==
                              CategoryType.transfer) ...[
                            FormItem(
                              question: "From Account",
                              controller: controller.accountController,
                              validator: (acc) {
                                if (acc == null || acc.isEmpty) {
                                  return 'Transaction must have a "From Account" ';
                                }
                                return null;
                              },
                              onTap: () async {
                                controller.setAccount(await getAccount());
                              },
                            ),
                            FormItem(
                              question: "To Account",
                              controller: controller.toAccountController,
                              validator: (acc) {
                                if (acc == null || acc.isEmpty) {
                                  return 'Transaction must have a "To Account" ';
                                }
                                return null;
                              },
                              onTap: () async {
                                controller.setToAccount(await getAccount());
                              },
                            ),
                          ] else ...[
                            FormItem(
                              question: "Account",
                              controller: controller.accountController,
                              validator: (acc) {
                                if (acc == null || acc.isEmpty) {
                                  return 'Transaction must have an account ';
                                }
                                return null;
                              },
                              onTap: () async {
                                controller.setAccount(await getAccount());
                              },
                            ),
                            FormItem(
                              question: "Category",
                              controller: controller.categoryController,
                              validator: (cat) {
                                if (cat == null || cat.isEmpty) {
                                  return 'Transaction must have a category ';
                                }
                                return null;
                              },
                              onTap: () async {
                                final List<Category> categories =
                                    Utils.getCategories(
                                        Get.find<DbController>().categories,
                                        controller.categoryType.value);
                                if (categories.isEmpty) {
                                  Utils.showBottomSnackBar(
                                      title: Const.errorTitle,
                                      message:
                                          "Please add an category first to continue :) ",
                                      ic: const Icon(
                                        Icons.error_outline_rounded,
                                        color: AppColors.errorColor,
                                      ));
                                } else {
                                  Category? category =
                                      await ListDialog<Category>()
                                          .showListDialog(
                                    categories,
                                  );
                                  controller.setCategory(category);
                                }
                              },
                            ),
                          ]
                        ],
                      );
                    }),
                    FormItem(
                      question: "Amount",
                      controller: controller.amountController,
                      textInputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator: (amount) {
                        if (amount == null || amount.isEmpty) {
                          return 'A transaction without any amount? idts :(';
                        }
                        return null;
                      },
                    ),
                    FormItem(
                      question: "Description",
                      controller: controller.descController,
                      textInputType: TextInputType.name,
                      validator: (desc) {
                        if (desc == null || desc.isEmpty) {
                          return 'Add a short description';
                        }
                        return null;
                      },
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
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.saveTransaction();
                            Get.back();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add Transaction",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<Account?> getAccount() async {
    final List<Account> accounts =
        Get.find<DbController>().accounts.values.toList();
    if (accounts.isEmpty) {
      Utils.showBottomSnackBar(
          title: Const.errorTitle,
          message: "Please add an account first to continue :) ",
          ic: const Icon(
            Icons.error_outline_rounded,
            color: AppColors.errorColor,
          ));
    } else {
      Account? account = await ListDialog<Account>().showListDialog(
        accounts,
      );
      return account;
    }
    return null;
  }
}
