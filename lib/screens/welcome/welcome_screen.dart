import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../router/routes.dart';
import '../../utils/constants/constants.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Center _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LocaleConstants.welcome.tr(), style: Theme.of(context).textTheme.headlineLarge),
          const Image(image: AssetImage("lib/assets/images/orienteering-animation.png")),
          _buildRow(context),
        ],
      ),
    );
  }

  Row _buildRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () => Navigator.of(context).pushNamed(Routes.login), child: Text(LocaleConstants.login.tr())),
        const SizedBox(width: 20),
        OutlinedButton(onPressed: () => Navigator.of(context).pushNamed(Routes.signup), child: Text(LocaleConstants.signUp.tr())),
      ],
    );
  }
}
