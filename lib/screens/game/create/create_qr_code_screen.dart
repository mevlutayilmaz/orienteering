import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../utils/constants/constants.dart';

class CreateQRCodeScreen extends StatefulWidget {
  final String data;
  const CreateQRCodeScreen({super.key, required this.data});

  @override
  State<CreateQRCodeScreen> createState() => _CreateQRCodeScreenState();
}

class _CreateQRCodeScreenState extends State<CreateQRCodeScreen> {
  final ScreenshotController _screenShootController = ScreenshotController();


  Future<void> _saveImage(Uint8List image) async {
    NavigatorState navigator = Navigator.of(context);
    await [Permission.storage].request();
    await ImageGallerySaver.saveImage(image, name: widget.data);
    navigator.pop();
  }

  _screenShoot() async {
    final image = await _screenShootController.capture();
    if (image != null) {
      await _saveImage(image);
    }
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
      title: Text(LocaleConstants.createQr.tr()),
      leading: IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildQrImage(),
            const SizedBox(height: 20),
            ElevatedButton.icon(onPressed: () async => await _screenShoot(), icon: const Icon(Icons.download), label: Text(LocaleConstants.download.tr()))
          ],
        ),
      ),
    );
  }

  Screenshot _buildQrImage() {
    return Screenshot(
      controller: _screenShootController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImageView(
            backgroundColor: Colors.white,
            data: widget.data,
            version: QrVersions.auto,
            size: 400.0,
          ),
          Text(widget.data)
        ],
      ),
    );
  }

}
