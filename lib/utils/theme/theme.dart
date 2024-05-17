import 'package:flutter/material.dart';

import '../colors/custom_colors.dart';
import 'custom_theme/appbar_theme.dart';
import 'custom_theme/elevated_button_theme.dart';
import 'custom_theme/input_decoration_theme.dart';
import 'custom_theme/outlined_button_theme.dart';
import 'custom_theme/text_button_theme.dart';
import 'custom_theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: CustomColors.primaryColorLight,    
    scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColorLight,
    textTheme: TTextTheme.lightTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightTheme,
    appBarTheme: TAppBarTheme.lightTheme,
    textButtonTheme: TTextButtonTheme.lightTheme,
    inputDecorationTheme: TInputDecorationTheme.lightTheme,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: CustomColors.scaffoldBackgroundColorLight,
    ),
    dialogBackgroundColor: CustomColors.scaffoldBackgroundColorLight,

  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: CustomColors.primaryColorDark,
    scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColorDark,
    textTheme: TTextTheme.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkTheme,
    appBarTheme: TAppBarTheme.darkTheme,
    textButtonTheme: TTextButtonTheme.darkTheme,
    inputDecorationTheme: TInputDecorationTheme.darkTheme,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: CustomColors.scaffoldBackgroundColorDark,
    ),
    dialogBackgroundColor: CustomColors.scaffoldBackgroundColorDark,

  );

}