import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:vase/extensions.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/screens/transactions/trans_model.dart';

import '../../const.dart';
import '../../controllers/db_controller.dart';
import '../accounts/accounts_model.dart';
import '../categories/category_model.dart';

class NewTransController extends GetxController {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController toAccountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  Account? selectedAccount;
  Account? selectedToAccount;
  Category? selectedCategory;
  late DateTime transactionDate;
  late TimeOfDay transactionTime;
  Rx<CategoryType> categoryType = CategoryType.expense.obs;

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

  void setToAccount(Account? account) {
    if (account == null) return;
    selectedToAccount = account;
    toAccountController.text = account.accountName;
  }

  void setCategory(Category? category) {
    if (category == null) return;
    selectedCategory = category;
    categoryController.text = category.categoryName;
  }

  void setTransactionType(CategoryType newTransactionType) {
    categoryType.value = newTransactionType;
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
    DateTime combinedDateTime = transactionDate.copyTime(transactionTime);
    if (categoryType.value == CategoryType.transfer) {
      String uuid = const Uuid().v4();
      Transaction newTransaction1 = Transaction(
        createdAt: combinedDateTime,
        amount: double.parse("-${amountController.text}"),
        desc: descController.text,
        accountId: selectedAccount!.id!,
      );
      newTransaction1.id =
          await dbController.db.insert(Const.trans, newTransaction1.toJson());

      Transaction newTransaction2 = Transaction(
        createdAt: combinedDateTime,
        amount: double.parse("+${amountController.text}"),
        desc: descController.text,
        accountId: selectedToAccount!.id!,
      );
      newTransaction2.id =
          await dbController.db.insert(Const.trans, newTransaction2.toJson());

      await dbController.db.insert(
          Const.transLinks, {"trans_id": newTransaction1.id, "batch_id": uuid});
      await dbController.db.insert(
          Const.transLinks, {"trans_id": newTransaction2.id, "batch_id": uuid});
    } else {
      Transaction newTransaction = Transaction(
        createdAt: combinedDateTime,
        amount: double.parse(
            "${categoryType.value == CategoryType.expense ? '-' : '+'}${amountController.text}"),
        desc: descController.text,
        accountId: selectedAccount!.id!,
        categoryId: selectedCategory!.id!,
      );
      newTransaction.id =
          await dbController.db.insert(Const.trans, newTransaction.toJson());
    }

    Get.find<TransController>().refreshListIfNeeded(combinedDateTime);
  }
}
