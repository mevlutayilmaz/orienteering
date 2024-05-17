import 'package:easy_localization/easy_localization.dart';

import '../constants/constants.dart';

class CustomValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleConstants.cannotEmpty.tr();
    }
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value)) {
      return LocaleConstants.validEmail.tr();
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleConstants.cannotEmpty.tr();
    }
    RegExp passwordRegExp = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return LocaleConstants.validPassword.tr();
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleConstants.cannotEmpty.tr();
    }
    if (value.length < 4) {
      return LocaleConstants.validName.tr();
    }
    return null;
  }

  static String? geopointValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleConstants.cannotEmpty.tr();
    }
    double? parsedValue = double.tryParse(value);
    if (parsedValue == null || parsedValue < -90.0 || parsedValue > 90.0) {
      return LocaleConstants.validGeoPoint.tr();
    }
    return null;
  }
}


