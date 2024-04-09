import 'package:flutter/material.dart';
import 'package:weather_application_2/data/repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apparentTemperature = "";
  String temperature = "";
  String precipitation = "";
  bool isDay = true;
  double latitude = 0.0;
  double longitude = 0.0;

  WeatherRepository weatherRepo = WeatherRepository();
  late Weather weather;

  void fetchWeather() async {
    weather = await weatherRepo.getWeather();
    setState(() {
      apparentTemperature = weather.current.apparentTemperature.toString();
      temperature = weather.current.temperature.toString();
      precipitation = weather.current.precipitation.toString();
      isDay = weather.current.isDay;
      latitude = weather.latitude;
      longitude = weather.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              "Stadt: \nStuttgart",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
            Text("Gefühlte Temperatur:  \n$apparentTemperature"),
            Text(
              "Temperatur: \n$temperature",
            ),
            Text(
              "Niederschlag: \n$precipitation",
            ),
            Text(
              isDay ? "Tageszeit: \nTag" : "Tageszeit: \nNacht",
            ),
            Center(
              child: Text(
                "Standort: \n $latitude,  \n $longitude",
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  fetchWeather();
                });
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                  ),
                ),
              ),
              child: const Text("Vorhersage updaten"),
            ),
          ],
        ),
      ),
    );
  }
}
