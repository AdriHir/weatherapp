import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartComponent extends StatefulWidget {
  final List<String> weatherListInfo;

  const BarChartComponent({super.key, required, required this.weatherListInfo});

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
  List<_Humidity> humidity = [
    _Humidity('Lun', 60),
    _Humidity('Mar', 75),
    _Humidity('Mer', 75),
    _Humidity('Jeu', 75),
    _Humidity('Ven', 75),
    _Humidity('Sam', 75),
    _Humidity('Dim', 75),
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                title: AxisTitle(text: 'temperatures (°C)'),
              ),
              axes: <ChartAxis>[
                NumericAxis(
                  name: 'yAxis',
                  opposedPosition: true,
                  title: AxisTitle(
                    text: "pprécipitation (mm)",
                  ),
                )
              ],
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
                  xValueMapper: (_rainning time, _) => time.x,
                  yValueMapper: (_rainning time, _) => time.y,
                  yAxisName: 'yAxis',
                  name: "Précipitations",
                  color: Colors.blue,
                ),
              ],
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                title: AxisTitle(text: 'humidité (%)'),
                minimum: 40,
              ),
              // Configuration des axes et des séries pour l'humidité
              series: <CartesianSeries>[
                LineSeries<_Humidity, String>(
                  dataSource: humidity,
                  xValueMapper: (_Humidity day, _) => day.day,
                  yValueMapper: (_Humidity day, _) => day.humidity,
                  name: "Humidité (%)",
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _rainning {
  _rainning(this.x, this.y);

  final String x;
  final double? y;
}

class _DayWeek {
  _DayWeek(this.week, this.jours);

  final String week;
  final double jours;
}

class _Humidity {
  _Humidity(this.day, this.humidity);

  final String day;
  final double humidity;
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
