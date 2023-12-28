import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/textos.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
        child: Scaffold(
      body: _getBody(context),
    ));
  }

  Widget _getBody(context) {
    return Container(
      margin: EdgeInsets.all(marginSmall),
      child: ListView(
        children: [
          Image.asset(
            './assets/logo.png',
          ),
          TextField(
            style: TextStyle(fontSize: textMedium),
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: hint_email),
          ),
          SizedBox(
            height: marginSmallSmall,
          ),
          TextField(
            style: TextStyle(fontSize: textMedium),
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: hint_pass),
          ),
          SizedBox(
            height: marginMedium,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/home_page");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: color_primary,
                  minimumSize: Size.fromHeight(altoMedium)),
              child: Text(
                txt_siguiente,
                style: TextStyle(
                    fontSize: textMedium,
                    color: color_secondary,
                    fontWeight: FontWeight.w700),
              )),
          SizedBox(
            height: altoSmallSmall,
          ),
          _getTextRegistro(context)
        ],
      ),
    );
  }

  Widget _getTextRegistro(context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(text: txt_miembro, style: TextStyle(color: color_accent)),
          TextSpan(
              text: txt_registro,
              recognizer: TapGestureRecognizer()..onTap = () {
                Navigator.of(context).pushNamed("/carrusel_page");
              },
              style: TextStyle(color: color_primary))
        ]));
  }
}
