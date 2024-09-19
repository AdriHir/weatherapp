import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class BarChartComponent extends StatefulWidget {
  const BarChartComponent({super.key});

  @override
  State<BarChartComponent> createState() => BarChartComponentState();
}

class BarChartComponentState extends State<BarChartComponent> {
  List<_DayWeek> data = [
    _DayWeek('Lun', 35),
    _DayWeek('Mar', 28),
    _DayWeek('Mer', 34),
    _DayWeek('Jeu', 32),
    _DayWeek('Ven', 40),
    _DayWeek('Sam', 40),
    _DayWeek('Dim', 40),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SfCartesianChart(
            primaryXAxis:CategoryAxis(title: AxisTitle(text: "test"),
              name: "°C",
            ),
          )
        ],
      ),
    );
  }
}

class _DayWeek {
  _DayWeek(this.year, this.sales);

  final String year;
  final double sales;
}
