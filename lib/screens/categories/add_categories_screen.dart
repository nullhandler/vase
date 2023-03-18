import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/screens/categories/categories_controller.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/screens/widgets/form_item.dart';
import 'package:vase/widgets/focused_layout.dart';

class AddCategoriesScreen extends StatefulWidget {
  const AddCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();

  CategoryType? categoryType;

  @override
  Widget build(BuildContext context) {
    return FocusedLayout(
      appBarTitle: "Add Category",
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (CategoriesController controller) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormItem(
                  question: 'Category Name',
                  controller: categoryNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ...CategoryType.values.map(
                  (e) => RadioListTile<CategoryType>(
                    value: e,
                    groupValue: categoryType,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          categoryType = value;
                        });
                      }
                    },
                    title: Text(e.toString().split(".").last.toTitleCase),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.addCategory(
                          Category(
                            categoryName: categoryNameController.text,
                            categoryType: categoryType!,
                          ),
                        );
                        Get.back();
                      }
                    },
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
