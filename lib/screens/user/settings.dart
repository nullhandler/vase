import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/user/user_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/utils.dart';
import 'package:vase/widgets/focused_layout.dart';
import 'package:vase/widgets/wrapper.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});

  Widget commaDotChooser() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Choose Separator",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          RadioListTile(
            value: 1,
            groupValue: 1,
            title: const Text("Dot (.) e.g. 100.02"),
            subtitle: null,
            onChanged: (val) {
              // print("Radio Tile pressed $val");
              // setSelectedRadioTile(val);
            },
            selected: true,
          ),
          RadioListTile(
            value: 2,
            groupValue: 1,
            title: const Text("Comma (,) e.g. 100,02"),
            subtitle: null,
            selected: false,
            onChanged: (int? value) {},
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: FocusedLayout(
        isScrollable: true,
        appBarTitle: "Settings",
        child: GetBuilder<UserController>(
          init: UserController(),
          builder: (UserController controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Preferences",
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () => Utils.showCustomBottomSheet(
                            context,
                            // height: 200,
                            body: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Edit Currency",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FormItem(
                                    question: "Currency",
                                    controller: controller.currencyController,
                                    validator: (curr) {
                                      if (curr == null || curr.isEmpty) {
                                        return 'Currency cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          title: const Text("Pick Currency Symbol"),
                          trailing: const Icon(Icons.currency_rupee_outlined),
                        ),
                        ListTile(
                          onTap: () => Utils.showCustomBottomSheet(context,
                              // height: 200,
                              body: commaDotChooser()),
                          title: const Text("Decimal Separator"),
                          trailing: const Text(
                            'Dot (.)',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ListTile(
                          onTap: () => Utils.showCustomBottomSheet(context,
                              // height: 200,
                              body: commaDotChooser()),
                          title: const Text("Decimal Separator"),
                          trailing: const Text(
                            'Comma (,)',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Theme",
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    margin: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListTile(
                            onTap: null,
                            title: const Text("Monet Theme"),
                            trailing:
                                Switch(value: false, onChanged: (value) {})),
                      ],
                    ),
                  )
                ],
              ),
            );
            // return Obx(() {
            //   if (controller.accountsState.value == VaseState.loading) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   }
            //   if (dbController.accounts.isEmpty) {
            //     return const Center(
            //       child: Text("No Accounts found"),
            //     );
            //   }

            //   return ListView.builder(
            //       itemCount: dbController.accounts.length,
            //       itemBuilder: (context, pos) {
            //         Account account =
            //             dbController.accounts.values.toList()[pos];
            //         return Text(
            //             "${account.accountName} ${account.accountType} ${controller.accountStats[account.id]}  ${account.id}");
            //       });
            // });
          },
        ),
      ),
    );
  }
}
