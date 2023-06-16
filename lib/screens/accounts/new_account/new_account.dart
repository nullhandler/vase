import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';
import 'package:vase/screens/accounts/new_account/new_account_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/widgets/focused_layout.dart';

import '../../../colors.dart';
import '../../../const.dart';
import '../../../controllers/db_controller.dart';
import '../../../utils.dart';
import '../../../widgets/delete_action.dart';
import '../../dialogs/list_dialog.dart';
import '../accounts_dialog.dart';
import '../accounts_model.dart';

class NewAccount extends StatelessWidget {
  NewAccount({Key? key}) : super(key: key);
  final AccountsController accountsController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetX<NewAccountController>(
        init: NewAccountController(),
        builder: (controller) {
          return Scaffold(
              body: CustomScrollView(slivers: [
            SliverAppBar(
              title: Text(
                "${controller.isEdit.value ? "Edit" : "New"} Account",
              ),
              actions: controller.isEdit.value
                  ? [
                      DeleteAction(
                          onTap: () {
                            controller.deleteAccount();
                            Get.back();
                          },
                          thing:
                              'account ${Get.arguments['account'].accountName}'),
                    ]
                  : null,
            ),
            SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      // return FocusedLayout(
                      //   appBarTitle: "${controller.isEdit.value ? "Edit" : "New"} Account",
                      //   actions: controller.isEdit.value
                      //       ? [
                      //           DeleteAction(
                      //               onTap: () {
                      //                 controller.deleteAccount();
                      //                 Get.back();
                      //               },
                      //               thing:
                      //                   'account ${Get.arguments['account'].accountName}'),
                      //         ]
                      //       : null,
                      //   child:
                      Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormItem(
                          question: "Account Name",
                          controller: controller.accountName,
                          validator: (acc) {
                            if (acc == null || acc.isEmpty) {
                              return 'Account has to have a name !';
                            }
                            return null;
                          },
                        ),
                        FormItem(
                          question: "Account Type",
                          controller: controller.accountType,
                          onTap: () async {
                            String? newAccountType =
                                await Get.dialog(AlertDialog(
                                    content: AccountsDialog<String>(
                              selectedAccount:
                                  controller.account.value.accountType.toS(),
                              accounts: accountTypeMap.values.toList(),
                            )));
                            controller.onAccountTypeSelect(newAccountType);
                          },
                        ),
                        Obx(() {
                          if (controller.shouldShowParentAccount) {
                            return FormItem(
                              question: "Parent Account",
                              controller: controller.parentAccountName,
                              onTap: () async {
                                final List<Account> accounts =
                                    Get.find<DbController>()
                                        .accounts
                                        .values
                                        .toList();
                                if (accounts.isEmpty) {
                                  Utils.showBottomSnackBar(
                                      title: Const.errorTitle,
                                      message:
                                          "Please add an account first to continue :) ",
                                      ic: const Icon(
                                        Icons.error_outline_rounded,
                                        color: AppColors.errorColor,
                                      ));
                                } else {
                                  if (controller.account.value.id != null) {
                                    accounts.removeWhere((element) =>
                                        element.id ==
                                        controller.account.value.id);
                                  }
                                  Account? newParentAccount =
                                      await ListDialog<Account>()
                                          .showListDialog(
                                    accounts,
                                  );
                                  controller
                                      .onParentAccountSelect(newParentAccount);
                                }
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.save();
                                Get.back();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${controller.isEdit.value ? "Update" : "Save"} Account",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ))
          ]));
        });
  }
}
