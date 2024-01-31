import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:plus_promo/model/CuponQr_model.dart';
import 'package:plus_promo/util/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../model/response_model.dart';
import '../provider/ProviderCupon.dart';

class ScannerQR extends StatefulWidget {
  ResponseModel? oR;
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
        body: Expanded(
          child: Container(
              child: widget.oR == null
                  ? _getQR()
                  : widget.oR!.statusCode == 200
                      ? _CuponOK()
                      : _getQR()),
        ));
  }

  _onQRViewCreated(QRViewController controller) {
    widget.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("CODE : " + scanData.code!);
      widget.controller!.stopCamera();
      _consumirCupon(CuponQrModel.fromRawJson(scanData.code!));
    });
  }

  /*_onQRViewCreated(QRViewController p1) {
    setState(() {
      widget.controller = p1;
    });
    widget.controller!.scannedDataStream.listen((Barcode scanData) {
      print("CODE CUPON : " + scanData.code!);
      /*if (scanData.code != null) {
        _consumirCupon(scanData.code!);
      }*/
    });
  }*/

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

  _consumirCupon(CuponQrModel oCuponQrModel) async {
    widget.oR = await ProviderCreateCupon.consumirCuponClient(
        oCuponQrModel.user, oCuponQrModel.cupon!);

    if (widget.oR!.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "CUPON CONSUMIDO CON EXITO",
          backgroundColor: color_success,
          textColor: color_secondary,
          gravity: ToastGravity.BOTTOM);
      //Navigator.of(context).pop();
      _reproducirSonido();
    } else {
      Fluttertoast.showToast(
          msg: widget.oR!.msm!,
          backgroundColor: color_danger,
          textColor: color_secondary,
          gravity: ToastGravity.BOTTOM);
      widget.controller!.resumeCamera();
    }
    setState(() {});
  }

  _getQR() {
    return QRView(
        key: widget.qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: color_primary,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10));
  }

  _CuponOK() {
    return Center(
      child: Lottie.asset('./assets/check.json'),
    );
  }

  _reproducirSonido() async {
    try {
      AssetsAudioPlayer.newPlayer().open(Audio("./assets/moneda.mp3"),
          autoStart: true, showNotification: true, volume: 100.0);
    } catch (e) {
      print(e.toString());
    }
  }
}
