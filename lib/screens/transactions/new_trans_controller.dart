import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/extensions.dart';

import '../accounts/accounts_model.dart';

class NewTransController extends GetxController {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  Account? selectedAccount;
  DateTime? transactionDate;
  TimeOfDay? transactionTime;

  void setAccount(Account? account) {
    if (account == null) return;
    selectedAccount = account;
    accountController.text = account.accountName;
  }

  void setDate(DateTime? dateTime) {
    if (dateTime == null) return;
    transactionDate = dateTime;
    dateController.text = dateTime.formatDate();
  }

  void setTime(TimeOfDay? time) {
    if (time == null) return;
    transactionTime = time;
    timeController.text = DateTime.now().copyTime(time).formatTime();
  }

  void saveTransaction() {}
}
