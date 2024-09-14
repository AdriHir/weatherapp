// creation d'une requete get via l'url
// ne pas oubleir d'apporter la ddependence HTTP =>flutter pub add http
// 45.611,5.5 geoloc de dolomieu


import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:meteoapp/services/geolocator.dart';

Future<String>  connect() async {

  Position position = await getLocation();
  double latitude = position.latitude;
  double longitude = position.longitude;

  final urlMeteoApi = Uri.parse("https://api.meteo-concept.com/api/forecast/daily?token=e05bc52840d998ee664dcacdddececa7228bfa119b8051ac938f6be295395bd1&latlng=45.55,5.5");

  var Body = await http
      .get(urlMeteoApi)
      .then((reponse){

    return reponse.body;
  });

  return Body;
}