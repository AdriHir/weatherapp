import 'package:geolocator/geolocator.dart';
//fonction de geolocalisation return la lng et lat
Future<Position> getLocation() async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Permission de geolocalisation refusé');
    }
  }
  if(permission == LocationPermission.deniedForever){
    return Future.error("Nous ne pouvons pas acceder à la géolocalisation car celle ci est toujorus refusé");
  }
  return await Geolocator.getCurrentPosition();
}

