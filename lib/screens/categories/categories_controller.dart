import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/categories/category_model.dart';

class CategoriesController extends GetxController {
  final CategoryType categoryType;

  CategoriesController({required this.categoryType});

  Future<void> deleteCategory(Category category) async {
    final DbController dbController = Get.find<DbController>();
    category.deleted = 1;
    await dbController.db.update(Const.categories, category.toJson(),
        where: "id = ?", whereArgs: [category.id]);
    dbController.categories.removeWhere((element) => element.id == category.id);
    //final categoryList = await dbController.db.query(Const.categories);
    // categories.value = categoryFromJson(categoryList);
  }
}
