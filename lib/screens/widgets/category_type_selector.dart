import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../categories/category_model.dart';

class CategoryTypeSelector extends StatelessWidget {
  const CategoryTypeSelector(
      {Key? key,
      required this.onSelect,
      required this.currentType,
      this.showTransfer = false})
      : super(key: key);

  final Function(CategoryType) onSelect;
  final Rx<CategoryType> currentType;
  final bool showTransfer;

  @override
  Widget build(BuildContext context) {
    final categories = CategoryType.values.toList();
    if (!showTransfer) {
      categories.removeWhere((category) => category == CategoryType.transfer);
    }
    return Row(
      children: categories
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
