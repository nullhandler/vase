import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controllers/db_controller.dart';
import 'category_model.dart';

class AddCategoryController extends GetxController {
  Rx<CategoryType> categoryType = CategoryType.expense.obs;
  final categoryNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void setTransactionType(CategoryType? newTransactionType) {
    if (newTransactionType != null) {
      categoryType.value = newTransactionType;
    }
  }

  void validate() {
    if (formKey.currentState!.validate()) {
      addCategory(
        Category(
            categoryName: categoryNameController.text,
            categoryType: categoryType.value,
            createdAt: DateTime.now()),
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
