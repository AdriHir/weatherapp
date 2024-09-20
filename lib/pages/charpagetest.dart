import 'package:flutter/material.dart';
import 'package:meteoapp/components/chart_testing_component.dart';

class Chartpagetest extends StatefulWidget {
  final List<String> weatherListInfo;

  Chartpagetest({Key? key, required this.weatherListInfo}) : super(key: key);

  @override
  _ChartpagetestState createState() => _ChartpagetestState();
}

class _ChartpagetestState extends State<Chartpagetest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: BarChartComponentTest(
          weatherListInfo: widget.weatherListInfo,
        )),
        // Ajoutez un body pour le contenu de la page
      ),
    );
  }
}
