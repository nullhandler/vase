import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/extensions.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/screens/transactions/trans_model.dart';

import '../../const.dart';
import '../../controllers/db_controller.dart';
import '../accounts/accounts_model.dart';
import '../categories/category_model.dart';

class NewTransController extends GetxController {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  Account? selectedAccount;
  Category? selectedCategory;
  late DateTime transactionDate;
  late TimeOfDay transactionTime;
  RxString transactionType = "Expense".obs;

  @override
  void onInit() {
    super.onInit();
    setDate(DateTime.now());
    setTime(TimeOfDay.now());
  }

  void setAccount(Account? account) {
    if (account == null) return;
    selectedAccount = account;
    accountController.text = account.accountName;
  }

  void setCategory(Category? category) {
    if (category == null) return;
    selectedCategory = category;
    categoryController.text = category.categoryName;
  }

  void setTransactionType(String newTransactionType) {
    transactionType.value = newTransactionType;
    selectedCategory = null;
    categoryController.text = "";
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

  void saveTransaction() async {
    final DbController dbController = Get.find<DbController>();
    Transaction newTransaction = Transaction(
      createdAt: transactionDate.copyTime(transactionTime),
      amount: double.parse(
          "${transactionType.value == 'Expense' ? '-' : '+'}${amountController.text}"),
      desc: descController.text,
      accountId: selectedAccount!.id!,
      categoryId: selectedCategory!.id!,
    );
    newTransaction.id =
        await dbController.db.insert(Const.trans, newTransaction.toJson());
    Get.find<TransController>().transactions.add(newTransaction);
  }
}
