import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/accounts/accounts_model.dart';

class DbController extends GetxController {
  late Database db;
  Rx<VaseStates> vaseState = VaseStates.loading.obs;
  RxList<Account> accounts = <Account>[].obs;

  Future<void> initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    await deleteDatabase(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Accounts (id INTEGER PRIMARY KEY, account_name TEXT)');
      await db.execute(
          'CREATE TABLE Categories (id INTEGER PRIMARY KEY, category_name TEXT)');
      // await db.execute(
      //     'CREATE TABLE Transactions (id INTEGER PRIMARY KEY, category_name TEXT)');
    });
    await db.insert("Accounts", {"account_name": "test"});
    var test = await db.query("Accounts");
    accounts.value = accountsFromJson(test);
    vaseState.value = VaseStates.loaded;
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
