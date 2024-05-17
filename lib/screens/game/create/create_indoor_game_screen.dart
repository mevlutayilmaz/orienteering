import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/game/base_game_model.dart';
import '../../../model/game/indoor_game_model.dart';
import '../../../router/routes.dart';
import '../../../services/game/indoor_game_services.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/validators/custom_validators.dart';
import '../../../widgets/custom_profile_text_field.dart';

class CreateIndoorGameScreen extends StatefulWidget {
  final BaseGameModel? baseGameModel;
  const CreateIndoorGameScreen({super.key, required this.baseGameModel});

  @override
  State<CreateIndoorGameScreen> createState() => _CreateIndoorGameScreenState();
}

class _CreateIndoorGameScreenState extends State<CreateIndoorGameScreen> {
  final List<Widget> _rows = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _informationsControllers = [];
  final List<String> _qrList = [];

  @override
  void dispose() {
    _disposeControllers(_informationsControllers);
    super.dispose();
  }

  void _disposeControllers(List<TextEditingController> controllers) {
    if (controllers.isNotEmpty) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
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
      leading: IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
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
              Column(children: _rows),
              _buildMarkerButtons(),
              const SizedBox(height: 10),
              _createGameButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addMarkerButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
      onPressed: () {
        setState(() {
          String data = '${widget.baseGameModel!.title!} - Bayrak ${_qrList.length+1}';
          TextEditingController tInformation = TextEditingController();
          _qrList.add(data);
          _informationsControllers.add(tInformation);
          _rows.add(_buildRow(tInformation, data));
        });
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(LocaleConstants.marker.tr(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
    );
  }

  Widget _removeMarkerButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
      onPressed: () {
        setState(() {
          if (_rows.isNotEmpty) {
            _informationsControllers.removeLast();
            _qrList.removeLast();
            _rows.removeLast();
          }
        });
      },
      icon: const Icon(Icons.remove, color: Colors.white),
      label: Text(LocaleConstants.marker.tr(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
    );
  }

  Widget _buildRow(TextEditingController tInformation, String data) {
    return Column(
      children: [
        CustomProfileTextField(controller: tInformation, text: LocaleConstants.information.tr(), iconData: Icons.info_outline_rounded, validator: (value) => CustomValidators.nameValidator(value), maxLines: true),   
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(onPressed: () => Navigator.of(context).pushNamed(Routes.createQRCode, arguments: data), icon: const Icon(Icons.qr_code_2), label: Text(LocaleConstants.createQr.tr())),
            Text(data.split(' - ').last)
          ],
        ),
        const Divider(thickness: 0.4),
      ],
    );
  }

  Widget _buildMarkerButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _removeMarkerButton(),
        const SizedBox(width: 10),
        _addMarkerButton(),
      ],
    );
  }

  Widget _createGameButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        (_rows.length < 2)
            ? Fluttertoast.showToast(msg: LocaleConstants.markersMustBeEnter.tr(), toastLength: Toast.LENGTH_LONG)
            : _formKey.currentState!.validate() 
                ? IndoorGameServices().create(context, _gameMethod()) 
                : null;
      },
      style: const ButtonStyle().copyWith(fixedSize: const MaterialStatePropertyAll(Size(double.maxFinite, 45))),
      child: Text(LocaleConstants.createGame.tr()),
    );
  }

  IndoorGameModel _gameMethod() {
    List<String> informations = [];

    for(int i = 0; i < _informationsControllers.length; i++){
      informations.add(_informationsControllers[i].text);
    }

    IndoorGameModel model = IndoorGameModel(
      description: widget.baseGameModel?.description,
      location: widget.baseGameModel?.location,
      title: widget.baseGameModel?.title,
      organizerName: widget.baseGameModel?.organizerName,
      informations: informations,
      qrList: _qrList
    );
    return model;
  }
  
}
