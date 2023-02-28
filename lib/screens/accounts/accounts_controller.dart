import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';

import 'accounts_model.dart';

class AccountsController extends GetxController {
  Future<void> save(Account account) async {
    DbController dbController = Get.find();
    account.id = await dbController.db.insert(Const.accounts, account.toJson());
    dbController.accounts.add(account);
  }
}
