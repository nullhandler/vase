import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/accounts/accounts_screen.dart';
import 'package:vase/screens/home/home_controller.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/screens/transactions/transactions_screen.dart';
import 'package:vase/screens/user/settings.dart';
import 'package:vase/screens/user/user_controller.dart';

import '../categories/categories.dart';

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
  final UserController userController = Get.put(UserController());
  final _tabs = [
    const Transactions(),
    const Categories(),
    AccountsScreen(),
    UserSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        int currentIndex = homeController.currentState.value.index;
        return Scaffold(
          body: _tabs[homeController.currentState.value.index],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
            child: BottomNavigationBar(
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
           //   selectedItemColor: AppColors.accentColor,
              type: BottomNavigationBarType.fixed,
              // unselectedFontSize: 14,
              currentIndex: currentIndex,
              onTap: (newIndex) {
                homeController.currentState.value = HomeState.values[newIndex];
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.tag_rounded),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_rounded),
                  label: 'Accounts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: 'User',
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
