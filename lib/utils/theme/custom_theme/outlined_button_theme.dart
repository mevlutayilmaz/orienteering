import 'package:flutter/material.dart';

import '../../colors/custom_colors.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: CustomColors.buttonColor,
      textStyle: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(color: CustomColors.buttonColor),
    )
  );

  static final darkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: CustomColors.buttonColor,
      textStyle: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      side: const BorderSide(color: CustomColors.buttonColor),
    )
  );
}