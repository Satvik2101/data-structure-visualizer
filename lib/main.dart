import 'dart:math';

import 'package:ds_visualizer/screens/array_screen.dart';
import 'package:ds_visualizer/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(Colors.black),
        textTheme: TextTheme(
          headline1: GoogleFonts.exo(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: 32,
          ),
          headline2: GoogleFonts.raleway(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 28,
          ),
          headline3: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
          headline4: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
          headline5: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 28,
          ),
          bodyText1: GoogleFonts.rosario(
            fontSize: 17,
            color: Colors.black,
          ),
          bodyText2: GoogleFonts.poppins(
            fontSize: 17,
            color: Colors.black,
          ),
        ),
      ),
      home: HomeScreen(),
      routes: {
        ArrayScreen.routeName: (ctx) => const ArrayScreen(),
      },
    );
  }
}
