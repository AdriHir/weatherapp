// creation d'une requete get via l'url
// ne pas oubleir d'apporter la ddependence HTTP =>flutter pub add http
// 45.611,5.5 geoloc de dolomieu




import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:meteoapp/entities/meteoEntitie.dart';
import 'package:meteoapp/services/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Welcome>  connect() async {


  Position position = await getLocation();
  double latitude = position.latitude;
  double longitude = position.longitude;
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];


  final urlMeteoApi = Uri.parse("https://api.meteo-concept.com/api/forecast/daily?token=$apiKey&latlng=45.55,5.5");

  var body = await http
      .get(urlMeteoApi)
      .then((reponse){

    return reponse.body;
  });

  return welcomeFromJson(body);
}

