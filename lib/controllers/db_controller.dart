import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vase/const.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/accounts/accounts_model.dart';

class DbController extends GetxController {
  late Database db;
  Rx<VaseState> vaseState = VaseState.loading.obs;
  RxList<Account> accounts = <Account>[].obs;

  Future<void> initDB() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'vase.db');
    await deleteDatabase(path);
    db = await openDatabase(path, version: 1, onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.accounts} (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          account_name TEXT, 
          account_type INT)''');
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.categories} (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          category_name TEXT)''');
      await db.execute('''CREATE TABLE IF NOT EXISTS ${Const.trans} (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          created_at INTEGER,
          amount REAL,
          desc TEXT, 
          account_id INTEGER, 
          category_id INTEGER, 
          FOREIGN KEY (account_id) REFERENCES ${Const.accounts}(id) ON DELETE CASCADE, 
          FOREIGN KEY (category_id) REFERENCES ${Const.categories}(id) ON DELETE CASCADE)''');
      // print(await db.rawQuery("PRAGMA foreign_keys;"));
      // await db.execute(
      //     'CREATE TABLE Transactions (id INTEGER PRIMARY KEY, category_name TEXT)');
    });
    // await db.insert(
    //     Const.accounts,
    //     Account(accountName: "ICICI", accountType: AccountType.savings)
    //         .toJson());
    var accountsList = await db.query("Accounts");
    accounts.value = accountsFromJson(accountsList);
    vaseState.value = VaseState.loaded;
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
