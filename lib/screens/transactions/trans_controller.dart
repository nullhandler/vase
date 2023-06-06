import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/const.dart';
import 'package:vase/extensions.dart';
import 'package:vase/utils.dart';

import '../../controllers/db_controller.dart';
import '../../enums.dart';
import 'trans_model.dart';

class TransController extends GetxController {
  Rx<DateTime> currentDate = DateTime.now().obs;
  DbController dbController = Get.find();
  Rx<VaseState> transState = VaseState.loading.obs;
  RxMap<String, List<Transaction>> transactions =
      <String, List<Transaction>>{}.obs;
  Rx<TransStats> monthlyStats = TransStats(0, 0, 0).obs;
  RxMap<String, TransStats> dailyStats = <String, TransStats>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    monthlyStats.value = TransStats(0, 0, 0);
    dailyStats.clear();
    transState.value = VaseState.loading;
    var transList = await dbController.db.rawQuery(
      '''SELECT * from ${Const.trans} LEFT JOIN ${Const.transLinks}
          on ${Const.transLinks}.trans_id = ${Const.trans}.id
      WHERE created_at BETWEEN ${Utils.getFirstDate(currentDate.value)} AND ${Utils.getLastDate(currentDate.value)}
      ORDER BY created_at DESC''',
    );
    parseTransactions(transList);
    transState.value = VaseState.loaded;
    update();
  }

  void parseTransactions(List<Map<String, Object?>> list) {
    Map<String, List<Transaction>> dateWiseTransactions =
        <String, List<Transaction>>{};
    Map<String, List<Map<String, Object?>>> dateWiseRaw =
        <String, List<Map<String, Object?>>>{};
    for (var txn in list) {
      DateTime transactionDateTime =
          DateTime.fromMillisecondsSinceEpoch((txn["created_at"] as int?) ?? 0);
      (dateWiseRaw[DateFormat.yMMMMd('en_US').format(transactionDateTime)] ??=
              [])
          .add(txn);
    }
    dateWiseRaw.forEach((date, rawTransactions) {
      List<Transaction> tempList = <Transaction>[];
      final batchTransaction = groupBy<Map<String, Object?>, String>(
          rawTransactions,
          (trans) => (trans["batch_id"] as String?) ?? "others");
      batchTransaction.forEach((batchId, txnList) {
        if (batchId != "others") {
          Transaction temp = Transaction.fromJson(txnList.first);
          temp.toAccountId = (txnList.last['account_id'] as int?);
          temp.amount = temp.amount.abs();
          tempList.add(temp);
        } else {
          tempList.addAll(txnList.map<Transaction>((rawTrans) {
            Transaction trans = Transaction.fromJson(rawTrans);
            (dailyStats[date] ??= TransStats(0, 0, 0)).total += trans.amount;
            if (trans.amount.isNegative) {
              (dailyStats[date] ??= TransStats(0, 0, 0)).expense +=
                  trans.amount;
            } else {
              (dailyStats[date] ??= TransStats(0, 0, 0)).income += trans.amount;
            }
            monthlyStats.update((stats) {
              stats?.total += trans.amount;
              if (trans.amount.isNegative) {
                stats?.expense += trans.amount;
              } else {
                stats?.income += trans.amount;
              }
            });
            return trans;
          }));
        }
      });
      dateWiseTransactions[date] = tempList;
    });
    transactions.value = dateWiseTransactions;
  }

  void refreshListIfNeeded(DateTime dateTime) {
    if (currentDate.value.isSameMonth(dateTime)) {
      fetchTransactions();
    }
  }

  void setDate(DateTime? dateTime) {
    if (dateTime != null) {
      currentDate.value = dateTime;
      fetchTransactions();
    }
  }

  void goToNextMonth() {
    currentDate.value = Utils.getNextMonth(currentDate.value);
    fetchTransactions();
  }

  void goToPreviousMonth() {
    currentDate.value =
        currentDate.value.copyWith(month: currentDate.value.month - 1);
    fetchTransactions();
  }
}
