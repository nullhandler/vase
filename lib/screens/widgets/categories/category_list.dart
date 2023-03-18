import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/categories/categories_controller.dart';
import 'package:vase/screens/categories/category_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.categoryType,
  }) : super(key: key);

  final CategoryType categoryType;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
      init: CategoriesController(),
      builder: (controller) {
        final List<Category> categories = controller.getCategoriesByType(categoryType);

        if (categories.isEmpty) {
          return const Center(
            child: Text("No categories found"),
          );
        }

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final Category category = categories[index];

            return ListTile(
              title: Text(category.categoryName),
              subtitle: category.createdAt != null ? Text(category.createdAt!.toIso8601String()) : null,
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
        );
      },
    );
  }
}