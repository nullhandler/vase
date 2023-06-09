import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vase/const.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/accounts/accounts_screen.dart';
import 'package:vase/screens/home/home_controller.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/screens/transactions/transactions_screen.dart';
import 'package:vase/screens/user/settings.dart';
import 'package:vase/screens/user/user_controller.dart';
import 'package:vase/utils.dart';
import 'package:vase/widgets/wrapper.dart';
import '../categories/categories.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final TransController transController = Get.put(TransController());
  final UserController userController = Get.find();
  String updateURL = "";
  String changelog = "";
  final _tabs = [
    const Transactions(),
    const Categories(),
    AccountsScreen(),
    UserSettings()
  ];

  Widget updateDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Update Available !!\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(changelog),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Utils.openLink(updateURL);
                      Get.back();
                    },
                    child: const Text(
                      "Download",
                    )),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("No , let it be"))
              ],
            )
          ],
        ),
      ),
    );
  }

  checkForUpdates(BuildContext context) async {
    var res = await http.get(Uri.parse(Const.updateCheck));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      if (json == null || res.statusCode != 200) {
        return null;
      }

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      int version = int.tryParse(packageInfo.buildNumber) ?? 0;

      if (json['version'] > version) {
        updateURL = json['update'];
        changelog = json['changelog'];
        if (context.mounted) {
          Utils.showCustomBottomSheet(context,
              body: updateDisplay(), dismissable: !json['forced']);
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    checkForUpdates(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        int currentIndex = homeController.currentState.value.index;
        return ThemeWrapper(
          child: Scaffold(
            body: _tabs[homeController.currentState.value.index],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: BottomNavigationBar(
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                //   selectedItemColor: AppColors.accentColor,
                type: BottomNavigationBarType.fixed,
                // unselectedFontSize: 14,
                currentIndex: currentIndex,
                onTap: (newIndex) {
                  homeController.currentState.value =
                      HomeState.values[newIndex];
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_outlined),
                    label: 'Transactions',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.category_outlined),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet_outlined),
                    label: 'Accounts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined),
                    label: 'Settings',
                  ),
                ],
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      },
    );
  }
}
