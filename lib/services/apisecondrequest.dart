// creation d'une requete get via l'url
// ne pas oubleir d'apporter la ddependence HTTP =>flutter pub add http
// 45.611,5.5 geoloc de dolomieu




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
  String? apiKey = dotenv.env['KEY_API'];


// position en dur car lemulateur est sur une addresse en amerique que l'API ne prend pas en compte.
  //utilisation changer les 45.611,5.5 par $latitude et $longitude
  final urlMeteoApi = Uri.parse("http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey");

  var body = await http
      .get(urlMeteoApi)
      .then((reponse){

    return reponse.body;
  });

  return meteoModelFromJson(body);
}

