import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/dashboard/dashboard_model.dart';

class DashboardController extends GetxController {
  RxList<Sector> sectors = RxList.empty();
  DbController dbController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchSectors();
  }

  Future<void> fetchSectors() async {
    var transList = await dbController.db.rawQuery(
      '''SELECT SUM(${Const.trans}.amount) AS total , count(${Const.categories}.category_name) AS share , ${Const.categories}.category_name  from ${Const.trans} LEFT JOIN ${Const.categories}
          on ${Const.trans}.category_id = ${Const.categories}.id
          GROUP BY ${Const.categories}.category_name
      ''',
    );
    for (int i = 0; i < transList.length; i++) {
      Sector s = Sector.fromJson(transList[i]);
      s.color = AppColors.pieCharColors['pieColor${i + 1}']!;
      sectors.add(s);
    }
    update();
  }
}
