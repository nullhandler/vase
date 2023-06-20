import 'dart:math';

import 'package:flutter/material.dart';
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

  @override
  void onInit() {
    super.onInit();
    fetchSectors();
  }

  Future<void> fetchSectors() async {
    var transList = await dbController.db.rawQuery(
      '''SELECT SUM(${Const.trans}.amount) AS total , count(${Const.categories}.category_name) AS share , ${Const.categories}.category_name , ${Const.categories}.color  from ${Const.trans} LEFT JOIN ${Const.categories}
          on ${Const.trans}.category_id = ${Const.categories}.id
          WHERE ${Const.trans}.created_at BETWEEN ${Utils.getFirstDate(currentDate)} AND ${Utils.getLastDate(currentDate)}
          GROUP BY ${Const.categories}.category_name
          ORDER BY share DESC
      ''',
    );
    for (int i = 0; i < transList.length; i++) {
      if (double.parse(transList[i]['total'].toString()) < 0 &&
          transList[i]['category_name'] != null) {
        print(transList[i]);
        Sector s = Sector.fromJson(transList[i]);
        sectors.add(s);
      }
    }
    update();
  }
}
