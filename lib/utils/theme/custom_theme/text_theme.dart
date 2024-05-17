import 'package:flutter/material.dart';

class TTextTheme {
  TTextTheme._();

  static final lightTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold),
    headlineMedium: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.bold),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),

    bodyLarge: const TextStyle().copyWith(fontSize: 19.0),
    bodyMedium: const TextStyle().copyWith(fontSize: 16.0),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0),

    
  );

  static final darkTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),

    bodyLarge: const TextStyle().copyWith(fontSize: 19.0, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 16.0, color: Colors.white),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, color: Colors.white),
  );
}