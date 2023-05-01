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

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  void fetchStats() async {
    DbController dbController = Get.find();
    var statsList = await dbController.db
        .rawQuery("""SELECT account_id, SUM(amount) as total
      FROM ${Const.trans} GROUP BY account_id""");
    accountStats.value = Map<int, double>.fromEntries(statsList.map((e) {
      return MapEntry<int, double>(
          e['account_id'] as int, e['total'] as double);
    }));
    Map<AccountType, List<Account>> temp = groupBy<Account, AccountType>(
        dbController.accounts.values.toList(),
        (account) => account.accountType);
    accountList.value = temp;
    accountsState.value = VaseState.loaded;
  }

  Future<void> save(Account account) async {
    DbController dbController = Get.find();
    account.id = await dbController.db.insert(Const.accounts, account.toJson());
    dbController.accounts[account.id!] = account;
    fetchStats();
  }
}
