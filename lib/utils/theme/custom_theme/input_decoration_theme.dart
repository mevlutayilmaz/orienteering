import 'package:flutter/material.dart';

import '../../colors/custom_colors.dart';

class TInputDecorationTheme {
  TInputDecorationTheme._();

  static final lightTheme = InputDecorationTheme(
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: CustomColors.primaryColorLight)) ,
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: CustomColors.primaryColorLight)) ,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: CustomColors.primaryColorLight)),
    filled: true,
    fillColor: CustomColors.primaryColorLight,
  );

  static final darkTheme = InputDecorationTheme(
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: CustomColors.primaryColorDark)) ,
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: CustomColors.primaryColorDark)) ,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: CustomColors.primaryColorDark)),
    filled: true,
    fillColor: CustomColors.primaryColorDark,
  );

}