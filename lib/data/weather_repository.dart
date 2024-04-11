import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_application_2/data/location_repository.dart';

class WeatherRepository {
  Future<Weather> getWeather(Location location) async {
    double latitude = location.latitude;
    double longitude = location.longtitude;

    String _url =
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,apparent_temperature,is_day,precipitation,rain&hourly=is_day,sunshine_duration&timezone=Europe%2FBerlin&forecast_hours=24";

    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // print("api-open-mateo-com: ${response.body}");
      return Weather.fromJson(json);
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
// erst einmal auseinandernehmen, da "current" und "weather" zwei verschiedene Dinge sind

class Weather {
  final double elevation;
  final double latitude;
  final double longitude;

  final CurrentWeather current;
  Weather({
    required this.elevation,
    required this.latitude,
    required this.longitude,
    required this.current,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      elevation: json["elevation"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      current: CurrentWeather.fromJson(json["current"]),
    );
  }
}

class CurrentWeather {
  final String time;
  final double temperature;
  final double apparentTemperature; // gefühlte Temperatur
  final bool isDay;
  final double precipitation; // Niederschlag
  CurrentWeather({
    required this.time,
    required this.temperature,
    required this.apparentTemperature,
    required this.isDay,
    required this.precipitation,
  });
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json["time"],
      temperature: json["temperature_2m"],
      apparentTemperature: json["apparent_temperature"],
      isDay: json["is_day"] == 1,
      precipitation: json["precipitation"],
    );
  }
}
