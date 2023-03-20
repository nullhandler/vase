import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  currentType: controller.transactionType,
                ),
                // Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
                //       ...CategoryType.values.map(
                //         (e) => RadioListTile<CategoryType>(
                //           value: e,
                //           groupValue: controller.categoryType.value,
                //           onChanged: controller.onCategoryTypeChange,
                //           title: Text(e.toString().split(".").last.toTitleCase),
                //         ),
                //       )
                //     ])),
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
