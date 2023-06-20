import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/categories/add_category_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import '../widgets/category_type_selector.dart';

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({Key? key}) : super(key: key);

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
                                    await showColorSelectionDialog(context);
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

  Future<Color?> showColorSelectionDialog(BuildContext context) async {
    Color? selectedColor;
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(18.0),
          title: const Text("Pick a color"),
          content: MaterialColorPicker(
              onColorChange: (Color color) {
                selectedColor = color;
              },
              selectedColor:
                  Get.find<AddCategoryController>().selectedColor.value),
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
}
