import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      primaryColor: const Color(0xFF282E4A),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      fontFamily: 'Optima',
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFD71B1B)),
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Color(0xFF282E4A),
          fontWeight: FontWeight.bold,
          fontSize: 36
        ),
        headline2: TextStyle(
            color: Color(0xFF282E4A),
            fontWeight: FontWeight.bold,
            fontSize: 24
        ),
        headline3: TextStyle(
            color: Color(0xFF282E4A),
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),
        headline4: TextStyle(
            color: Color(0xFF282E4A),
            fontWeight: FontWeight.bold,
            fontSize: 14
        ),
      )
  );

}
