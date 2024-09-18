// import '../entities/meteoEntity.dart';
// import '../services/requeteapi.dart';
//
// Future<void> getWeatherData(void Function(bool succeed, List<Forecast> forecasts, Meteo? meteodata) callback) async {
//   try {
//     var meteoData = await connect();
//
//     // Créer une liste pour stocker les prévisions
//     List<Forecast> forecasts = [];
//
//     for (int i = 0; i < meteoData.forecast.length ; i++) {
//       forecasts.add(meteoData.forecast[i]);
//     }
//
//     callback(true, forecasts, meteoData);
//   } catch (e) {
//     callback(false, [], null);
//   }
// }
//
