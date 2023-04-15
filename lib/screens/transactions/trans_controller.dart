import 'package:get/get.dart';
import 'package:vase/const.dart';

import '../../controllers/db_controller.dart';
import '../../enums.dart';
import 'trans_model.dart';

class TransController extends GetxController {
  Rx<DateTime> currentDate = DateTime.now().obs;
  DbController dbController = Get.find();
  Rx<VaseState> transState = VaseState.loading.obs;
  RxList<Transaction> transactions = <Transaction>[].obs;
  RxDouble monthlyTotal = (0.0).obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    monthlyTotal.value = 0;
    transState.value = VaseState.loading;
    var transList = await dbController.db.query(Const.trans,
        where: 'created_at BETWEEN ${getFirstDate()} AND ${getLastDate()}',
        orderBy: 'created_at DESC');
    transactions.value = transactionFromJson(transList);
    transState.value = VaseState.loaded;
    monthlyTotal.value = totalFromJson(transList);
  }

  List<Transaction> categoryTransactions(int categoryId) {
    return transactions
        .where((element) => element.categoryId == categoryId)
        .toList();
  }

  Map<int, double> categoryTotals() {
    Map<int, double> totals = {};
    for (var element in transactions) {
      if (totals.containsKey(element.categoryId)) {
        totals[element.categoryId ?? -1] =
            totals[element.categoryId]! + element.amount;
      } else {
        totals[element.categoryId ?? -1] = element.amount;
      }
    }
    return totals;
  }

  void setDate(DateTime? dateTime) {
    if (dateTime != null) {
      currentDate.value = dateTime;
      fetchTransactions();
    }
  }

  void goToNextMonth() {
    currentDate.value = getNextMonth(currentDate.value);
    fetchTransactions();
  }

  void goToPreviousMonth() {
    currentDate.value =
        currentDate.value.copyWith(month: currentDate.value.month - 1);
    fetchTransactions();
  }

  int getFirstDate() {
    return currentDate.value.copyWith(day: 1).millisecondsSinceEpoch;
  }

  int getLastDate() {
    DateTime dateTime = currentDate.value;
    return (getNextMonth(dateTime).copyWith(day: 0)).millisecondsSinceEpoch;
  }

  DateTime getNextMonth(DateTime dateTime) {
    return (dateTime.month < 12)
        ? DateTime(dateTime.year, dateTime.month + 1, 1)
        : DateTime(dateTime.year + 1, 1, 1);
  }
}
