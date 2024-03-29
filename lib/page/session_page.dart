import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plus_promo/model/store_model.dart';
import 'package:plus_promo/model/usuario_vendedor/login_usuario_model.dart';
import 'package:plus_promo/provider/ProviderClient.dart';
import 'package:plus_promo/provider/ProviderVendedor.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/textos.dart';

import '../util/secure_data.dart';

class SessionPage extends StatefulWidget {
  String type_use = 'u';
  TextEditingController oTextInputControllerUsuario = TextEditingController();
  TextEditingController oTextInputControllerPass = TextEditingController();
  bool isObscureTextPass = true;
  final _formKey = GlobalKey<FormState>();

  SessionPage({type_use}) {
    this.type_use = type_use;
  }

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
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
      child: Form(
          key: widget._formKey,
          child: ListView(
            children: [
              Image.asset(
                './assets/logo.png',
              ),
              TextFormField(
                controller: widget.oTextInputControllerUsuario,
                style: TextStyle(fontSize: textMedium),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return texto_vacio;
                  }
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), hintText: hint_email),
              ),
              SizedBox(
                height: marginSmallSmall,
              ),
              TextFormField(
                controller: widget.oTextInputControllerPass,
                obscureText: widget.isObscureTextPass,
                obscuringCharacter: "*",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return texto_vacio;
                  }
                },
                style: TextStyle(fontSize: textMedium),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: widget.isObscureTextPass
                          ? Icon(Iconsax.eye)
                          : Icon(Iconsax.eye_slash),
                      onPressed: () {
                        widget.isObscureTextPass =
                            widget.isObscureTextPass ? false : true;
                        setState(() {});
                      },
                    ),
                    border: UnderlineInputBorder(),
                    hintText: hint_pass),
              ),
              SizedBox(
                height: marginMedium,
              ),
              ElevatedButton(
                  onPressed: () {
                    _initLoginUsuarioVendedor(context, widget.type_use);
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
          )),
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

  _initLoginUsuarioVendedor(context, type) async {
    if (!widget._formKey.currentState!.validate()) {
      //Fluttertoast.showToast(msg: texto_vacio, backgroundColor: color_danger);
      return;
    }

    LoginClienteVendedorModel oL;

    if (type == 'u') {
      oL = await ProviderClient.loginClient(
          widget.oTextInputControllerUsuario.text,
          widget.oTextInputControllerPass.text);
    } else {
      oL = await ProviderVendedor.loginVendedor(
          widget.oTextInputControllerUsuario.text,
          widget.oTextInputControllerPass.text);
    }

    if (oL.statusCode == 200) {
      SecureData.saveStoragePreference(widget.oTextInputControllerUsuario.text);
      SecureData.saveStorageTipoUserPreference(type);
      type == 'u'
          ? Navigator.of(context).pushNamed("/home_page")
          : Navigator.of(context).pushNamed("/home_vendedor");
    } else if (oL.statusCode == 300) {
      Fluttertoast.showToast(
          msg: 'USUARIO NO ENCONTRADO',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: color_info,
          textColor: color_secondary,
          fontSize: 16.0);
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

    /*if (oL.statusCode == 200) {
      type == 'u'
          ? Navigator.of(context).pushNamed("/home_page")
          : Navigator.of(context).pushNamed("/home_vendedor");
    } else if (oL.statusCode == 300) {
      LoginClienteVendedorModel oLV = await ProviderVendedor.loginVendedor(
          widget.oTextInputControllerUsuario.text,
          widget.oTextInputControllerPass.text);
      if (oLV.statusCode == 200) {
        type == 'u'
            ? Navigator.of(context).pushNamed("/home_page")
            : Navigator.of(context).pushNamed("/home_vendedor");
      } else if (oLV.statusCode == 300 && oL.statusCode == 300) {
        Fluttertoast.showToast(
            msg: 'USUARIO NO ENCONTRADO',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: color_info,
            textColor: color_secondary,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: oLV.msm!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: oL.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }*/
  }
}
