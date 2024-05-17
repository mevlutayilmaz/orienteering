import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../utils/constants/constants.dart';
import '../../utils/colors/custom_colors.dart';

class AboutOrienteeringScreen extends StatelessWidget {
  const AboutOrienteeringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(LocaleConstants.aboutOrienteering.tr()),
      leading: IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _customExpansionTile(LocaleConstants.whatIsOrienteering.tr(), LocaleConstants.whatIsOrienteeringExplain.tr()),
            _customExpansionTile(LocaleConstants.orienteeringHistory.tr(), LocaleConstants.orienteeringHistoryExplain.tr()),
            _customExpansionTile(LocaleConstants.rules.tr(),LocaleConstants.rulesExplain.tr()),
            _customExpansionTile(LocaleConstants.ethicalRules.tr(),LocaleConstants.ethicalRulesExplain.tr()),
          ],
        ),
      ),
    );
  }

  Widget _customExpansionTile(String tittle, String information) {
    return ExpansionTile(
      title: Text(tittle, style: const TextStyle(fontSize: 16)),
      children: [ListTile(title: Text(information),textColor: CustomColors.buttonColor, titleTextStyle: const TextStyle(fontSize: 14))],
      onExpansionChanged: (value) {},
    );
  }
}
