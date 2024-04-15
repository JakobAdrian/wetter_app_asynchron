import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<Location?> getSavedCityName() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); //aus der Dokumentation kopiert

    final nameString = prefs.getString("name");
    if (nameString == null) {
      return null;
    }
    final jsonMap = jsonDecode(nameString);
    final nameObjekt = Location.fromJson(jsonMap);
    return nameObjekt;
  }

  Future<void> saveCityName(Location name) async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance(); //aus der Dokumentation kopiert

    final nameMap = name.toJson();
    final nameString = jsonEncode(nameMap);
    await prefs.setString("name", nameString);
  }
}

class Location {
  final String name;
  final double longitude;
  final double latitude;

  Location({
    required this.name,
    required this.longitude,
    required this.latitude,
  });
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json["name"],
      longitude: json["longitude"],
      latitude: json["latitude"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "longitude": longitude,
      "latitude": latitude,
    };
  }

  
}
