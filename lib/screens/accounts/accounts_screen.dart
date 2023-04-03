import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';
import 'package:vase/widgets/wrapper.dart';

import '../../widgets/focused_layout.dart';
import '../widgets/fab.dart';
import 'accounts_model.dart';
import 'new_account.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({Key? key}) : super(key: key);
  final DbController dbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: FocusedLayout(
        appBarTitle: "Accounts",
        fab: Fab(onTap: () {
          Get.to(() => NewAccount());
        }),
        child: GetBuilder<AccountsController>(
          init: AccountsController(),
          builder: (AccountsController controller) {
            return Obx(() {
              if (controller.accountsState.value == VaseState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (dbController.accounts.isEmpty) {
                return const Center(
                  child: Text("No Accounts found"),
                );
              }

              return ListView.builder(
                  itemCount: dbController.accounts.length,
                  itemBuilder: (context, pos) {
                    Account account =
                        dbController.accounts.values.toList()[pos];
                    return Text(
                        "${account.accountName} ${account.accountType} ${controller.accountStats[account.id]}");
                  });
            });
          },
        ),
      ),
    );
  }
}
