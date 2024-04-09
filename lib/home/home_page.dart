import 'package:flutter/material.dart';
import 'package:weather_application_2/data/repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double elevation = 0.0;
  String time = "";
  double apparentTemperature = 0.0;
  double temperature = 0.0;
  double precipitation = 0.0;
  bool isDay = true;
  double latitude = 0.0;
  double longitude = 0.0;

  WeatherRepository weatherRepo = WeatherRepository();
  late Weather weather;

  void fetchWeather() async {
    weather = await weatherRepo.getWeather();
    setState(() {
      elevation = weather.elevation;
      time = weather.current.time.toString();
      apparentTemperature = weather.current.apparentTemperature;
      temperature = weather.current.temperature;
      precipitation = weather.current.precipitation;
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
              "Stadt: Werther",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
            Text("Gefühlte Temperatur:  $apparentTemperature"),
            Text(
              "Temperatur: $temperature",
            ),
            Text(
              "Niederschlag: $precipitation",
            ),
            Text(
              isDay ? "Tageszeit: Tag" : "Tageszeit: Nacht",
            ),
            Text(
              "Standort:  $latitude,   $longitude",
            ),
            Text(
              "Höhe über NN:  $elevation",
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
            Text("letzes Update:  $time"),
          ],
        ),
      ),
    );
  }
}
