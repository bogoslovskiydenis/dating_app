import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      primaryColor: const Color(0xFF282E4A),
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      dialogBackgroundColor: const Color(0xFFCCCED7),
      fontFamily: 'Optima',
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFD71B1B)),
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
        headline6: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bodyText1: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        bodyText2: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      )
  );

}
