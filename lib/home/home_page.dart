import 'package:flutter/material.dart';
import 'package:weather_application_2/data/repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherRepository weatherRepo = WeatherRepository();

  late Weather weather;

  Future<Weather> fetchWeather() async {
    return weatherRepo.getWeather();
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
        child: FutureBuilder<Weather>(
            future: fetchWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text(
                    "Stadt: Werther",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                      "Gefühlte Temperatur: ${snapshot.hasData ? snapshot.data!.current.apparentTemperature : 0}  °C"),
                  Text(
                    "Temperatur: ${snapshot.hasData ? snapshot.data!.current.temperature : 0}°C",
                  ),
                  Text(
                    "Niederschlag: ${snapshot.hasData ? snapshot.data!.current.precipitation : 0} mm",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Tageszeit: "),
                      Text(
                          
                        snapshot.hasData
                            ? (snapshot.data!.current.isDay)
                                ? "Tag"
                                : "Nacht"
                            : "",),
                    ],
                  ),

                  Text(
                    "Standort:  ${snapshot.hasData ? snapshot.data!.latitude : 0},   ${snapshot.hasData ? snapshot.data!.longitude : 0}",
                  ),
                  Text(
                    "Höhe über NN:  ${snapshot.hasData ? snapshot.data!.elevation : 0} m",
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
                  Text(
                      "letzes Update:  ${snapshot.hasData ? snapshot.data!.current.time : 0}"),
                ],
              );
            }),
      ),
    );
  }
}
