import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controllers/db_controller.dart';
import 'category_model.dart';

class AddCategoryController extends GetxController {
  Rxn<CategoryType> categoryType = Rxn<CategoryType>(null);
  final categoryNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void onCategoryTypeChange(CategoryType? value) {
    if (value != null) {
      categoryType.value = value;
    }
  }

  void validate() {
    if (formKey.currentState!.validate()) {
      addCategory(
        Category(
          categoryName: categoryNameController.text,
          categoryType: categoryType.value!,
        ),
      );
      Get.back();
    }
  }

  Future<void> addCategory(Category category) async {
    final DbController dbController = Get.find<DbController>();
    await dbController.db.insert(Const.categories, category.toJson());
    final categoryList = await dbController.db.query(Const.categories);
    dbController.categories.value = categoryFromJson(categoryList);
  }
}
