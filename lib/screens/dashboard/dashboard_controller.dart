import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';

class Sector {
  final Color color;
  final double value;
  final String title;

  Sector({required this.color, required this.value, required this.title});
}

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
      '''SELECT SUM(${Const.trans}.amount) AS value , count(${Const.categories}.category_name) AS share , ${Const.categories}.category_name  from ${Const.trans} LEFT JOIN ${Const.categories}
          on ${Const.trans}.category_id = ${Const.categories}.id
          GROUP BY ${Const.categories}.category_name
      ''',
    );
    print(transList);
  }
}
