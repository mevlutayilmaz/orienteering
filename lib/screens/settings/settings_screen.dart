import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:provider/provider.dart';

import '../../utils/colors/custom_colors.dart';
import '../../utils/constants/constants.dart';
import '../../utils/theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: _buildBody(context, themeNotifier),
          ); 
        }
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(LocaleConstants.settings.tr()),
      leading: IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }

  Widget _buildBody(BuildContext context, ModelTheme themeNotifier) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              _selectLanguage(context),
              const SizedBox(height: 10),
              _selectTheme(themeNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectLanguage(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      onChanged: (value) => setState(() {
        final Locale newLocale;
        value == 'tr_TR'
            ? newLocale = LocaleConstants.trLocale
            : newLocale = LocaleConstants.enLocale;
          context.setLocale(newLocale);
          Get.updateLocale(newLocale);
      }),
      value: context.locale.toString(),
      items: const [
        DropdownMenuItem(value: 'tr_TR', child: Text('Türkçe')),
        DropdownMenuItem(value: 'en_US', child: Text('English')),
      ],
    );
  }

  Widget _selectTheme(ModelTheme themeNotifier) {
    return SwitchListTile(
      secondary: themeNotifier.isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode_outlined),
      title: Text(LocaleConstants.theme.tr()), 
      value: themeNotifier.isDark,
      activeColor: CustomColors.scaffoldBackgroundColorDark,
      thumbColor: const MaterialStatePropertyAll(CustomColors.buttonColor),
      onChanged: (value) => themeNotifier.isDark = value        
    );
  }
}
