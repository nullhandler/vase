import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/colors.dart';
import 'package:vase/enums.dart';
import 'package:vase/extensions.dart';
import 'package:vase/screens/dashboard/dashboard_controller.dart';
import 'package:vase/screens/dashboard/dashboard_model.dart';
import 'package:vase/screens/dashboard/pie_chart.dart';
import 'package:vase/screens/widgets/empty.dart';
import 'package:vase/widgets/category_icon.dart';
import 'package:vase/widgets/focused_layout.dart';
import 'package:vase/widgets/wrapper.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
        child: FocusedLayout(
            isScrollable: true,
            appBarTitle: "Dashboard",
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '( ${DateFormat("MMM y").format(Get.arguments)} )',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GetBuilder<DashboardController>(
                  init: DashboardController(Get.arguments),
                  builder: (DashboardController controller) {
                    if (controller.dashboardState.value == VaseState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (controller.sectors.isEmpty) {
                      return const EmptyWidget(
                          assetName: "assets/img/no_cat.svg",
                          label: "No Transactions for the selected month");
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PieChartWidget(controller.getFilteredSectors()),
                        Card(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Sector sector = controller.sectors[index];
                              return ListTile(
                                onTap: () {
                                  sector.switchInclusion();
                                  controller.recalculateTotal();
                                },
                                leading: CategoryIcon(
                                  icon: sector.icon,
                                  bgColor: sector.include
                                      ? sector.color
                                      : AppColors.darkGreyColor,
                                ),
                                title: Text(sector.title),
                                subtitle: Text(
                                    "${sector.share} Items • ${sector.totalPercent(controller.total)}%"),
                                trailing: Text(
                                  sector.amount.s,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            },
                            itemCount: controller.sectors.length,
                          ),
                        )
                      ],
                    );
                  }),
            )));
  }
}
