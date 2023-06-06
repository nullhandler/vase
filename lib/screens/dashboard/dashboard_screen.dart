import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                            children: [Text('Title'), Text('Expense')],
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
                              title: Text(controller.sectors[index].title),
                              trailing: Text(
                                  controller.sectors[index].total.toString()),
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
