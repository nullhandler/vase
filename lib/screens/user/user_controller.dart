import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/user/user_model.dart';

class UserController extends GetxController {
  DbController dbController = Get.find();
  TextEditingController currencyController = TextEditingController(text: r'$');
  RxString currency = '\$'.obs;
  RxBool showMonetSwitch = true.obs;
  RxInt decimalSep = 0.obs;
  RxInt thousandSep = 1.obs;
  RxBool monet = false.obs;
  bool prefLoaded = false;
  UserModel configs = UserModel(
      currency: r'₹',
      thousandSeparator: ',',
      decimalSeparator: '.',
      newUser: true,
      monet: false);

  @override
  void onInit() {
    //fetchPreferences();
    checkMonet();
    super.onInit();
  }

  Future<bool> fetchPreferences() async {
    var userPref = await dbController.db.query(Const.configs);
    configs = UserModel.fromJson(userPref);
    currencyController.text = configs.currency;
    currency.value = configs.currency;
    decimalSep.value = configs.decimalSeparator == "," ? 1 : 0;
    thousandSep.value = configs.thousandSeparator == "," ? 1 : 0;
    monet.value = configs.monet;
    if (monet.value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    prefLoaded = true;
    update();
    return prefLoaded;
  }

  void checkMonet() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    showMonetSwitch.value = androidInfo.version.sdkInt >= 12;
  }

  Future<void> _updatePreferences(String key, String value) async {
    final row = await dbController.db
        .query(Const.configs, where: 'key = ?', whereArgs: [key]);
    if (row.isEmpty) {
      await dbController.db.insert(Const.configs, {'key': key, 'value': value});
    } else {
      await dbController.db.update(Const.configs, {'value': value},
          where: 'key = ?', whereArgs: [key]);
    }
    update();
  }

  Future<void> updateCurrency() async {
    currency.value = currencyController.text;
    await _updatePreferences(UserModel.currencyConst, currencyController.text);
  }

  Future<void> updateThousandSeparator() async {
    await _updatePreferences(
        UserModel.thousandSeparatorConst, thousandSep.value == 1 ? "," : ".");
  }

  Future<void> updateDecimalSeparator() async {
    await _updatePreferences(
        UserModel.decimalSeparatorConst, decimalSep.value == 0 ? "." : ",");
  }

  Future<void> updateMonet() async {
    await _updatePreferences(UserModel.monetConst, monet.value.toString());
  }
   Future<void> updateOnboarding() async {
    await _updatePreferences(UserModel.newUserConst, false.toString());
  }
}
