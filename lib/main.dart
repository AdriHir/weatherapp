import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meteoapp/entities/entityMeteo.dart';
import 'package:meteoapp/utils/initWetaher.dart';

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
  String tempT = '';
  List<String> weatherInfoList = [];
  String today = '';
  String weatherIcon = '';
  String pays = '';
  String urlIcon = '';
  String humidite = '';
  String vent = '';
  String venDirection = '';
  String dataJours = '';

  //ici on iniatialise les variables pour les utiliser dans le setState

  @override
  void initState() {
    super.initState();
    getWeather((succeed, List<ListElement> weatherList, meteoData) {
      if (succeed) {
        // met en place les setStates qu'on desire utiliser depuis la reponse api
        setState(() {
          cityName = meteoData!.city.name;
          weatherIcon = meteoData.list[0].weather[0]
              .icon; //recuperation du code icon de ladatabase
          urlIcon = "https://openweathermap.org/img/wn/${weatherIcon}@2x.png";
          humidite = meteoData.list[0].main.humidity.toString();
          tempT = meteoData.list[0].main.temp.toStringAsFixed(0);
          pays = meteoData.city.country.toString();
          today = meteoData.city.population.toStringAsFixed(0);
          tempT = meteoData.list[0].main.temp.toStringAsFixed(1);
          weatherInfoList = weatherList
              .sublist(0, meteoData.list.length)
              .map((daylylist) =>
                  'Tmax:${daylylist.main.tempMax.toStringAsFixed(1)}\nTMin:${daylylist.main.tempMin.toStringAsFixed(1)}')
              .toList();
          vent = meteoData.list[0].wind.speed.toString();
          venDirection = meteoData.list[0].wind.deg.toString();

          DateTime date = DateTime.now();
          DateFormat formatter = DateFormat('EEEE d MMMM yyyy','pt_FR');
          dataJours = formatter.format(date);


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
          child: Column(children: [
            const Spacer(),
            Text(
              "$cityName $pays \n $dataJours",
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            Image.network(urlIcon),
            Text(
              "$tempT C°",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Population :  $today  d'habitants ",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 100,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black54,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(3, -3),
                      ),
                    ],
                  ),
                  // Add the Text widget inside the Container with desired styling:
                  child: Center(
                    child: Text(
                      'humidité\n $humidite' + ' %',
                      style: TextStyle(
                        fontSize: 18, // Adjust font size as needed
                        color: Colors.white70, // Adjust text color as needed
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black87,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(3, -3),
                      ),
                    ],
                  ),
                  // Add the Text widget inside the Container with desired styling:
                  child: Center(
                    child: Text(
                      'Vent -> :\n $venDirection' + ' °',
                      style: TextStyle(
                        fontSize: 18, // Adjust font size as needed
                        color: Colors.white70, // Adjust text color as needed
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.indigo,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.45),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(3, -3),
                      ),
                    ],
                  ),
                  // Add the Text widget inside the Container with desired styling:
                  child: Center(
                    child: Text(
                      'Vent\n $vent' + ' m/s',
                      style: TextStyle(
                        fontSize: 18, // Adjust font size as needed
                        color: Colors.white70, // Adjust text color as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: weatherInfoList.map((weather) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.network(
                                  urlIcon,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 15,
                              right: 00,
                              child: Text(
                                weather,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
