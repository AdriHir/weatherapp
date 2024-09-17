import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meteoapp/utils/initParam.dart';

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
  String cp = "";

  String temperatureInfo = '';
  List<String> weatherInfoList = [];
  String today = '';

  @override
  void initState() {
    super.initState();
    getWeatherData((succeed, forecast, meteoData) {
      if (succeed) {
        setState(() {
          cityName = meteoData!.city.name;
          cp = meteoData!.city.cp.toString();

          today = meteoData.update.isUtc.toString() +
              " " +
              meteoData.update.day.toString() +
              " " +
              meteoData.update.month.toString() +
              " " +
              meteoData.update.year.toString();

          temperatureInfo =
              'Tmin: ${forecast[0]?.tmin}°C - Tmax${forecast[0]?.tmax}°C';
          weatherInfoList = forecast
              .sublist(0, meteoData.forecast.length)
              .map((dailyForecast) =>
                  'Jour ${forecast.indexOf(dailyForecast) + 1} : ${dailyForecast.weather}')
              .toList();
        });
      } else {
        setState(() {
          cityName = 'Erreur de récupération des données';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/pictures/back.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$cityName $cp",
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
                "$temperatureInfo",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "$today",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: weatherInfoList.map((weather) {
                          return Container(
                            margin: EdgeInsets.only(right: 15),
                            // met un margin entre les boitesa droite
                            padding: EdgeInsets.all(20),
                            //met un paddind autour du text
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0),
                              // rajoute une opacité<1
                              borderRadius: BorderRadius.circular(
                                  20), //arrondi les 4 angles
                            ),
                            child: Text(
                              weather,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
