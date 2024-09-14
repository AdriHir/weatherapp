// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  City city;
  DateTime update;
  List<Forecast> forecast;

  Welcome({
    required this.city,
    required this.update,
    required this.forecast,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    city: City.fromJson(json["city"]),
    update: DateTime.parse(json["update"]),
    forecast: List<Forecast>.from(json["forecast"].map((x) => Forecast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "city": city.toJson(),
    "update": update.toIso8601String(),
    "forecast": List<dynamic>.from(forecast.map((x) => x.toJson())),
  };
}

class City {
  String insee;
  int cp;
  String name;
  double latitude;
  double longitude;
  int altitude;

  City({
    required this.insee,
    required this.cp,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.altitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    insee: json["insee"],
    cp: json["cp"],
    name: json["name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    altitude: json["altitude"],
  );

  Map<String, dynamic> toJson() => {
    "insee": insee,
    "cp": cp,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "altitude": altitude,
  };
}

class Forecast {
  String insee;
  int cp;
  double latitude;
  double longitude;
  int day;
  String datetime;
  int wind10M;
  int gust10M;
  int dirwind10M;
  double rr10;
  double rr1;
  int probarain;
  int weather;
  int tmin;
  int tmax;
  int sunHours;
  int etp;
  int probafrost;
  int probafog;
  int probawind70;
  int probawind100;
  int gustx;

  Forecast({
    required this.insee,
    required this.cp,
    required this.latitude,
    required this.longitude,
    required this.day,
    required this.datetime,
    required this.wind10M,
    required this.gust10M,
    required this.dirwind10M,
    required this.rr10,
    required this.rr1,
    required this.probarain,
    required this.weather,
    required this.tmin,
    required this.tmax,
    required this.sunHours,
    required this.etp,
    required this.probafrost,
    required this.probafog,
    required this.probawind70,
    required this.probawind100,
    required this.gustx,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    insee: json["insee"],
    cp: json["cp"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    day: json["day"],
    datetime: json["datetime"],
    wind10M: json["wind10m"],
    gust10M: json["gust10m"],
    dirwind10M: json["dirwind10m"],
    rr10: json["rr10"]?.toDouble(),
    rr1: json["rr1"]?.toDouble(),
    probarain: json["probarain"],
    weather: json["weather"],
    tmin: json["tmin"],
    tmax: json["tmax"],
    sunHours: json["sun_hours"],
    etp: json["etp"],
    probafrost: json["probafrost"],
    probafog: json["probafog"],
    probawind70: json["probawind70"],
    probawind100: json["probawind100"],
    gustx: json["gustx"],
  );

  Map<String, dynamic> toJson() => {
    "insee": insee,
    "cp": cp,
    "latitude": latitude,
    "longitude": longitude,
    "day": day,
    "datetime": datetime,
    "wind10m": wind10M,
    "gust10m": gust10M,
    "dirwind10m": dirwind10M,
    "rr10": rr10,
    "rr1": rr1,
    "probarain": probarain,
    "weather": weather,
    "tmin": tmin,
    "tmax": tmax,
    "sun_hours": sunHours,
    "etp": etp,
    "probafrost": probafrost,
    "probafog": probafog,
    "probawind70": probawind70,
    "probawind100": probawind100,
    "gustx": gustx,
  };
}
