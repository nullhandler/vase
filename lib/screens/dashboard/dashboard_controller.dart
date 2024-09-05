import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/dashboard/dashboard_model.dart';
import 'package:vase/utils.dart';

class DashboardController extends GetxController {
  final DateTime currentDate;
  DashboardController(this.currentDate);
  RxList<Sector> sectors = RxList.empty();
  DbController dbController = Get.find();
  double total = 0;

  @override
  void onInit() {
    super.onInit();
    fetchSectors();
  }

  Future<void> fetchSectors() async {
    var transList = await dbController.db.rawQuery(
      '''SELECT SUM(${Const.trans}.amount) AS total , count(${Const.categories}.category_name) AS share , ${Const.categories}.category_name , 
          ${Const.categories}.color, ${Const.categories}.icon from ${Const.trans} 
          LEFT JOIN ${Const.categories}
          on ${Const.trans}.category_id = ${Const.categories}.id
          WHERE ${Const.trans}.created_at BETWEEN ${Utils.getFirstDate(currentDate)} AND ${Utils.getLastDate(currentDate)}
          GROUP BY ${Const.categories}.category_name
          ORDER BY share DESC
      ''',
    );
    total = 0;
    for (int i = 0; i < transList.length; i++) {
      final transaction = transList[i];
      if (double.parse(transaction['total'].toString()) < 0 &&
          transaction['category_name'] != null) {
        Sector s = Sector.fromJson(transList[i]);
        total += s.amount;
        sectors.add(s);
      }
    }
    update();
  }

  List<Sector> getFilteredSectors() {
    return sectors.where((sector) => sector.include).toList();
  }
}
