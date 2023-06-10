import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';

import '../../../const.dart';
import '../../../controllers/db_controller.dart';
import '../accounts_model.dart';

class NewAccountController extends GetxController {
  final TextEditingController accountName = TextEditingController();
  final TextEditingController parentAccountName = TextEditingController();
  final TextEditingController accountType =
      TextEditingController(text: AccountType.savings.toS());
  final Rx<Account> account =
      Account(accountName: '', accountType: AccountType.savings).obs;
  final Rx<Account> parentAccount =
      Account(accountName: '', accountType: AccountType.savings).obs;
  RxBool isEdit = false.obs;
  @override
  void onInit() {
    super.onInit();
    isEdit.value = Get.arguments?['edit'] ?? false;
    if (isEdit.value) {
      preFillAccount(Get.arguments['account']);
    }
  }

  void preFillAccount(Account oldAccount) {
    account.value.accountName = oldAccount.accountName;
    account.value.id = oldAccount.id;
    accountName.text = oldAccount.accountName;
    if (oldAccount.parentId != null) {
      onParentAccountSelect(
          Get.find<DbController>().accounts[oldAccount.parentId]);
    }
    onAccountTypeSelect(oldAccount.accountType.toS());
  }

  void onAccountTypeSelect(String? newAccountType) {
    if (newAccountType != null) {
      account.update((a) {
        AccountType accountType = accountTypeFromString(newAccountType);
        a?.accountType = accountType;
        if (accountType == AccountType.card) {
          account.value.parentId = null;
        }
      });
      accountType.text = newAccountType;
    }
  }

  void onParentAccountSelect(Account? newParentAccount) {
    if (newParentAccount != null) {
      parentAccountName.text = newParentAccount.accountName;
      account.value.parentId = newParentAccount.id;
    }
  }

  bool get shouldShowParentAccount {
    return account.value.accountType == AccountType.card;
  }

  Future<void> save() async {
    account.value.accountName = accountName.text;
    DbController dbController = Get.find();
    if (account.value.id == null) {
      account.value.id =
          await dbController.db.insert(Const.accounts, account.toJson());
      dbController.accounts[account.value.id!] = account.value;
    } else {
      await dbController.db.update(Const.accounts, account.value.toJson(),
          where: "id = ?", whereArgs: [account.value.id!]);
      dbController.accounts[account.value.id!] = account.value;
    }
    Get.find<AccountsController>().fetchStats();
  }

  Future<void> deleteAccount() async {
    final DbController dbController = Get.find<DbController>();
    account.value.isDeleted = 1;
    await dbController.db.update(Const.accounts, account.value.toJson(),
        where: "id = ?", whereArgs: [account.value.id]);
    dbController.accounts[account.value.id!] = account.value;
    Get.find<AccountsController>().fetchStats();
  }
}
