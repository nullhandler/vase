import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/categories/add_edit_categories_screen.dart';
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
                  leading: CircleAvatar(
                    //backgroundColor: AppColors.darkGreyColor,
                    child: Icon(deserializeIcon(
                        {'pack': 'cupertino', 'key': category.icon})),
                  ),
                  title: Text(category.categoryName),
                  subtitle: category.createdAt != null
                      ? Text(
                          DateFormat.yMMMMd('en_US')
                              .format(category.createdAt!),
                          style: const TextStyle(color: Colors.grey),
                        )
                      : null,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () {
                          Get.to(() => AddCategoriesScreen(),
                              arguments: {"edit": true, "category": category});
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outlined,
                            color: AppColors.errorColor),
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            title: const Text("Are you sure ? "),
                            content: Text(
                                "This will delete the category ${category.categoryName} permanently"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    controller.deleteCategory(category);
                                    categories.removeAt(index);
                                    
                                    Get.back();
                                  },
                                  child: const Text(
                                    "Yes , Delete",
                                    style:
                                        TextStyle(color: AppColors.errorColor),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("No"))
                            ],
                          ));
                        },
                      ),
                    ],
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
