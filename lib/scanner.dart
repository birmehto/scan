import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Scanner'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
            returnImage: true, detectionSpeed: DetectionSpeed.noDuplicates),
        onDetect: (capture) {
          final List<Barcode> bardcodes = capture.barcodes;
          final Uint8List? images = capture.image;
          for (final barcode in bardcodes) {
            print('barcode value :${barcode.rawValue}');
          }
          if (images != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(bardcodes.first.rawValue ?? ''),
                  content: Image.memory(images),
                );
              },
            );
          }
        },
      ),
    );
  }
}
