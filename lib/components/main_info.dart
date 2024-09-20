import 'package:flutter/material.dart';
import 'package:meteoapp/pages/charpagetest.dart';
import 'package:meteoapp/pages/chartpage.dart';


class MainInfo extends StatelessWidget {
  const MainInfo({
    super.key,
    required this.cityName,
    required this.pays,
    required this.dataJours,
    required this.dataArrived,
    required this.debugMode,
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
  final bool debugMode;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
      /********************************les 3 containers***********************************/
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
                'humidité\n $humidite' ' %',
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
                'Vent -> :\n $venDirection' ' °',
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
                'Vent\n $vent' ' m/s',
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
      if (dataArrived)
        ElevatedButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Chartpage(weatherListInfo: weatherInfoList)),
            )
          },
          child: Text('données de la semaine'),
        ),
      if (debugMode)
        ElevatedButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Chartpagetest(weatherListInfo: weatherInfoList)),
            )
          },
          child: Text('bouton test'),
        ),

      /***************************Expanded Scroll bottom*********************************/
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
    ]);
  }
}
