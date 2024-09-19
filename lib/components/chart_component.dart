import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartComponent extends StatefulWidget {
  const BarChartComponent({super.key});

  @override
  State<BarChartComponent> createState() => BarChartComponentState();
}

class BarChartComponentState extends State<BarChartComponent> {
  List<_DayWeek> temperatures = [
    _DayWeek('Lun', 15),
    _DayWeek('Mar', -10),
    _DayWeek('Mer', 35),
    _DayWeek('Jeu', -15),
    _DayWeek('Ven', 25),
    _DayWeek('Sam', 18),
    _DayWeek('Dim', 7),
  ];

  List<_rainning> precipitation = [
    _rainning('Lun', 2),
    _rainning('Mar', 25),
    _rainning('Mer', 30),
    _rainning('Jeu', 46),
    _rainning('Ven', 15),
    _rainning('Sam', 18),
    _rainning('Dim', 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(

            majorGridLines: MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
            title: AxisTitle(text:
            'Valeurs'),
          ),
          legend: Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries>[
            ColumnSeries<_DayWeek, String>(
              dataSource: temperatures,
              xValueMapper: (_DayWeek day, _) => day.week,
              yValueMapper: (_DayWeek day, _) => day.jours,
              name: 'Température (°C)',
              color: Colors.red,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
            LineSeries<_rainning, String>(
              dataSource: precipitation,
              xValueMapper: (_rainning time, _) => time.jour,
              yValueMapper: (_rainning time, _) => time.preci,
              name: "Précipitations (mm)",
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class _rainning {
  _rainning(this.jour, this.preci);

  final String jour;
  final double preci;
}

class _DayWeek {
  _DayWeek(this.week, this.jours);

  final String week;
  final double jours;
}

Color getColor(double temperature) {
  if (temperature <= 10) {
    return Colors.blue;
  } else if (temperature <= 25) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}
