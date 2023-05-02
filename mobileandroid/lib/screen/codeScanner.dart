//import 'package:flutter_qr_scanner/qr_scanner_camera.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:flutter/material.dart';

class ScanerCode extends StatefulWidget {
  ScanerCode({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ScanerCodeState createState() => _ScanerCodeState();
}

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";

class _ScanerCodeState extends State<ScanerCode> {
  var qrText = "";
  var flashState = flash_on;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  overlayColor: Color.fromRGBO(0, 0, 0, 0.9),
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 2,
                  cutOutSize: 300,
                ),
              ),
              flex: 2,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 40,
                width: 60,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _isFlashOn(String current) {
    return flash_on == current;
  }

  void _onQRViewCreated(QRViewController controller) async {
    String hasil;
    this.controller = controller;
    await controller.scannedDataStream.listen((scanData) async {
      if (scanData.length > 30) {
        List scan = scanData.split("\n");
        List result = scan[2].split(":");
        hasil = result[1];
      } else {
        hasil = scanData;
      }
      setState(() {
        qrText = hasil;
      });
      //await controller.dispose();]
      controller.dispose();
      Navigator.of(context).pop(hasil);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
