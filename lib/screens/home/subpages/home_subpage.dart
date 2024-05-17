import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../../model/game/indoor_game_model.dart';
import '../../../model/game/outdoor_game_model.dart';
import '../../../router/routes.dart';
import '../../../services/game/indoor_game_services.dart';
import '../../../services/game/outdoor_game_services.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/custom_circular.dart';

class HomeSubpage extends StatefulWidget {
  const HomeSubpage({super.key});
  

  @override
  State<HomeSubpage> createState() => _HomeSubpageState();
}

class _HomeSubpageState extends State<HomeSubpage> {
  final _controller = TextEditingController();
  final List<dynamic> _gameList = [];
  List<String> _cities = [];
  List<IndoorGameModel> _indoorGameList = [];
  List<OutdoorGameModel> _outdoorGameList = [];
  List<dynamic> _searchList = [];
  late NavigatorState _navigator;
  late PermissionStatus _locationPermission;
  late bool _locationEnabled;
  String _selectedCity = 'Kocaeli';

  @override
  void initState() {
    _init();
    _loadCities();
    super.initState();
    _navigator =  Navigator.of(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadCities() async {
    String jsonString = await rootBundle.loadString('lib/assets/cities/cities.json');
    List<dynamic> jsonList = json.decode(jsonString);
    _cities = jsonList.cast<String>();
    setState(() {});
  }

  Future<void> _init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _indoorGameList = await IndoorGameServices().getAllGame();
      _outdoorGameList = await OutdoorGameServices().getAllGame();
      _gameList.addAll(_indoorGameList);
      _gameList.addAll(_outdoorGameList);
      setState(() {});
    });
  }

  void _searchGame(String query) {
    late final List<dynamic> suggestions;
    if (query.isNotEmpty) {
      suggestions = _gameList.where((model) {
        final gameTittle = model.title!.toLowerCase();
        final input = query.toLowerCase();
        return gameTittle.contains(input);
      }).toList();
    } else {
      suggestions = [];
    }
    setState(() => _searchList = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    return _gameList.isEmpty
        ? customCircular
        : _buildBody();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildRow(),
          _controller.text.isEmpty
              ? Container()
              : _buildListViewSearch(),
          _selectLocation(),
          _buildTextTittle(LocaleConstants.outdoorGames.tr()),
          _buildListViewGame(_outdoorGameList),
          _buildTextTittle(LocaleConstants.indoorGames.tr()),
          _buildListViewGame(_indoorGameList),
        ],
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: TextField(
            controller: _controller,
            onChanged: _searchGame,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  _searchList.clear();
                  _controller.clear();
                }),
                icon: const Icon(Icons.cancel_outlined)
              ),
              hintText: LocaleConstants.search.tr(),
            ),
          ),
        ),
        Expanded(flex: 1, child: IconButton(onPressed: () => Navigator.of(context).pushNamed(Routes.aboutOrienteering), icon: const Icon(Icons.info))),
      ],
    );
  }

  Widget _selectLocation() {
    return Align(
      alignment: Alignment.centerLeft,
      child: DropdownButton(
        onChanged: (value) => setState(() {
          _selectedCity = value!;
        }),
        value: _selectedCity,
        
        items: _cities.map((String city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Text(city),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListViewSearch() {
    return SizedBox(
      height: double.maxFinite,
      child: ListView.builder(
        itemCount: _searchList.length,
        itemBuilder: (context, index) => _searchListTile(_searchList[index]),
      ),
    );
  }

  Widget _searchListTile(var searchList) {
    return ListTile(
      title: Text(searchList.title!, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Row(children: [
        Text(searchList.location),
        Text(searchList.runtimeType == IndoorGameModel ? ' - Indoor' : ' - Outdoor'),
      ]),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),      
      onTap: () => _buildDialog(searchList),
    );
  }

  Widget _buildTextTittle(String gameTitle) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(gameTitle, style: Theme.of(context).textTheme.headlineMedium),
      )
    );
  }

  Widget _buildListViewGame(List<dynamic> gameList) {
    List<dynamic> games = gameList.where((game) => game.location == _selectedCity).toList();
    return SizedBox(
      height: 300,
      child: games.isEmpty ? Center(child: Text(LocaleConstants.noGameInLoc.tr())) : ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: games.length,
        itemBuilder: (context, index) => _cardWidget(games[index]),
      ),
    );
  }

  Widget _cardWidget(var game) {
    return GestureDetector(
      onTap: () => _buildDialog(game),
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(image: AssetImage("lib/assets/images/route-image.jpeg"))),
            const SizedBox(height: 5),
            Text(
              game.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(game.organizerName!),
            const Divider(),
            Text(game.description!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
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
        if(game.runtimeType == OutdoorGameModel){
          _locationPermission = await Permission.locationWhenInUse.request();
          _locationEnabled = await Geolocator.isLocationServiceEnabled();
          _locationPermission.isGranted
              ? _locationEnabled
                  ? _navigator.pushNamed(Routes.outdoorGame, arguments: game)
                  : Geolocator.openLocationSettings()
              : Geolocator.openAppSettings();
        }else{
          _navigator.pushNamed(Routes.indoorGame, arguments: game);
        }
      },
      btnCancelOnPress: () {},
    ).show();
  }

}
