import 'package:first_flutter_demo_app/common_widget/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';

import '../../router/route_const.dart';


class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TopWidget(title: 'Scan QRCode', child: MobileScanner(onDetect: (capture) {
      final List<Barcode> barcodes = capture.barcodes;
      for (final barcode in barcodes) {
      print(barcode.rawValue ?? "No Data found in QR");
      context.pop(barcode.rawValue??"");
      break;
      }
    },));
  }
}
