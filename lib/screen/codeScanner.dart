import 'package:flutter_qr_scanner/qr_scanner_camera.dart';
import 'package:flutter/material.dart';

class ScanerCode extends StatefulWidget {
  ScanerCode({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ScanerCodeState createState() => _ScanerCodeState();
}

class _ScanerCodeState extends State<ScanerCode> {
  String _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _qrCallback(String code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
      Navigator.of(context).pop(code);
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _camState
          ? Center(
              child: SizedBox(
                height: 500,
                width: 500,
                child: QRScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                   _qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Text(_qrInfo),
            ),
    );
  }
}