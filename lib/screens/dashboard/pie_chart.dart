import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vase/screens/dashboard/dashboard_model.dart';

class PieChartWidget extends StatelessWidget {
  final List<Sector> sectors;

  const PieChartWidget(this.sectors, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: PieChart(PieChartData(
          sections: _chartSections(sectors),
          centerSpaceRadius: 80.0,
        )));
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 20.0;
      final data = PieChartSectionData(
        titlePositionPercentageOffset: 2.4,
        color: sector.color,
        value: sector.total,
        radius: radius,
        title: sector.title,
      );
      list.add(data);
    }
    return list;
  }
}
