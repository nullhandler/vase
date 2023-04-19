import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/categories/add_category_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/widgets/focused_layout.dart';

import '../widgets/category_type_selector.dart';

class AddCategoriesScreen extends StatelessWidget {
  AddCategoriesScreen({Key? key}) : super(key: key);

  final isEdit = Get.arguments['edit'];

  @override
  Widget build(BuildContext context) {
    return FocusedLayout(
      appBarTitle: isEdit ? "Edit Category" : "Add Category",
      padding: const EdgeInsets.all(16.0),
      isScrollable: false,
      child: GetBuilder<AddCategoryController>(
        init: AddCategoryController(),
        builder: (AddCategoryController controller) {
          if (isEdit) {
            controller.preFillCategory(Get.arguments['category']);
          }
          return Form(
            key: controller.formKey,
            child: Column(
              children: <Widget>[
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
                        child: controller.categoryIcon.value,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        IconData? icon = await FlutterIconPicker.showIconPicker(
                            context,
                            adaptiveDialog: true,
                            backgroundColor: AppColors.darkGreyColor,
                            iconPackModes: [IconPack.cupertino]);
                        controller.onCategoryIconChange(icon);
                      },
                      child: const Text('Click to choose an Icon'),
                    ),
                  ],
                ),
                const Spacer(),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed:
                        isEdit ? controller.updateCat : controller.validate,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isEdit ? "Update Category" : "Add Category",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
