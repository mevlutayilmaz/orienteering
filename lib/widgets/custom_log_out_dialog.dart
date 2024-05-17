import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

void logOutDialog(BuildContext context, VoidCallback onPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.bottomSlide,
      headerAnimationLoop: false,
      dismissOnTouchOutside: false,
      dialogType: DialogType.error,
      showCloseIcon: false,
      title: LocaleConstants.logOut.tr(),
      desc: LocaleConstants.wannaLogout.tr(),
      btnOkText: LocaleConstants.ok.tr(),
      btnCancelText: LocaleConstants.cancel.tr(),
      btnOkOnPress: onPress ,
      btnCancelOnPress: () {},
    ).show();
  }