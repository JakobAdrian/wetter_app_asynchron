import 'dart:convert';

const jsonString = """
 {
     "latitude": 48.78,
     "longitude": 9.18,
     "current": {
         "time": "2024-01-12T11:45",
         "temperature_2m": -3.6,
         "apparent_temperature": -7.0,
         "is_day": 1,
         "precipitation": 12.00
     }
 }
  """;

class WeatherRepository {
  Future<Weather> getWeather() async {
    await Future.delayed(Duration(seconds: 2)); // einfach nur zum Testen
    return Weather.fromJson(json.decode(jsonString));
  }
}
// erst einmal auseinandernehmen, da "current" und "weather" zwei verschiedene Dinge sind

class Weather {
  final double latitude;
  final double longitude;
  final CurrentWeather current;
  Weather({
    required this.latitude,
    required this.longitude,
    required this.current,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      latitude: json["latitude"],
      longitude: json["longitude"],
      current: CurrentWeather.fromJson(json["current"]),
    );
  }
}

class CurrentWeather {
  final DateTime time;
  final double temperature;
  final double apparentTemperature;
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
      time: DateTime.parse(json["time"]),
      temperature: json["temperature_2m"],
      apparentTemperature: json["apparent_temperature"],
      isDay: json["is_day"] == 1,
      precipitation: json["precipitation"],
    );
  }
  
  
}
