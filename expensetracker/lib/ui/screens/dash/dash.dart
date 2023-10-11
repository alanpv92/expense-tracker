import 'package:expensetracker/ui/models/chart.dart';
import 'package:expensetracker/ui/widgets/charts/pie.dart';
import 'package:flutter/material.dart';

class Dash extends StatelessWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomAnimatedPieChart(chartDataSet: [
          ChartDataSet(color: Colors.black, label: 'test1', value: 100),
          ChartDataSet(color: Colors.blue, label: 'test2', value: 200),
          ChartDataSet(color: Colors.red, label: 'test3', value: 200),
        ]),
      ),
    );
  }
}
