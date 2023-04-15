import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/utils.dart';

class CategoryChart extends StatelessWidget {
  const CategoryChart({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransController>(
      builder: (controller) {
        return Obx(
          () {
            final Map<int, double> categoryTotals = controller.categoryTotals();
            if (controller.monthlyTotal.value == 0) {
              return const SizedBox.shrink();
            }
            final List<PieChartSectionData> sections = categories.map(
              (category) {
                final value = categoryTotals[category.id] ?? 0;
                return PieChartSectionData(
                  value: value,
                  title: category.categoryName,
                  color: Utils.getPieChartColor(
                      value / controller.monthlyTotal.value),
                );
              },
            ).toList();
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 16),
              height: 220,
              child: PieChart(
                PieChartData(
                  sections: sections,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
