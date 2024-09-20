import 'package:flutter/material.dart';
import 'package:meteoapp/components/main_info.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.cityName,
    required this.pays,
    required this.dataJours,
    required this.dataArrived,
    required this.urlIcon,
    required this.tempT,
    required this.today,
    required this.humidite,
    required this.venDirection,
    required this.vent,
    required this.weatherInfoList,
  });

  final String cityName;
  final String pays;
  final String dataJours;
  final bool dataArrived;
  final String urlIcon;
  final String tempT;
  final String today;
  final String humidite;
  final String venDirection;
  final String vent;
  final List<String> weatherInfoList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/pictures/back.jpg"),

                /// ajout d'un background image
                fit: BoxFit.fill)),

        child: MainInfo(
            cityName: cityName,
            pays: pays,
            dataJours: dataJours,
            dataArrived: dataArrived,
            urlIcon: urlIcon,
            tempT: tempT,
            today: today,
            humidite: humidite,
            venDirection: venDirection,
            vent: vent,
            weatherInfoList: weatherInfoList),
      ),
    );
  }
}
