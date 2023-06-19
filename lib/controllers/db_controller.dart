import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/sqlite/sqlite.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/accounts/accounts_model.dart';
import 'package:vase/screens/user/user_controller.dart';

import '../screens/categories/category_model.dart';

class DbController extends GetxController {
  late Database db;
  Rx<bool> isNew = true.obs;
  Rx<VaseState> vaseState = VaseState.loading.obs;
  RxMap<int, Account> accounts = <int, Account>{}.obs;
  RxList<Category> categories = <Category>[].obs;

  Future<void> initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'vase.db');
    // await deleteDatabase(path);
    db = await openDatabase(path, version: migrationScripts.length + 1,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      for (final script in initScript) {
        await db.execute(script);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion - 1; i < newVersion - 1; i++) {
        await db.execute(migrationScripts[i]);
      }
    });
    final accountsList = await db.query(Const.accounts);
    accounts.value = accountsFromJson(accountsList);
    final categoryList = await db.query(
      Const.categories,
    );
    categories.value = categoryFromJson(categoryList);
    final UserController userController = Get.put(UserController());
    final prefLoaded = await userController.fetchPreferences();
    isNew.value = userController.configs.newUser;
    if (prefLoaded) {
      vaseState.value = VaseState.loaded;
    }
  }

  @override
  void onInit() {
    super.onInit();
    initDB();
  }

  @override
  void onClose() {
    db.close();
    super.onClose();
  }
}
