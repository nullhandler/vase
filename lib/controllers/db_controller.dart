import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vase/const.dart';
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
    db = await openDatabase(path, version: 1, onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.accounts} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          account_name TEXT,
          account_type INT,
          parent_id INTEGER)''');
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.categories} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_name TEXT,
          category_type INT,
          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
          icon TEXT,
          deleted INTEGER
          )''');
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.configs} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          key TEXT,
          value TEXT
          )''');
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.trans} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          created_at INTEGER,
          amount REAL,
          desc TEXT,
          account_id INTEGER,
          category_id INTEGER,
          FOREIGN KEY (account_id) REFERENCES ${Const.accounts}(id),
          FOREIGN KEY (category_id) REFERENCES ${Const.categories}(id))''');
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.transLinks} (
          link_id INTEGER PRIMARY KEY AUTOINCREMENT,
          trans_id INTEGER,
          batch_id TEXT,
          FOREIGN KEY (trans_id) REFERENCES ${Const.trans}(id) ON DELETE CASCADE)''');
      await db.execute(
          '''CREATE INDEX IF NOT EXISTS TransIdIndex ON ${Const.transLinks} (trans_id)''');
      await db.execute(
          '''CREATE INDEX IF NOT EXISTS ConfigKeyIndex ON ${Const.configs} (key)''');
    });
    final accountsList = await db.query(Const.accounts);
    accounts.value = accountsFromJson(accountsList);
    final categoryList =
        await db.query(Const.categories, where: 'deleted = ?', whereArgs: [0]);
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
