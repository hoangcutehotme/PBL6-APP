import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    primaryColorDark: const Color(0x000165fc),
    primaryColorLight: const Color(0x000165fc),
    primaryColor: const Color(0x000165fc),
    fontFamily: 'Inter',
    
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(0, 3, 25, 46),
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0x0014304a),
      ),
      displaySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0x0014304a),
      ),
      bodyLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: Color(0x0014304a),
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Color(0x0014304a),
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Color(0x0014304a),
      ),
    ),
  );
}
