import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  final int projectEstimate;
  final int totalTasks;
  const ProjectPieChart({
    super.key,
    required this.projectEstimate,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    final residual = (projectEstimate - totalTasks);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: totalTasks.toDouble(),
                  color: Theme.of(context).primaryColor,
                  showTitle: true,
                  title: '${totalTasks}h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PieChartSectionData(
                  value: residual.toDouble(),
                  color: Theme.of(context).primaryColorLight,
                  showTitle: true,
                  title: '${residual}h',
                  titleStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${projectEstimate}h',
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
