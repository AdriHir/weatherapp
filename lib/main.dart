import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:meteoapp/entities/entityMeteo.dart';
import 'package:meteoapp/pages/main_page.dart';
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
  List<ListElement> weatherPre15day = [];
  Map dailayWeather = {};
  bool debugMode = false;


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
          debugMode = false;
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
            weatherPre15day.add(meteoData.list[i]);
          }
          weatherInfoList = weatherPre15day
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
      home: MainPage(
          cityName: cityName,
          pays: pays,
          dataJours: dataJours,
          dataArrived: dataArrived,
          debugMode: debugMode,
          urlIcon: urlIcon,
          tempT: tempT,
          today: today,
          humidite: humidite,
          venDirection: venDirection,
          vent: vent,
          weatherInfoList: weatherInfoList),
    );
  }
}
