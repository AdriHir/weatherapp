import 'package:flutter/material.dart';
import 'package:meteoapp/components/chart_component.dart';

class Chartpage extends StatefulWidget {
  final List<String> weatherListInfo;
   Chartpage({Key? key, required this.weatherListInfo}) :
        super(key: key);

  @override
  _ChartpageState createState() => _ChartpageState();
}

class _ChartpageState extends State<Chartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(child: BarChartComponent(weatherListInfo: [],)),
        // Ajoutez un body pour le contenu de la page

      ),
    );
  }
}