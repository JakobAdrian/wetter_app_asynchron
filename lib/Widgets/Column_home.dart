import 'package:flutter/material.dart';
import 'package:weather_application_2/data/location_repository.dart';
import 'package:weather_application_2/data/weather_repository.dart';
import 'package:weather_application_2/home/home_page.dart';


class ColumnHome
 extends StatefulWidget {
   const ColumnHome
  ({super.key});

  @override
  State<ColumnHome> createState() => _ColumnHomeState();
}

class _ColumnHomeState extends State<ColumnHome> {
  final TextEditingController _controller = TextEditingController();

  WeatherRepository weatherRepo = WeatherRepository();

  LocationRepository locationRepo = LocationRepository();

  String city = "";

Future<Location> fetchCity() async {
    city = _controller.text;
    return locationRepo.getCity(city);
  }

  Future<Weather> fetchWeather() async {
    return weatherRepo.getWeather(await fetchCity());
  }
void saveCityName() async {
    final Location location = await fetchCity();
    locationRepo.saveCityName(location);
    print(location.name);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
              future: fetchWeather(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
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
                              : "",
                        ),
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
                          saveCityName();
                          fetchWeather();
                        });
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2.0),
                          ),
                        ),
                      ),
                      child: const Text("Vorhersage updaten"),
                    ),
                    Text(
                        "letzes Update:  ${snapshot.hasData ? snapshot.data!.current.time : 0}"),
                  ],
                );
              },
            );
  }
}


