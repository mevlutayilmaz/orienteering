import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/game/base_game_model.dart';
import '../../../model/game/outdoor_game_model.dart';
import '../../../services/game/outdoor_game_services.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/validators/custom_validators.dart';
import '../../../widgets/custom_profile_text_field.dart';

class CreateOutdoorGameScreen extends StatefulWidget {
  final BaseGameModel? baseGameModel;
  const CreateOutdoorGameScreen({super.key, required this.baseGameModel});

  @override
  State<CreateOutdoorGameScreen> createState() => _CreateOutdoorGameScreenState();
}

class _CreateOutdoorGameScreenState extends State<CreateOutdoorGameScreen> {
  final List<Widget> _rows = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _latitudeControllers = [];
  final List<TextEditingController> _longitudeControllers = [];
  final List<TextEditingController> _markerInfoControllers = [];

  @override
  void dispose() {
    _disposeControllers(_latitudeControllers);
    _disposeControllers(_longitudeControllers);
    _disposeControllers(_markerInfoControllers);
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
          TextEditingController tLatitude = TextEditingController();
          TextEditingController tLongitude = TextEditingController();
          TextEditingController tMarkerInfo = TextEditingController();
          _latitudeControllers.add(tLatitude);
          _longitudeControllers.add(tLongitude);
          _markerInfoControllers.add(tMarkerInfo);
          _rows.add(_buildRow(tLatitude, tLongitude, tMarkerInfo));
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
            _latitudeControllers.removeLast();
            _longitudeControllers.removeLast();
            _markerInfoControllers.removeLast();
            _rows.removeLast();
          }
        });
      },
      icon: const Icon(Icons.remove, color: Colors.white),
      label: Text(LocaleConstants.marker.tr(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
    );
  }

  Widget _buildRow(TextEditingController tLatitude, TextEditingController tLongitude, TextEditingController tMarkerInfo) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomProfileTextField(controller: tLatitude,text: LocaleConstants.latitude.tr().substring(0, 3),iconData: Icons.location_on,inputType: TextInputType.number,validator: (value) => CustomValidators.geopointValidator(value)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomProfileTextField(controller: tLongitude,text: LocaleConstants.longitude.tr().substring(0, 3),iconData: Icons.location_on,inputType: TextInputType.number,validator: (value) => CustomValidators.geopointValidator(value)),
            ),
          ],
        ),
        CustomProfileTextField(controller: tMarkerInfo, text: LocaleConstants.markerInfo.tr(), iconData: Icons.info_outline_rounded, validator: (value) => CustomValidators.nameValidator(value)),   
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
                ? OutdoorGameServices().create(context, gameMethod()) 
                : null;
      },
      style: const ButtonStyle().copyWith(fixedSize: const MaterialStatePropertyAll(Size(double.maxFinite, 45))),
      child: Text(LocaleConstants.createGame.tr()),
    );
  }

  OutdoorGameModel gameMethod() {
    List<GeoPoint> geoPoints = [];
    List<String> markerInfo = [];
    for(int i = 0; i < _latitudeControllers.length; i++){
      geoPoints.add(GeoPoint(double.parse(_latitudeControllers[i].text), double.parse(_longitudeControllers[i].text)));
      markerInfo.add(_markerInfoControllers[i].text);
    }
    OutdoorGameModel model = OutdoorGameModel(
      description: widget.baseGameModel?.description,
      location: widget.baseGameModel?.location,
      title: widget.baseGameModel?.title,
      organizerName: widget.baseGameModel?.organizerName,
      markers: geoPoints,
      markerInfo: markerInfo
    );
    return model;
  }
  
}
