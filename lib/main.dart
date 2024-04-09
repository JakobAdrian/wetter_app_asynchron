import 'package:flutter/material.dart';
import 'package:weather_application_2/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
  title: "Wetter App",
  theme: ThemeData(
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ),
  home: const MyHomePage(title: "Wetter App"),
);
  }
}
