import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../model/game/indoor_game_model.dart';
import '../../../model/statistic/statistic_model.dart';
import '../../../model/user/user_model.dart';
import '../../../services/statistic/statistic_services.dart';
import '../../../services/user/auth_services.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/custom_log_out_dialog.dart';

class IndoorGameScreen extends StatefulWidget {
  final IndoorGameModel gameModel;
  const IndoorGameScreen({super.key, required this.gameModel});

  @override
  State<IndoorGameScreen> createState() => _IndoorGameScreenState();
}

class _IndoorGameScreenState extends State<IndoorGameScreen> {
  late String _targetInformation;
  late IndoorGameModel game;
  late Timer _timer;
  int _elapsedSeconds = 0;
  int _numberOfFlagsCollected = 0;
  final List<String> _markerNameList = [];
  String _task = LocaleConstants.gotoMarker.tr(args: ['${LocaleConstants.flag.tr()} 1']);
  bool _gameOver = false;

  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;

  @override
  void initState() {
    game = widget.gameModel;
    _targetInformation = game.informations![_numberOfFlagsCollected];
    for (var i = 1; i <= game.qrList!.length; i++) {
      _markerNameList.add("${LocaleConstants.flag.tr()} $i");
    }
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.pauseCamera();
    } else if (Platform.isIOS) {
      _controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _result = scanData;
        if(_result!.code == game.qrList![_numberOfFlagsCollected]){
          _pauseScanner();
          _buildDialog();
        }else{
          _pauseScanner();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleConstants.wrongFlag.tr()),
              duration: const Duration(seconds: 1),
            ),
          );
          _resumeScanner();
        }
      });
    });
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

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(flex: 1, child: Text(_targetInformation)),
          Expanded(
            flex: 1,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
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
          if(_gameOver){
            _createStatistic();
          }else{
            _numberOfFlagsCollected++;
            if(_numberOfFlagsCollected < game.qrList!.length) {
              _targetInformation = game.informations![_numberOfFlagsCollected];
              _task = LocaleConstants.reachedMarker.tr(args: [_markerNameList[_numberOfFlagsCollected]]);
            }else {
              _numberOfFlagsCollected = 0;
              _targetInformation = game.informations![_numberOfFlagsCollected];
              _task = LocaleConstants.returnToFlag.tr();
              _gameOver = true;
            }
          }          
        });
        _resumeScanner();
      },
    ).show();
  }


  Future<void> _createStatistic() async {
    final auth = FirebaseAuth.instance;
    DateTime now = DateTime.now();
    String date = '${now.day}/${now.month}/${now.year}';
    UserModel? user = await AuthService().getUserByEmail(auth.currentUser!.email.toString());
    StatisticModel model = StatisticModel(userName: user?.name, elapsedTime: _formatDuration(_elapsedSeconds), gameTitle: game.title, gameType: LocaleConstants.indoor.tr(), date: date);
    StatisticServices().createStatistic(context, model);
  }

  void _pauseScanner() {
    if (_controller != null) {
      _controller!.pauseCamera();
    }
  }

  void _resumeScanner() {
    if (_controller != null) {
      _controller!.resumeCamera();
    }
  }
}
