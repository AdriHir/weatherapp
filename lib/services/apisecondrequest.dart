// creation d'une requete get via l'url
// ne pas oubleir d'apporter la ddependence HTTP =>flutter pub add http
// 45.611,5.5 geoloc de dolomieu




import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:meteoapp/entities/entityMeteo.dart';
import 'package:meteoapp/services/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<MeteoModel>  connectApi([String? currentLocation]) async {
  Position position = await getLocation();
  double latitude = position.latitude;
  double longitude = position.longitude;
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['KEY_API2'];
  final urlMeteoApi = Uri.parse("http://api.openweathermap.org/data/2.5/forecast?lat=45.611&lon=5.5&appid=e06a73be3563aa3f35fda0592683b0e4&units=metric");

  var body = await http
      .get(urlMeteoApi)
      .then((reponse){
    return reponse.body;
  });
  return meteoModelFromJson(body);
}

