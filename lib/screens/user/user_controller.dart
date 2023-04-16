import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/user/user_model.dart';

class UserController extends GetxController {
  DbController dbController = Get.put(DbController());
  TextEditingController currencyController = TextEditingController(text: r'$');
  RxString currency = '\$'.obs;
  RxBool showMonetSwitch = true.obs;
  RxInt decimalSep = 0.obs;
  RxInt thousandSep = 1.obs;
  RxBool monet = false.obs;
  UserModel configs = UserModel.fromJson({
    "currency": r'$',
    "thousand_separator": ",",
    "decimal_separator": ".",
    "monet": false
  });

  @override
  void onInit() {
    fetchPreferences();
    checkMonet();
    super.onInit();
  }

  void fetchPreferences() async {
    var userPref = await dbController.db.query(Const.configs);
    if (userPref.isNotEmpty) {
      configs = UserModel.fromJson(userPref[0]);
    } else {
      await dbController.db.insert(Const.configs, configs.toJson());
    }

    currencyController.text = configs.currency;
    currency.value = configs.currency;
    decimalSep.value = configs.decimalSeparator == "," ? 1 : 0;
    thousandSep.value = configs.thousandSeparator == "," ? 1 : 0;
    monet.value = configs.monet;
    update();
  }

  void checkMonet() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print(androidInfo.version.incremental);
  }

  void updatePreferences() async {
    currency.value = currencyController.text;
    Map<String, dynamic> data = {
      'currency': currencyController.text,
      'thousand_separator': thousandSep.value == 1 ? "," : ".",
      'decimal_separator': decimalSep.value == 0 ? "." : ",",
      "monet": monet.value.toString()
    };
    await dbController.db.update(Const.configs, data);
    update();
  }
}
