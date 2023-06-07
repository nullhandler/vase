import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/screens/dashboard/dashboard_controller.dart';
import 'package:vase/screens/dashboard/pie_chart.dart';
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PieChartWidget(controller.sectors),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Title',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                'Expense',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.sectors[index].color,
                                ),
                              ),
                              title: Text(
                                controller.sectors[index].title,
                              ),
                              trailing: Text(
                                controller.sectors[index].total.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          },
                          itemCount: controller.sectors.length,
                        )
                      ],
                    );
                  }),
            )));
  }
}
