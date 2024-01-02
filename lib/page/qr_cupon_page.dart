import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plus_promo/util/textos.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../util/color.dart';
import '../util/dimensiones.dart';

class QrCuponPage extends StatefulWidget {
  const QrCuponPage({super.key});

  @override
  State<QrCuponPage> createState() => _QrCuponPageState();
}

class _QrCuponPageState extends State<QrCuponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title_toolbar_qr),
      ),
      body: SizedBox.expand(
        child: Container(
          padding:
              EdgeInsets.only(right: marginSmallSmall, left: marginSmallSmall),
          color: color_black,
          alignment: Alignment.center,
          child: Center(
            child: _getQR(),
          ),
        ),
      ),
    );
  }

  _getQR() {
    return QrImageView(
        data: '1234567890',
        backgroundColor: color_secondary,
        version: QrVersions.auto);
  }
}
