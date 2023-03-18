import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/categories/category_model.dart';

class CategoriesController extends GetxController {
  final CategoryType categoryType;

  CategoriesController({required this.categoryType});

  List<Category> getCategories(List<Category> categories) {
    return categories
        .where((element) => element.categoryType == categoryType)
        .toList();
  }

  Future<void> deleteCategory(Category category) async {
    final DbController dbController = Get.find<DbController>();
    await dbController.db
        .delete(Const.categories, where: "id = ?", whereArgs: [category.id]);
    final categoryList = await dbController.db.query(Const.categories);
    // categories.value = categoryFromJson(categoryList);
  }
}
