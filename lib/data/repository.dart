import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepository {
  static const _apiKey =
      "https://api.open-meteo.com/v1/forecast?latitude=52.0777&longitude=8.4179&current=temperature_2m,apparent_temperature,is_day,precipitation,rain&hourly=is_day,sunshine_duration&timezone=Europe%2FBerlin&forecast_hours=24";

// API Response:
// {"latitude":48.78,
// "longitude":9.18,
// "generationtime_ms":0.05698204040527344,
// "utc_offset_seconds":7200,
// "timezone":"Europe/Berlin","timezone_abbreviation":"CEST",
// "elevation":247.0,
// "current_units":{
// "time":"iso8601","interval":"seconds","temperature_2m":"°C","apparent_temperature":"°C","is_day":"","precipitation":"mm"},
// "current":{
//   "time":"2024-04-09T15:15",
//   "interval":900,
//   "temperature_2m":12.1,
//   "apparent_temperature":8.6,
//   "is_day":1,
//   "precipitation":0.00}
// }

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse(_apiKey));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(response.body);
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
