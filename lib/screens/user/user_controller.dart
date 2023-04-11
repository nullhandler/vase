import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/user/user_model.dart';

class UserController extends GetxController {
  DbController dbController = Get.find();
  TextEditingController currencyController = TextEditingController(text: r'$');
  Rx<UserModel> configs = UserModel.fromJson({
    "currency": r'$',
    "thousand_separator": ",",
    "decimal_separator": "."
  }).obs;

  @override
  void onInit() {
    fetchPreferences();
    super.onInit();
  }

  void fetchPreferences() async {
    var userPref = await dbController.db.query(Const.configs);
    if (userPref.isNotEmpty) {
      configs.value = UserModel.fromJson(userPref[0]);
      currencyController.text = configs.value.currency;
    }
  }
}
