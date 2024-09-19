import 'package:flutter/material.dart';
import 'package:meteoapp/components/chart_component.dart';

class Chartpage extends StatefulWidget {
   Chartpage({Key? key}) : super(key: key);

  @override
  _ChartpageState createState() => _ChartpageState();
}

class _ChartpageState extends State<Chartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("METEO DU JOUR"),
      ),
      body: Container(
        child: BarCharts(),
        // Ajoutez un body pour le contenu de la page

      ),
    );
  }
}