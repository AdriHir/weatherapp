import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteoapp/services/geolocator.dart';
import 'package:meteoapp/services/requeteapi.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var requeteData = "";
  String? currentLocation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(requeteData),
            ElevatedButton(
                onPressed: () {
                  connect().then((resBody) {
                    setState(() {
                      requeteData = resBody.city.name;
                    });
                  });
                },
                child: Text("requete")),
            ElevatedButton(
              onPressed: () async {
                Position position = await getLocation();
                setState(() {
                  currentLocation = "${position.latitude}, ${position.longitude}";
                });
              },
              child: Text('Obtenir ma localisation'),
            ),
            Text(currentLocation ?? "Location not available"),

          ],
        ),
      ),
    );
  }
}
