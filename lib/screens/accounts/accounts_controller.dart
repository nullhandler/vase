import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';

import '../../enums.dart';
import 'account_stats.dart';
import 'accounts_model.dart';

class AccountsController extends GetxController {
  RxMap<int, AccountStats> accountStats = <int, AccountStats>{}.obs;
  Rx<VaseState> accountsState = VaseState.loading.obs;

  Future<void> save(Account account) async {
    DbController dbController = Get.find();
    account.id = await dbController.db.insert(Const.accounts, account.toJson());
    dbController.accounts[account.id!] = account;
  }

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  void fetchStats() async {
    DbController dbController = Get.find();
    var statsList = await dbController.db.rawQuery(
        """SELECT account_id, SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) income, 
      SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END) as expense
      FROM ${Const.trans} GROUP BY account_id""");
    accountStats.value = accountStatsFromJson(statsList);
    accountsState.value = VaseState.loaded;
  }
}
