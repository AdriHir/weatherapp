import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meteoapp/entities/entityMeteo.dart';
import 'package:meteoapp/pages/chartpage.dart';
import 'package:meteoapp/utils/initWeatherData.dart';

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
  bool dataArrived = false;
  List<ListElement> weatherPre10day = [];
  Map dailayWeather = {};

  // for (int i = 0; i < meteoData.list.length; i++) {
  //   factories.add(meteoData.list[i]);
  // }
  //
  //
  //ici on iniatialise les variables pour les utiliser dans le setState

  @override
  void initState() {
    super.initState();
    getWeather((succed, dailyWeather, meteoData, Null) {
      if (succed) {
        // met en place les setStates qu'on desire utiliser depuis la reponse api
        setState(() {
          dataArrived = true;
          cityName = meteoData!.city.name;
          weatherIcon = meteoData.list[0].weather[0]
              .icon; //recuperation du code icon de ladatabase
          urlIcon = "https://openweathermap.org/img/wn/${weatherIcon}@2x.png";
          humidite = meteoData.list[0].main.humidity.toString();
          tempT = meteoData.list[0].main.temp.toStringAsFixed(0);
          pays = meteoData.city.country.toString();
          today = meteoData.city.population.toStringAsFixed(0);
          tempT = meteoData.list[0].main.temp.toStringAsFixed(1);
          /*************************creation d'un tableau des jours à venir************************************/
          for (int i = 0; i < meteoData.list.length; i++) {
            weatherPre10day.add(meteoData.list[i]);
          }
          weatherInfoList = weatherPre10day
              /*******************************si j'ai bien compris on affecte les indice du tableau qu'on affcecte a une map******************************************/
              .sublist(0, meteoData.list.length)
              .map((daylylist) =>
                  /***************************** on affecte les données qu'on veux afficher dans la map***************************************************/
                  'Tmax:${daylylist.main.tempMax.toStringAsFixed(1)}\nTMin:${daylylist.main.tempMin.toStringAsFixed(1)}')
              .toList();
          /**************************************************************/
          vent = meteoData.list[0].wind.speed.toString();
          venDirection = meteoData.list[0].wind.deg.toString();
          initializeDateFormatting(); // iniatialise la fonction intl
          DateTime nowUtc = DateTime.now(); //on récupere la date du jours.
          DateFormat localFormat = DateFormat.yMMMMEEEEd(
              'fr'); // on formate la date d'affichage jours date mois année
          dataJours = localFormat
              .format(nowUtc); // on met la formatagedans une variable.
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

                  /// ajout d'un background image
                  fit: BoxFit.fill)),
          child: Column(children: [
            const Spacer(),
            /******************************************Nom de la ville******************************************/
            Text(
              "$cityName $pays",
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            /**************************************Date du jour**********************************/
            Text(
              '$dataJours',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            /*********************************Icon**************************************************/
            if (dataArrived) Image.network(urlIcon),
            //affectation d'une variable pour evite l'erreur d'affichage en attendant la recuperation
            /******************************Temperature********************************************/
            Text(
              "$tempT C°",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            /***************************Population ****************************************/
            Text(
              "Population :  $today  d'habitants ",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /*********************Container 1 Humidité************************************************************/
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
                        offset: const Offset(3, -3),
                      ),
                    ],
                  ),
                  // Add the Text widget inside the Container with desired styling:
                  child: Center(
                    child: Text(
                      'humidité\n $humidite' + ' %',
                      style: const TextStyle(
                        fontSize: 18, // Adjust font size as needed
                        color: Colors.white70, // Adjust text color as needed
                      ),
                    ),
                  ),
                ),
                /***************************Container2 vent ->****************************************/
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
                        offset: const Offset(3, -3),
                      ),
                    ],
                  ),
                  // Add the Text widget inside the Container with desired styling:
                  child: Center(
                    child: Text(
                      'Vent -> :\n $venDirection' + ' °',
                      style: const TextStyle(
                        fontSize: 18, // Adjust font size as needed
                        color: Colors.white70, // Adjust text color as needed
                      ),
                    ),
                  ),
                ),
                /*****************Container 3 vent m/s******************************/
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
                        offset: const Offset(3, -3),
                      ),
                    ],
                  ),
                  // Add the Text widget inside the Container with desired styling:
                  child: Center(
                    child: Text(
                      'Vent\n $vent' + ' m/s',
                      style: const TextStyle(
                        fontSize: 18, // Adjust font size as needed
                        color: Colors.white70, // Adjust text color as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Chartpage( listDailyWheather: {"la futur map des données","encore des données","toujorus des données"} )),
                  );
                },
                child: Text("temperature du jour ")),

            /***************************Expanded Scroll Men*********************************/
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
