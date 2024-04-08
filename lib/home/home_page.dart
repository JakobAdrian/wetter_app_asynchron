import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void update() {}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Stadt: Stuttgart",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
              ),
            ),
            Text(
              "Gefühlte Temperatur: -10°C",
            ),
            Text(
              "Temperatur: -4°C",
            ),
            Text(
              "Niederschlag: 15.00 mm",
            ),
            Text(
              "Tageszeit: Tag",
            ),
            Text(
              "Standort: lat: 48.783, long: 9.183",
            ),
            TextButton(
              onPressed: () {
                update;
              },
              child: Text("Vorhersage updaten"),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: const Color.fromARGB(255, 0, 0, 0), width: 2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
