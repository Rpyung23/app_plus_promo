import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plus_promo/util/textos.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/cupon_lista/data_cupon_lista.dart';
import '../util/color.dart';
import '../util/dimensiones.dart';

class QrCuponPage extends StatefulWidget {
  DatoCuponLista? oDatoCuponLista;
  QrCuponPage({required this.oDatoCuponLista});

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
    return widget.oDatoCuponLista == null
        ? Text(
            "CODIGO ERRONEO / VACIO",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: color_secondary),
          )
        : QrImageView(
            data: widget.oDatoCuponLista!.codeCupon!.toString(),
            backgroundColor: color_secondary,
            version: QrVersions.auto);
  }
}
