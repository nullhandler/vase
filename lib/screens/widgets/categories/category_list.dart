import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/categories/categories_controller.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/screens/widgets/categories/category_chart.dart';
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
          final List<Category> categories =
              Utils.getCategories(Get.find<DbController>().categories, controller.categoryType);

          if (categories.isEmpty) {
            return const Center(
              child: Text("No categories found"),
            );
          }

          return ListView.builder(
            itemCount: categories.length + 1,
            itemBuilder: (context, kIndex) {
              if (kIndex == 0) {
                return CategoryChart(
                  categories: categories,
                );
              }
              final index = kIndex - 1;

              final Category category = categories[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.darkGreyColor,
                  child: Icon(deserializeIcon({'pack': 'cupertino', 'key': category.icon})),
                ),
                title: Text(category.categoryName),
                subtitle: category.createdAt != null
                    ? Text(
                        DateFormat.yMMMMd('en_US').format(category.createdAt!),
                        style: const TextStyle(color: Colors.grey),
                      )
                    : null,
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),
              );
            },
          );
        });
      },
    );
  }
}
