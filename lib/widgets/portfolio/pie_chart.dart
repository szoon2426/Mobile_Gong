import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final List<double> studyTimes;

  const PieChartWidget({super.key, required this.studyTimes});

  @override
  Widget build(BuildContext context) {
    final sections = List.generate(
      3,
      (i) => PieChartSectionData(
        value: studyTimes[i],
        title: "${studyTimes[i].toStringAsFixed(1)}h",
        radius: 60,
        color: _getColor(i),
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PieChart(PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: sections,
      )),
    );
  }

  Color _getColor(int index) {
    switch (index) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
