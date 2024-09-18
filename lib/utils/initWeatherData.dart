import 'package:meteoapp/services/apisecondrequest.dart';
import '../entities/entityMeteo.dart';

Future<void> getWeather(
    void Function(bool succeed, Map<DateTime, List<ListElement>> weatherData, MeteoModel? meteodata, String? errorMessage)
    callback) async {
  try {
    var meteoData = await connectApi();

    // Créer un Map pour organiser les prévisions par jour
    Map<DateTime, List<ListElement>> dailyWeather = {};

    // Regrouper les prévisions par tranche de 3 heures
    for (ListElement prevision in meteoData.list) {
      DateTime date = prevision.dtTxt;
      DateTime day = DateTime(date.year, date.month, date.day); // Extraire le jour

      // Ajouter la prévision au jour correspondant dans le Map
      if (dailyWeather.containsKey(day)) {
        dailyWeather[day]!.add(prevision);
      } else {
        dailyWeather[day] = [prevision];
      }
    }

    callback(true, dailyWeather, meteoData, null);
  } on Exception catch (e) {
    callback(false, {}, null, e.toString());
  } catch (e) {
    callback(false, {}, null, e.toString());
  }
}