import 'package:flutter/material.dart';

import '../../colors/custom_colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: CustomColors.buttonColor,
      foregroundColor: CustomColors.primaryColorLight,
      textStyle: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    )
  );

  static final darkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: CustomColors.buttonColor,
      foregroundColor: CustomColors.primaryColorDark,
      textStyle: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    )
  );
}