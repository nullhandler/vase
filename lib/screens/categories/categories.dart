import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/categories/add_edit_category_screen.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/screens/widgets/categories/category_list.dart';
import 'package:vase/screens/widgets/fab.dart';
import 'package:vase/widgets/wrapper.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            bottom: TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Expense",
                ),
                Tab(
                  text: "Income",
                )
              ],
            ),
          ),
          body:  TabBarView(
            controller: tabController,
            children:const [
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
              Get.to(() => AddCategoryScreen(), arguments: {
                "edit": false,
                "type": tabController.index == 0
                    ? CategoryType.expense
                    : CategoryType.income
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
