import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/game/indoor_game_model.dart';
import '../../../model/game/outdoor_game_model.dart';
import '../../../model/user/user_model.dart';
import '../../../router/routes.dart';
import '../../../services/game/indoor_game_services.dart';
import '../../../services/game/outdoor_game_services.dart';
import '../../../utils/constants/constants.dart';


class MyGamesScreen extends StatefulWidget {
  final UserModel user;
  const MyGamesScreen({super.key, required this.user});

  @override
  State<MyGamesScreen> createState() => _MyGamesScreenState();
}

class _MyGamesScreenState extends State<MyGamesScreen> {
  final List<dynamic> _gameList = [];
  late NavigatorState _navigator;
  late PermissionStatus _locationPermission;
  late bool _locationEnabled;

  @override
  void initState() {
    _init();
    super.initState();
    _navigator =  Navigator.of(context);
  }

  Future<void> _init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<IndoorGameModel> indoorGameList = await IndoorGameServices().getByOrganizerName(widget.user.name!);
      List<OutdoorGameModel> outdoorGameList = await OutdoorGameServices().getByOrganizerName(widget.user.name!);
      _gameList.addAll(indoorGameList);
      _gameList.addAll(outdoorGameList);
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(LocaleConstants.myGames.tr()),
      leading: IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    return _gameList.isEmpty ? Center(child: Text(LocaleConstants.noGameYouCreated.tr())) : ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: _gameList.length,
      itemBuilder: (context, index) => _buildListTile(_gameList[index]),
    );
  }

  Widget _buildListTile(var game) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(game.title!, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Row(children: [
        Text(game.location),
        Text(game.runtimeType == IndoorGameModel ? ' - Indoor' : ' - Outdoor'),
      ]),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),      
      onTap: () => _buildDialog(game),
    );
  }

  void _buildDialog(var game) async {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      headerAnimationLoop: false,
      dismissOnTouchOutside: false,
      dialogType: DialogType.question,
      showCloseIcon: false,
      title: LocaleConstants.gameBegins.tr(),
      desc: LocaleConstants.enterTheGame.tr(),
      btnOkText: LocaleConstants.ok.tr(),
      btnCancelText: LocaleConstants.cancel.tr(),
      btnOkOnPress: () async {
        _locationPermission = await Permission.locationWhenInUse.request();
        _locationEnabled = await Geolocator.isLocationServiceEnabled();
        _locationPermission.isGranted
            ? _locationEnabled
                ? _navigator.pushNamed(game.runtimeType == IndoorGameModel ?  Routes.indoorGame : Routes.outdoorGame, arguments: game)
                : Geolocator.openLocationSettings()
            : Geolocator.openAppSettings();
      },
      btnCancelOnPress: () {},
    ).show();
  }
}
