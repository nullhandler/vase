import 'package:get/get.dart';
import 'package:vase/const.dart';

import '../../controllers/db_controller.dart';
import '../../enums.dart';

class TransController extends GetxController {
  DateTime currentDate = DateTime.now();
  DbController dbController = Get.find();
  Rx<VaseState> transState = VaseState.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    transState.value = VaseState.loading;
    var transList = await dbController.db.query(Const.trans);
    // accounts.value = accountsFromJson(accountsList);
    transState.value = VaseState.loaded;
  }
}
