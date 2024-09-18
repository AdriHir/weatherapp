import 'package:meteoapp/services/apisecondrequest.dart';
import '../entities/entityMeteo.dart';

Future<void> getWeather(
    void Function(bool succeed, List<ListElement> factories, MeteoModel? meteodata)
        callback) async {
  try {
    var meteoData = await connectApi();

    // Créer une liste pour stocker les prévisions
    List<ListElement> factories = [];
    for (int i = 0; i < meteoData.list.length; i++) {
      factories.add(meteoData.list[i]);
    }

    callback(true, factories, meteoData);
  } catch (e) {
    callback(false, [],null);
  }
}
