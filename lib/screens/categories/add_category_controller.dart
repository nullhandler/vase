import 'package:flutter/cupertino.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controllers/db_controller.dart';
import 'category_model.dart';

class AddCategoryController extends GetxController {
  Rx<CategoryType> categoryType = CategoryType.expense.obs;
  final categoryNameController = TextEditingController();
  Rx<Icon> categoryIcon = const Icon(FontAwesomeIcons.moneyBill).obs;
  final formKey = GlobalKey<FormState>();
  int updateId = 0;
  Category? preFilledCategory;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments['edit']) {
      preFillCategory(Get.arguments['category']);
    }
  }

  void setTransactionType(CategoryType? newTransactionType) {
    if (newTransactionType != null) {
      categoryType.value = newTransactionType;
    }
  }

  void preFillCategory(Category category) {
    preFilledCategory = category;
    categoryNameController.text = category.categoryName;
    categoryIcon.value = Icon(
        deserializeIcon({'pack': 'fontAwesomeIcons', 'key': category.icon}));
    categoryType.value = category.categoryType;
    updateId = category.id!;
    update();
  }

  void onCategoryIconChange(IconData? icon) {
    if (icon != null) {
      categoryIcon.value = Icon(icon);
    }
  }

  void validate() {
    if (formKey.currentState!.validate()) {
      addCategory(
        Category(
            categoryName: categoryNameController.text,
            categoryType: categoryType.value,
            createdAt: DateTime.now(),
            icon: serializeIcon(categoryIcon.value.icon!)!['key'],
            isDeleted: 0),
      );
      Get.back();
    }
  }

  void updateCat() {
    if (formKey.currentState!.validate()) {
      updateCategory(
        Category(
            id: updateId,
            categoryName: categoryNameController.text,
            categoryType: categoryType.value,
            createdAt: DateTime.now(),
            icon: serializeIcon(categoryIcon.value.icon!)!['key'],
            isDeleted: 0),
      );
      Get.back();
    }
  }

  Future<void> addCategory(Category category) async {
    final DbController dbController = Get.find<DbController>();
    await dbController.db.insert(Const.categories, category.toJson());
    final categoryList = await dbController.db
        .query(Const.categories, where: 'is_deleted = ?', whereArgs: [0]);
    dbController.categories.value = categoryFromJson(categoryList);
  }

  Future<void> updateCategory(Category category) async {
    final DbController dbController = Get.find<DbController>();
    await dbController.db.update(Const.categories, category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
    final categoryList = await dbController.db
        .query(Const.categories, where: 'is_deleted = ?', whereArgs: [0]);
    dbController.categories.value = categoryFromJson(categoryList);
  }

  Future<void> deleteCategory() async {
    if (preFilledCategory != null) {
      final DbController dbController = Get.find<DbController>();
      preFilledCategory!.isDeleted = 1;
      await dbController.db.update(
          Const.categories, preFilledCategory!.toJson(),
          where: "id = ?", whereArgs: [preFilledCategory!.id]);
      dbController.categories[preFilledCategory!.id!] = preFilledCategory!;
    }
  }
}
