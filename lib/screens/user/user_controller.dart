import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/user/user_model.dart';

class UserController extends GetxController {
  DbController dbController = Get.find();
  TextEditingController currencyController = TextEditingController(text: r'$');
  RxString currency = '\$'.obs;
  RxInt decimalSep = 0.obs;
  RxInt thousandSep = 1.obs;
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
    } else {
      await dbController.db.insert(Const.configs, configs.value.toJson());
    }

    currencyController.text = configs.value.currency;
    currency.value = configs.value.currency;
    decimalSep.value = configs.value.decimalSeparator == "," ? 1 : 0;
    thousandSep.value = configs.value.thousandSeparator == "," ? 1 : 0;
    update();
  }

  void updatePreferences() async {
    currency.value = currencyController.text;
    Map<String, dynamic> data = {
      'currency': currencyController.text,
      'thousand_separator': thousandSep.value == 1 ? "," : ".",
      'decimal_separator': decimalSep.value == 0 ? "." : ",",
    };
    await dbController.db.update(Const.configs, data);
    update();
  }
}
