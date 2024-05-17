import 'package:flutter/material.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static final lightTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      padding: EdgeInsets.zero,
      foregroundColor: Colors.blue[600],
      
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    )
  );

  static final darkTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      padding: EdgeInsets.zero,
      foregroundColor: Colors.blue[600],
      
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    )
  );

}