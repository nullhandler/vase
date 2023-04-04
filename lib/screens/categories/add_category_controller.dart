import 'package:flutter/cupertino.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import '../../const.dart';
import '../../controllers/db_controller.dart';
import 'category_model.dart';

class AddCategoryController extends GetxController {
  Rx<CategoryType> categoryType = CategoryType.expense.obs;
  final categoryNameController = TextEditingController();
  final categoryTagController = TextEditingController();
  Rx<Icon> categoryIcon = const Icon(CupertinoIcons.money_dollar_circle).obs;
  final formKey = GlobalKey<FormState>();
  RxString transactionType = "Expense".obs;

  void onCategoryTypeChange(CategoryType? value) {
    if (value != null) {
      categoryType.value = value;
    }
  }

  void onCategoryIconChange(IconData? icon) {
    if (icon != null) {
      categoryIcon.value = Icon(icon);
      update();
    }
  }

  void setTransactionType(String newTransactionType) {
    transactionType.value = newTransactionType;
    onCategoryTypeChange(categoryTypeMap[newTransactionType.toLowerCase()]);
  }

  void validate() {
    if (formKey.currentState!.validate()) {
      addCategory(
        Category(
            categoryName: categoryNameController.text,
            categoryType: categoryType.value,
            createdAt: DateTime.now(),
            icon: serializeIcon(categoryIcon.value.icon!)!['key']),
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
