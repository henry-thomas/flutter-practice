import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

 class AddLoggerView {
 static void addLoggerDialog(context, setState) {
    _showMyDialog(context, setState);
  }

  static String _scanBarcode = '';

  static Future<void> scanQR(context, setState) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.

    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);

    goToUrl(barcodeScanRes);

    _scanBarcode = barcodeScanRes;

  }

  static goToUrl(url) {
    print(url);
    launch(url);
  }

 static Future<void> _showMyDialog(context, setState) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFF2CC0D).withOpacity(0.9),
          title: Text('Add LoggerV2'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.asset(
                  'assets/images/scanLogger.png',
                  width: 70,
                  height: 140,
                  fit: BoxFit.fitHeight,
                ),
                Text('Scan the barcode located on your LoggerV2'),


                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Scan'),
              onPressed: () {

                scanQR(context, setState);
                // Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('✖️'),
              onPressed: () {

                // scanQR(context, setState);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
