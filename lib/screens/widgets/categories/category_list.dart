import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/screens/categories/add_edit_category_screen.dart';
import 'package:vase/screens/categories/categories_controller.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/utils.dart';

import '../../../controllers/db_controller.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.categoryType,
  }) : super(key: key);

  final CategoryType categoryType;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      tag: categoryType.name,
      init: CategoriesController(categoryType: categoryType),
      builder: (controller) {
        return Obx(() {
          final List<Category> categories = Utils.getCategories(
              Get.find<DbController>().categories, controller.categoryType);

          if (categories.isEmpty) {
            return const Center(
              child: Text("No categories found"),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final Category category = categories[index];
                return ListTile(
                  onTap: () {
                    Get.to(() => AddCategoryScreen(),
                        arguments: {"edit": true, "category": category});
                  },
                  leading: CircleAvatar(
                    //backgroundColor: AppColors.darkGreyColor,
                    child: Icon(deserializeIcon(
                        {'pack': 'fontAwesomeIcons', 'key': category.icon})),
                  ),
                  title: Text(category.categoryName),
                  subtitle: category.createdAt != null
                      ? Text(
                          DateFormat.yMMMMd('en_US')
                              .format(category.createdAt!),
                          style: const TextStyle(color: Colors.grey),
                        )
                      : null,
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                );
              },
            ),
          );
        });
      },
    );
  }
}
