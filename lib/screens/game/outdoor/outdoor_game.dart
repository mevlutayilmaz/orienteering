import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../model/game/outdoor_game_model.dart';
import '../../../model/statistic/statistic_model.dart';
import '../../../model/user/user_model.dart';
import '../../../services/statistic/statistic_services.dart';
import '../../../services/user/auth_services.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/custom_log_out_dialog.dart';

class OutdoorGameScreen extends StatefulWidget {
  final OutdoorGameModel gameModel;
  const OutdoorGameScreen({super.key, required this.gameModel});

  @override
  State<OutdoorGameScreen> createState() => _OutdoorGameScreenState();
}

class _OutdoorGameScreenState extends State<OutdoorGameScreen> {
  late StreamSubscription<Position> _positionStreamSubscription;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late final List<GeoPoint> _markerList;
  late final List<String> _markerInfoList;
  final List<String> _markerNameList = [];
  final Set<Marker> _markers = {};
  late final Polyline _polyline;
  late OutdoorGameModel game;
  final double _distanceThreshold = 10;
  final LocationSettings _locationSettings = const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
  late Timer _timer;
  int _elapsedSeconds = 0;
  int _numberOfFlagsCollected = 0;
  String _task = LocaleConstants.gotoMarker.tr(args: ["${LocaleConstants.flag.tr()} 1"]);
  bool _returnToFlag = true;

  @override
  void initState() {
    game = widget.gameModel;
    _markerList = game.markers!;
    _markerInfoList = game.markerInfo!;
    for (var i = 1; i <= game.markers!.length; i++) {
      _markerNameList.add("${LocaleConstants.flag.tr()} $i");
    }
    super.initState();
    for (int i = 0; i < _markerList.length; i++){
      _addMarkers(i);
    }
    _createPolylineFromMarkers();
    _checkUserLocation();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _positionStreamSubscription.cancel();
    _controller.future.then((controller) => controller.dispose());
    super.dispose();
  }

  String _formatDuration(int elapsedSeconds) {
    Duration duration = Duration(seconds: elapsedSeconds);
    String hours = (duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 40,
      title: Text(_task, style: Theme.of(context).textTheme.bodyLarge),
      leading: IconButton(onPressed: () => logOutDialog(context, () => Navigator.pop(context)), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      actions: [
        Text(_formatDuration(_elapsedSeconds), style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(width: 10)
      ],
    );
  }

  GoogleMap _buildBody() {
    return GoogleMap(
      mapType: MapType.hybrid,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(target: LatLng(_markerList.first.latitude, _markerList.first.longitude), zoom: 14),
      markers: _markers,
      polylines: {_polyline},
      onMapCreated: (GoogleMapController controller) => _controller.complete(controller),
    );
  }

  void _addMarkers(int index) {
    GeoPoint marker = _markerList[index];
    if (game.markers != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('_kGoogleMarker$index'),
          infoWindow: InfoWindow(
              title: _markerNameList[index], snippet: _markerInfoList[index]),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(marker.latitude, marker.longitude),
        ),
      );
    }
  }

  void _createPolylineFromMarkers() {
    List<LatLng> points = [];

    for (var geoPoint in _markerList) {
      points.add(LatLng(geoPoint.latitude, geoPoint.longitude));
    }

    _polyline = Polyline(
      polylineId: const PolylineId('_kPolyline'),
      points: points,
      width: 3,
    );
  }

  void _checkUserLocation() async {
    _positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: _locationSettings)
            .listen((Position userPosition) {
      if (_markers.isNotEmpty) {
        bool isWithinRadius = false;
        double distanceInMeters = Geolocator.distanceBetween(
          userPosition.latitude,
          userPosition.longitude,
          _markerList[_numberOfFlagsCollected].latitude,
          _markerList[_numberOfFlagsCollected].longitude,
        );

        isWithinRadius = distanceInMeters <= _distanceThreshold;
        if (isWithinRadius) {
          _positionStreamSubscription.pause();
          _buildDialog();
        }
      } else {
        _positionStreamSubscription.cancel();
      }
    });
  }

  void _buildDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      btnOkText: LocaleConstants.ok.tr(),
      btnCancelText: LocaleConstants.cancel.tr(),
      title: LocaleConstants.success.tr(),
      desc: LocaleConstants.reachedMarker.tr(args: [_markerNameList[_numberOfFlagsCollected]]),
      btnOkOnPress: () {
        setState(() {
          _polyline.points.remove(_polyline.points.first);
          _markers.remove(_markers.first);
          _numberOfFlagsCollected++;
          _markers.isNotEmpty
              ? _task = LocaleConstants.gotoMarker.tr(args: [_markerNameList[_numberOfFlagsCollected]])
              : {
                if(_markers.isEmpty && _returnToFlag){
                  _numberOfFlagsCollected = 0,
                  _addMarkers(0),
                  _polyline.points.add(LatLng(_markerList[0].latitude, _markerList[0].longitude)),
                  _returnToFlag = false,
                  _task = LocaleConstants.returnToFlag.tr()
                }else{
                  _createStatistic()
                }
              };
        });
        _positionStreamSubscription.resume();
      },
    ).show();
  }

  Future<void> _createStatistic() async {
    final auth = FirebaseAuth.instance;
    DateTime now = DateTime.now();
    String date = '${now.day}/${now.month}/${now.year}';
    UserModel? user = await AuthService().getUserByEmail(auth.currentUser!.email.toString());
    StatisticModel model = StatisticModel(userName: user?.name, elapsedTime: _formatDuration(_elapsedSeconds), gameTitle: game.title, gameType: 'Outdoor', date: date);
    StatisticServices().createStatistic(context, model);
  }
}
