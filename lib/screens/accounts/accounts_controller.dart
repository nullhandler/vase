import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';

import '../../enums.dart';
import 'accounts_model.dart';

class AccountsController extends GetxController {
  RxMap<int, double> accountStats = <int, double>{}.obs;
  Rx<VaseState> accountsState = VaseState.loading.obs;
  RxMap<AccountType, List<Account>> accountList =
      <AccountType, List<Account>>{}.obs;
  TotalAccountStat totalAccountStat = TotalAccountStat();

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  void fetchStats() async {
    accountStats.clear();
    totalAccountStat = TotalAccountStat();
    DbController dbController = Get.find();
    var statsList = await dbController.db
        .rawQuery("""SELECT account_id, SUM(amount) as total
      FROM ${Const.trans} GROUP BY account_id""");
    accountStats.value = Map<int, double>.fromEntries(statsList.map((e) {
      return MapEntry<int, double>(
          e['account_id'] as int, e['total'] as double);
    }));
    accountStats.value.forEach((id, value) {
      Account account = dbController.accounts[id]!;
      if (account.parentId != null) {
        accountStats.value[account.parentId!] =
            accountStats.value[account.parentId]! + value;
      }
    });
    List<int> linkedAccountIds = <int>[];
    accountStats.value.forEach((id, value) {
      Account account = dbController.accounts[id]!;
      if (!account.hasParentAccount()) {
        if (value.isNegative) {
          totalAccountStat.liabilities += value;
        } else {
          totalAccountStat.assets += value;
        }
      } else {
        accountStats.value[id] = 0;
        linkedAccountIds.add(account.id!);
      }
    });
    statsList = await dbController.db
        .rawQuery("""SELECT account_id, SUM(amount) as total
      FROM ${Const.trans} WHERE created_at BETWEEN ${getFirstDate()} 
      AND ${DateTime.now().millisecondsSinceEpoch} AND account_id in (${linkedAccountIds.join(",")})
      GROUP BY account_id""");
    accountStats.value.addAll(Map<int, double>.fromEntries(statsList.map((e) {
      return MapEntry<int, double>(
          e['account_id'] as int, e['total'] as double);
    })));
    Map<AccountType, List<Account>> temp = groupBy<Account, AccountType>(
        dbController.accounts.values.toList(),
        (account) => account.accountType);
    accountList.value = temp;
    totalAccountStat.total =
        totalAccountStat.assets + totalAccountStat.liabilities;
    accountsState.value = VaseState.loaded;
  }

  Future<void> save(Account account) async {
    DbController dbController = Get.find();
    account.id = await dbController.db.insert(Const.accounts, account.toJson());
    dbController.accounts[account.id!] = account;
    fetchStats();
  }

  int getFirstDate() {
    return DateTime.now()
        .copyWith(day: 1, hour: 0, minute: 0, second: 0, microsecond: 1)
        .millisecondsSinceEpoch;
  }
}
