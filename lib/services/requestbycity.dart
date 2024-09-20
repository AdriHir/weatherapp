// // creation d'une requete get via l'url
// // ne pas oubleir d'apporter la ddependence HTTP =>flutter pub add http
// // 45.611,5.5 geoloc de dolomieu
//
//
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
//
// import '../entities/meteoEntity.dart';
//
//
// Future<Meteo> connect(String? city) async {
//   await dotenv.load(fileName: ".env");
//   String? apiKey = dotenv.env['API_KEY'];
//   String? ville = city;
//
//   final urlMeteoApi = Uri.parse(
//       "https://api.meteo-concept.com/api/location/cities?token=$apiKey=$ville");
//
//
//   var body = await http.get(urlMeteoApi).then((reponse) {
//     return reponse.body;
//   });
//
//   return MeteoFromJson(body);
// }
