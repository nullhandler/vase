import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vase/const.dart';
import 'package:vase/screens/user/user_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/utils.dart';
import 'package:vase/widgets/focused_layout.dart';
import 'package:vase/widgets/heading.dart';
import 'package:vase/widgets/wrapper.dart';

import '../../colors.dart';

class UserSettings extends StatelessWidget {
  UserSettings({super.key});

  final UserController controller = Get.find();

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
                const Heading(title: "Preferences"),
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
                                  maxLength: 3,
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
                                      controller.updateCurrency();
                                      Get.back();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
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
                        trailing: Obx(() => Text(
                              controller.currency.value,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.grey),
                            )),
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
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Heading(title: "Backup"),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () async {
                          bool isImportSuccess = await Utils.importDb();
                          Utils.showSnackBarV2(
                              msg: isImportSuccess
                                  ? "DB imported successfully"
                                  : "DB import failed",
                              isPositiveMsg: isImportSuccess);
                        },
                        title: const Text("Import"),
                        trailing: const Icon(FontAwesomeIcons.fileArrowDown),
                      ),
                      ListTile(
                        onTap: () async {
                          bool isShareSuccess =
                              (await Utils.exportDb()).status ==
                                  ShareResultStatus.success;
                          Utils.showSnackBarV2(
                              msg: isShareSuccess
                                  ? "DB exported successfully"
                                  : "DB export failed",
                              isPositiveMsg: isShareSuccess);
                        },
                        title: const Text("Export"),
                        trailing: const Icon(FontAwesomeIcons.fileArrowUp),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.showMonetSwitch.value,
                    child: const Heading(title: "Theme"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.showMonetSwitch.value,
                    child: Card(
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
                                    controller.updateMonet();
                                  }))),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Heading(title: "About"),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => Utils.openLink(Const.tg),
                        title: const Text("Telegram Channel"),
                        trailing: const Icon(Icons.telegram_outlined),
                      ),
                      ListTile(
                        onTap: () => Utils.openLink(Const.git),
                        title: const Text("Github Repository"),
                        trailing: const Icon(Icons.code_outlined),
                      ),
                      ListTile(
                        onTap: () => Utils.openLink(Const.ps),
                        title: const Text("Play Store"),
                        trailing: const Icon(Icons.link),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Heading(title: "Licenses"),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => Utils.openLink(Const.flaticonURL),
                        title: const Text("Icon from flaticon (Kiranshastry)"),
                        trailing: const Icon(Icons.link_outlined),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => Align(
                      alignment: Alignment.center,
                      child: Text(
                        controller.version.value,
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text('Made in 💓 with Flutter'),
                )
              ],
            ),
          )),
    );
  }

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
            title: Text("Dot (.) e.g. ${isThousandSep ? '1.000' : '100.02'}"),
            subtitle: null,
            onChanged: (int? val) {
              if (isThousandSep) {
                controller.thousandSep.value = val!;
                controller.updateThousandSeparator();
              } else {
                controller.decimalSep.value = val!;
                controller.updateDecimalSeparator();
              }
              Get.back();
            },
          ),
          RadioListTile(
            value: 1,
            groupValue: isThousandSep
                ? controller.thousandSep.value
                : controller.decimalSep.value,
            title: Text("Comma (,) e.g. ${isThousandSep ? '1,000' : '100,02'}"),
            subtitle: null,
            selected: false,
            onChanged: (int? val) {
              if (isThousandSep) {
                controller.thousandSep.value = val!;
                controller.updateThousandSeparator();
              } else {
                controller.decimalSep.value = val!;
                controller.updateDecimalSeparator();
              }
              Get.back();
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
