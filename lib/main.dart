import 'package:flutter/material.dart';
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
          tempT = meteoData.list[0].main.temp.toStringAsFixed(0);
          pays = meteoData.city.country.toString();
          today = meteoData.city.population.toStringAsFixed(0);
          tempT = meteoData.list[0].main.temp.toStringAsFixed(1);
          weatherInfoList = weatherList
              .sublist(0, meteoData.list.length)
              .map((daylylist) =>
                  'Tmax:${daylylist.main.tempMax.toStringAsFixed(1)}\nTMin:${daylylist.main.tempMin.toStringAsFixed(1)}')
              .toList();
          // weatherInfoList = forecast
          // .sublist(0, meteoData.forecast.length)
          // sublist applique une fonction de l'indice 0 à la taille du forcast de la list forcast
          //     .map((dailyOnForecast) => // .map applique la fonction dite de transformation ( c'est google qui ma dis ! ) à chaque elemeent de la sous liste qu'on a mis en variable DailyOnforcast
          //     ' ${dailyOnForecast.weather} \n ${meteoData.update.day + 1}/${meteoData.update.month}')
          //      concatenation que l'on veux mettre dans une liste a chauque indice
          //      .toList();
          //cityName= meteoData!.city.name; // on affe
          // cte le nom de la ville
          // cp = meteoData.city.cp.toString();

          // today = meteoData.update.isUtc.toString() + // concatenation de string pour afficher jour date mois annee
          //     " " +
          //     meteoData.update.day.toString() +
          //     " " +
          //     meteoData.update.month.toString() +
          //     " " +
          //  meteoData.update.year.toString();

          // temperatureInfo =
          //     'Tmin: ${forecast[0]?.tmin}°C - Tmax: ${forecast[0]?.tmax}°C';
          //
          // // creation d'une liste weatherInfoList pour les jours à venir.
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
              "$cityName $pays",
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
            const SizedBox(
              height: 150,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 50,
                ),
                Text("Humidité"),
                SizedBox(
                  height: 100,
                  width: 50,
                ),
                Text("Température\n recentie "),
                SizedBox(
                  height: 100,
                  width: 50,
                ),
                Text("Vent :"),
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
