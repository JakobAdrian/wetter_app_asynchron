import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_application_2/home/home_page.dart';

class LocationRepository {
  static const _apiKey = "T6TAVxg5YZfGUrrEk16H0Q==hENsMFUl3TZ3EtoB";

  Future<Location> getCity(String city) async {
    final _url = 'https://api.api-ninjas.com/v1/geocoding?city=$city';
    final response =
        await http.get(Uri.parse(_url), headers: {'X-Api-Key': _apiKey});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("api-ninja: ${response.body}");
      return Location.fromJson(json[0]);
    } else {
      throw Exception("Failed to load weather");
    }
  }
}

class Location {
  final double longtitude;
  final double latitude;

  Location({
    required this.longtitude,
    required this.latitude,
  });
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      longtitude: json["longitude"],
      latitude: json["latitude"],
    );
  }
}
