import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../utils/constants/constants.dart';
import '../../utils/colors/custom_colors.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(LocaleConstants.information.tr()),
      leading: IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _customExpansionTile(LocaleConstants.aboutApp.tr(), LocaleConstants.aboutAppExplain.tr()),
            _customExpansionTile(LocaleConstants.userGuide.tr(), LocaleConstants.userGuideExplain.tr()),
            _customExpansionTile(LocaleConstants.contactInformation.tr(),LocaleConstants.contactInformationExplain.tr()),
            _customExpansionTile(LocaleConstants.aboutUs.tr(),LocaleConstants.aboutUsExplain.tr()),
          ],
        ),
      ),
    );
  }

  Widget _customExpansionTile(String tittle, String information) {
    return ExpansionTile(
      title: Text(tittle, style: const TextStyle(fontSize: 16)),
      children: [ListTile(title: Text(information), textColor: CustomColors.buttonColor, titleTextStyle: const TextStyle(fontSize: 14))],
      onExpansionChanged: (value) {},
    );
  }
}
