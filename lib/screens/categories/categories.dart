import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/categories/add_categories_screen.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/screens/widgets/categories/category_list.dart';
import 'package:vase/screens/widgets/fab.dart';
import 'package:vase/widgets/wrapper.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Categories"),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Expense",
                ),
                Tab(
                  text: "Income",
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CategoryList(
                categoryType: CategoryType.expense,
              ),
              CategoryList(
                categoryType: CategoryType.income,
              ),
            ],
          ),
          floatingActionButton: Fab(
            onTap: () {
              Get.to(() => const AddCategoriesScreen());
            },
          ),
        ),
      ),
    );
  }
}
