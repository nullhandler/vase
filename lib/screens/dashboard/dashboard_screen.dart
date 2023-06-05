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
              child:  GetBuilder<DashboardController>(
          init: DashboardController(),
          builder: (DashboardController controller) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  PieChartWidget(controller.sectors)
                ],
              );}),
            )));
  }
}
