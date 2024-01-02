import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../util/color.dart';
import '../util/dimensiones.dart';
import '../util/textos.dart';

class CuponesListPage extends StatefulWidget {
  const CuponesListPage({super.key});

  @override
  State<CuponesListPage> createState() => _CuponesListPageState();
}

class _CuponesListPageState extends State<CuponesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: color_primary,
        title: Text(
          title_toolbar_cupon_lista,
          style: TextStyle(color: color_secondary),
        ),
      ),
      body: _getBodyCuponesListaPage(),
    );
  }

  _getBodyCuponesListaPage() {
    return Container(
      child: ListView(
        children: [
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem(),
          _getItem()
        ],
      ),
    );
  }

  _getItem() {
    return ListTile(
      leading: Image.asset("./assets/cupon.png"),
      title: Text(
        title_card_cupon,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: color_accent,
            fontSize: textBigMedium),
      ),
      subtitle: Text(
        subtitle_card_cupon,
        style: TextStyle(
            fontWeight: FontWeight.w300,
            color: color_accent,
            fontSize: textMediumSmall),
      ),
      onTap: () {
        Navigator.of(context).pushNamed("/qr_cupon_page");
      },
    );
  }
}
