import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatelessWidget {
  final String qrData;

  const GenerateQr({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 300,
      padding: const EdgeInsets.all(50),
      embeddedImage: AssetImage('images/ac_logo.png'),
    );
  }
}
