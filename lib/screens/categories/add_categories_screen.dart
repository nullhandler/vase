import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/categories/add_category_controller.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/widgets/focused_layout.dart';

import '../widgets/category_type_selector.dart';

class AddCategoriesScreen extends StatelessWidget {
  const AddCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedLayout(
      appBarTitle: "Add Category",
      padding: const EdgeInsets.all(16.0),
      isScrollable: false,
      child: GetBuilder<AddCategoryController>(
        init: AddCategoryController(),
        builder: (AddCategoryController controller) {
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
                CategoryTypeSelector(
                  onSelect: controller.setTransactionType,
                  currentType: controller.categoryType,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: controller.categoryIcon.value,
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.validate,
                    child: const Text('Add Category'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
