import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/home_screen.dart';
import 'package:flutter_application_1/screens/recipes/recipes_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'package:flutter_application_1/screens/map/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuenProvecho',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1B5E57),
      ),
      home: MapScreen (),
    );
  }
}
