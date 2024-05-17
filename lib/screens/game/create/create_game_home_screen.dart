import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../../model/game/base_game_model.dart';
import '../../../router/routes.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/colors/custom_colors.dart';
import '../../../utils/validators/custom_validators.dart';
import '../../../widgets/custom_profile_text_field.dart';

class CreateGameHomeScreen extends StatefulWidget {
  final String? organizerName;
  const CreateGameHomeScreen({super.key, required this.organizerName});

  @override
  State<CreateGameHomeScreen> createState() => _CreateGameHomeScreenState();
}

class _CreateGameHomeScreenState extends State<CreateGameHomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final _tTittle = TextEditingController();
  late final _tDescription = TextEditingController();
  String _selectedOption = LocaleConstants.indoor.tr();
  List<String> _cities = [];
  String _selectedCity = 'Kocaeli';

  @override
  void initState() {
    _loadCities();
    super.initState();
  }

  @override
  void dispose() {
    _tTittle.dispose();
    _tDescription.dispose();
    super.dispose();
  }

  Future<void> _loadCities() async {
    String jsonString = await rootBundle.loadString('lib/assets/cities/cities.json');
    List<dynamic> jsonList = json.decode(jsonString);
    _cities = jsonList.cast<String>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(LocaleConstants.createGame.tr()),
      leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildRadioButton(),
              _selectLocation(),
              CustomProfileTextField(controller: _tTittle, text: LocaleConstants.title.tr(), iconData: Icons.title, validator: (value) => CustomValidators.nameValidator(value)),
              CustomProfileTextField(controller: _tDescription, text: LocaleConstants.description.tr(), iconData: Icons.description_outlined, validator: (value) => CustomValidators.nameValidator(value), maxLines: true,),
              const SizedBox(height: 10),
              _continueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _gameTypeRadio(LocaleConstants.indoor.tr()),
        Text(LocaleConstants.indoor.tr()),
        const SizedBox(width: 20),
        _gameTypeRadio(LocaleConstants.outdoor.tr()),
        Text(LocaleConstants.outdoor.tr()),
      ],
    );
  }

  Radio<String> _gameTypeRadio(String text) {
    return Radio(
      value: text,
      activeColor: CustomColors.buttonColor,
      groupValue: _selectedOption,
      onChanged: (value) => setState(() => _selectedOption = value!),
    );
  }

  Widget _selectLocation() {
    return DropdownButtonFormField(
      padding: const EdgeInsets.symmetric(vertical: 5),
      onChanged: (value) => setState(() => _selectedCity = value!),
      value: _selectedCity,
      items: _cities.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city),
        );
      }).toList(),
    );
  }

  Widget _continueButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => _formKey.currentState!.validate()
            ? Navigator.of(context).pushNamed(
                _selectedOption == LocaleConstants.indoor.tr()
                    ? Routes.createIndoorGame
                    : Routes.createOutdoorGame,
                arguments: BaseGameModel(description: _tDescription.text, title: _tTittle.text, organizerName: widget.organizerName, location: _selectedCity))
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleConstants.textContinue.tr()),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
