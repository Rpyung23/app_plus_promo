import 'package:flutter/material.dart';
import 'package:plus_promo/util/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerQR extends StatefulWidget {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  ScannerQR({super.key});
  @override
  State<ScannerQR> createState() => _ScannerQRState();
}

class _ScannerQRState extends State<ScannerQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_primary,
        foregroundColor: color_secondary,
        title: Text("SCANNER QR"),
      ),
      body: QRView(
        key: widget.qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: color_primary,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  _onQRViewCreated(QRViewController p1) {
    setState(() {
      widget.controller = p1;
    });
    widget.controller!.scannedDataStream.listen((scanData) {
      setState(() {
        //result = scanData;
      });
    });
  }

  _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    //log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }
}
