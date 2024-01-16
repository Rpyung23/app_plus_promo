import 'package:flutter/material.dart';
import 'package:plus_promo/page/session_page.dart';
import 'package:plus_promo/util/dimensiones.dart';

import '../util/color.dart';
import '../util/textos.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        _getBackground(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(marginSmallSmall),
            child: Card(
              color: color_secondary,
              surfaceTintColor: color_secondary,
              child: Container(
                child: _ItemTypeUser(),
                padding: EdgeInsets.all(marginSmall),
              ),
            ),
          ),
        )
      ],
    ));
  }

  _getBackground() {
    return Container(
        decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("./assets/background_img.jpg"),
        fit: BoxFit.fill,
      ),
    ));
  }

  _ItemTypeUser() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SessionPage(type_use: 'u')));
          },
          child: Text(txt_cliente,
              style: TextStyle(color: color_secondary, fontSize: textMedium)),
          style: ElevatedButton.styleFrom(
              backgroundColor: color_primary,
              minimumSize: Size(double.infinity, altoMedium)),
        ),
        SizedBox(
          height: marginSmall,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SessionPage(type_use: 'v')));
            },
            child: Text(
              txt_vender,
              style: TextStyle(color: color_secondary, fontSize: textMedium),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: color_info,
                minimumSize: Size(double.infinity, altoMedium)))
      ],
    );
  }
}
