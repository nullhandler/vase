import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/user/user_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/utils.dart';
import 'package:vase/widgets/focused_layout.dart';
import 'package:vase/widgets/wrapper.dart';

class UserSettings extends StatelessWidget {
  UserSettings({super.key});
  final UserController controller = Get.find();

  Widget commaDotChooser(UserController controller,
      {required bool isThousandSep}) {
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
            value: 0,
            groupValue: isThousandSep
                ? controller.thousandSep.value
                : controller.decimalSep.value,
            title: const Text("Dot (.) e.g. 100.02"),
            subtitle: null,
            onChanged: (int? val) {
              if (isThousandSep) {
                controller.thousandSep.value = val!;
              } else {
                controller.decimalSep.value = val!;
              }
              //  controller.update();
              Get.back();
              controller.updatePreferences();
              // print("Radio Tile pressed $val");
              // setSelectedRadioTile(val);
            },
            //selected: true,
          ),
          RadioListTile(
            value: 1,
            groupValue: isThousandSep
                ? controller.thousandSep.value
                : controller.decimalSep.value,
            title: const Text("Comma (,) e.g. 100,02"),
            subtitle: null,
            selected: false,
            onChanged: (int? val) {
              if (isThousandSep) {
                controller.thousandSep.value = val!;
              } else {
                controller.decimalSep.value = val!;
              }
              // controller.update();
              Get.back();
              controller.updatePreferences();
              // print("Radio Tile pressed $val");
              // setSelectedRadioTile(val);
            },
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Text(
                    "Preferences",
                    style: TextStyle(
                        color: controller.monet.value
                            ? AppColors.monetColorScheme.primary
                            : AppColors.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
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
                                  maxLength: 1,
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
                                ElevatedButton(
                                    onPressed: () {
                                      controller.updatePreferences();
                                      //controller.update();
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Update Currency",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        title: const Text("Pick Currency Symbol"),
                        trailing: Obx(() => Text(controller.currency.value)),
                      ),
                      Obx(
                        () => ListTile(
                          onTap: () => Utils.showCustomBottomSheet(context,
                              // height: 200,
                              body: commaDotChooser(controller,
                                  isThousandSep: false)),
                          title: const Text("Decimal Separator"),
                          trailing: Text(
                            controller.decimalSep.value == 0
                                ? 'Dot (.)'
                                : 'Comma (,)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Obx(
                        () => ListTile(
                          onTap: () => Utils.showCustomBottomSheet(context,
                              // height: 200,
                              body: commaDotChooser(controller,
                                  isThousandSep: true)),
                          title: const Text("Thousand Separator"),
                          trailing: Text(
                            controller.thousandSep.value == 0
                                ? 'Dot (.)'
                                : 'Comma (,)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Text(
                    "Theme",
                    style: TextStyle(
                        color: controller.monet.value
                            ? AppColors.monetColorScheme.primary
                            : AppColors.accentColor,
                        // color: AppColors.accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
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
                          trailing: Obx(() => Switch(
                              value: controller.monet.value,
                              onChanged: (value) {
                                controller.monet.value = value;
                                if (value) {
                                  Get.changeThemeMode(ThemeMode.dark);
                                } else {
                                  Get.changeThemeMode(ThemeMode.light);
                                }
                                
                                controller.updatePreferences();
                              }))),
                    ],
                  ),
                )
              ],
            ),
          )
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

          ),
    );
  }
}
