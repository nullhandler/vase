import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../categories/category_model.dart';

class CategoryTypeSelector extends StatelessWidget {
  const CategoryTypeSelector(
      {Key? key, required this.onSelect, required this.currentType})
      : super(key: key);

  final Function(CategoryType) onSelect;
  final Rx<CategoryType> currentType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: CategoryType.values
          .map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => ChoiceChip(
                      onSelected: (selected) {
                        if (selected) {
                          onSelect(item);
                        }
                      },
                      label: Text({
                            CategoryType.expense: "Expense",
                            CategoryType.income: "Income",
                            CategoryType.transfer: "Transfer"
                          }[item] ??
                          "Expense"),
                      selected: currentType.value == item),
                ),
              ))
          .toList(),
    );
  }
}
