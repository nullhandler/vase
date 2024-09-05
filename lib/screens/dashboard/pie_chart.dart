import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vase/screens/dashboard/dashboard_model.dart';

class PieChartWidget extends StatelessWidget {
  final List<Sector> sectors;

  const PieChartWidget(this.sectors, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: PieChart(PieChartData(
            sections: _chartSections(sectors),
            centerSpaceRadius: 40.0,
            sectionsSpace: 1)));
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        titlePositionPercentageOffset: 2,
        color: sector.color,
        value: sector.amount,
        radius: radius,
        title: sector.title,
      );
      list.add(data);
    }
    return list;
  }
}
