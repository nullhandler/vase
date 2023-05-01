import 'package:get/get.dart';
import 'package:vase/const.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/categories/category_model.dart';

class CategoriesController extends GetxController {
  final CategoryType categoryType;

  CategoriesController({required this.categoryType});
}
