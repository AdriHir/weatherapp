import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meteoapp/entities/meteoEntity.dart';
import 'package:meteoapp/services/requeteapi.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String cityName = 'Chargement...';
  Meteo? meteoData;
  String weatherInfo = '';
  String temperatureInfo = ''; // Variable pour la température

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      meteoData = await connect();
      final forecast = meteoData!.forecast[0];
      setState(() {
        cityName = meteoData!.city.name;
        weatherInfo = 'Météo : ${forecast.weather}';
        temperatureInfo = 'Tmin: ${forecast.tmin}°C - Tmax${forecast.tmax}°C';
        //
      });
    } catch (e) {
      setState(() {
        cityName = 'Erreur de récupération des données';
      });
    }
  }

  // void show update

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image:DecorationImage(
            image: AssetImage("lib/assets/pictures/back.jpg"),
              fit: BoxFit.fill
            )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$cityName",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(
                    "lib/assets/icons/animated/rainy-1.svg",
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              Text(
                weatherInfo,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                temperatureInfo, // Afficher la température
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
