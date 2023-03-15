import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../accounts/accounts_dialog.dart';

class ListDialog<S> {
  Future<S?> showListDialog(List<S> list, {S? selectedItem}) {
    return Get.dialog(AlertDialog(
        content: AccountsDialog<S>(
      selectedAccount: selectedItem,
      accounts: list,
    )));
  }
}
