import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/accounts/accounts_screen.dart';
import 'package:vase/screens/home/home_controller.dart';
import 'package:vase/screens/transactions/new_transaction.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/screens/transactions/transactions_screen.dart';

import '../accounts/new_account.dart';

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
  final _tabs = [Transactions(), Transactions(), AccountsScreen()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        int currentIndex = homeController.currentState.value.index;
        return Scaffold(
          // appBar: AppBar(
          //   title: const Text("Test"),
          // ),
          body: _tabs[homeController.currentState.value.index],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              switch (homeController.currentState.value) {
                case HomeState.transactions:
                  Get.to(NewTransaction());
                  break;
                case HomeState.stats:
                  Get.to(NewAccount());
                  break;
                case HomeState.accounts:
                  Get.to(NewAccount());
                  break;
              }
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
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
                icon: Icon(Icons.query_stats_rounded),
                label: 'Stats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_rounded),
                label: 'Accounts',
              ),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }
}
