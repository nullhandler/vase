import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/categories/add_category_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import '../widgets/category_type_selector.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({super.key});

  final isEdit = Get.arguments['edit'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCategoryController>(
      init: AddCategoryController(),
      builder: (AddCategoryController controller) {
        return Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
              title: Text(
                isEdit ? "Edit Category" : "Add Category",
              ),
            ),
            SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        FormItem(
                          question: 'Category Name',
                          controller: controller.categoryNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a category name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        isEdit
                            ? const SizedBox()
                            : CategoryTypeSelector(
                                onSelect: controller.setTransactionType,
                                currentType: controller.categoryType,
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: controller.categoryIcon.value,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                IconData? icon =
                                    await FlutterIconPicker.showIconPicker(
                                        context,
                                        adaptiveDialog: true,
                                        backgroundColor:
                                            AppColors.darkGreyColor,
                                        iconPackModes: [
                                      IconPack.fontAwesomeIcons
                                    ]);
                                controller.onCategoryIconChange(icon);
                              },
                              child: const Text('Click to choose an Icon'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => CircleAvatar(
                                  backgroundColor:
                                      controller.selectedColor.value,
                                  radius: 16,
                                )),
                            TextButton(
                              onPressed: () async {
                                Color? selectedColor =
                                    await showColorSelectionDialog(context,
                                        controller.selectedColor.value);
                                controller.onColorChange(selectedColor);
                              },
                              child: const Text('Click to choose a Color'),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: isEdit
                                ? controller.updateCat
                                : controller.validate,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isEdit ? "Update Category" : "Add Category",
                                    style: const TextStyle(
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
                ))
          ]),
        );
      },
    );
  }

  Future<Color?> showColorSelectionDialog(
      BuildContext context, Color oldColor) async {
    Color? selectedColor;
    TextEditingController textController = TextEditingController();
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          actionsPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.only(top: 16),
          content: Column(
            children: [
              ColorPicker(
                pickerColor: oldColor,
                onColorChanged: (newColor) {
                  selectedColor = newColor;
                },
                colorPickerWidth: 300,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                paletteType: PaletteType.hsvWithHue,
                labelTypes: const [],
                pickerAreaBorderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
                hexInputController: textController, // <- here
                portraitOnly: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: CupertinoTextField(
                  controller: textController,
                  style: const TextStyle(color: Colors.white),
                  prefix: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.tag)),
                  suffix: IconButton(
                    icon: const Icon(Icons.content_paste_rounded),
                    onPressed: () => copyToClipboard(textController.text),
                  ),
                  maxLength: 9,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                  ],
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedColor);
              },
              child: const Text('SUBMIT'),
            ),
          ],
        );
      },
    );
  }

  void copyToClipboard(String input) {
    String textToCopy = input.replaceFirst('#', '').toUpperCase();
    if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
      textToCopy = textToCopy.replaceFirst('FF', '');
    }
    Clipboard.setData(ClipboardData(text: '#$textToCopy'));
  }
}
