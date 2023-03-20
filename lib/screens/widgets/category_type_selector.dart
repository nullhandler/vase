import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTypeSelector extends StatelessWidget {
  const CategoryTypeSelector(
      {Key? key, required this.onSelect, required this.currentType})
      : super(key: key);

  final Function(String) onSelect;
  final RxString currentType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ["Income", "Expense"]
          .map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => ChoiceChip(
                      onSelected: (selected) {
                        if (selected) {
                          onSelect(item);
                        }
                      },
                      label: Text(item),
                      selected: currentType.value == item),
                ),
              ))
          .toList(),
    );
  }
}
