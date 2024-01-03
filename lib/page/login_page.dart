import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plus_promo/model/usuario/login_usuario_model.dart';
import 'package:plus_promo/provider/ProviderClient.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/textos.dart';

class LoginPage extends StatelessWidget {
  TextEditingController oTextInputControllerUsuario = TextEditingController();
  TextEditingController oTextInputControllerPass = TextEditingController();

  LoginPage();

  @override
  Widget build(BuildContext context) {
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
            controller: oTextInputControllerUsuario,
            style: TextStyle(fontSize: textMedium),
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: hint_email),
          ),
          SizedBox(
            height: marginSmallSmall,
          ),
          TextField(
            controller: oTextInputControllerPass,
            obscureText: true,
            obscuringCharacter: "*",
            style: TextStyle(fontSize: textMedium),
            decoration: InputDecoration(
                border: UnderlineInputBorder(), hintText: hint_pass),
          ),
          SizedBox(
            height: marginMedium,
          ),
          ElevatedButton(
              onPressed: () {
                _initLoginUsuario(context);
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed("/carrusel_page");
                },
              style: TextStyle(color: color_primary))
        ]));
  }

  _initLoginUsuario(context) async {
    LoginUsuarioModel oL = await ProviderClient.loginClient(
        oTextInputControllerUsuario.text, oTextInputControllerPass.text);

    if (oL.statusCode == 200) {
      Navigator.of(context).pushNamed("/home_page");
    } else {
      Fluttertoast.showToast(
          msg: oL.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
