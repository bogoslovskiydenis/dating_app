import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      primaryColor: const Color(0xFF282E4A),
      scaffoldBackgroundColor: Colors.white,
      dialogBackgroundColor: const Color(0xFFCCCED7),
      fontFamily: 'Optima',
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFD71B1B)),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Color(0xFF282E4A),
          fontWeight: FontWeight.bold,
          fontSize: 36
        ),
        headlineMedium: TextStyle(
            color: Color(0xFF282E4A),
            fontWeight: FontWeight.bold,
            fontSize: 24
        ),
        headlineSmall: TextStyle(
            color: Color(0xFF282E4A),
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),
        titleMedium: TextStyle(
            color: Color(0xFF282E4A),
            fontWeight: FontWeight.bold,
            fontSize: 14
        ),
        labelLarge: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bodyLarge: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        bodySmall: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      )
  );

}
