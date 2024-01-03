import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plus_promo/model/response_model.dart';
import 'package:plus_promo/provider/ProviderClient.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/textos.dart';

class RegsitroPage extends StatefulWidget {
  String tipo_registro = 'c';
  TextEditingController oTextEditingControllerName = TextEditingController();
  TextEditingController oTextEditingControllerEmail = TextEditingController();
  TextEditingController oTextEditingControllerPass = TextEditingController();
  TextEditingController oTextEditingControllerPassCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  RegsitroPage({required this.tipo_registro});

  @override
  State<RegsitroPage> createState() => _RegsitroPageState();
}

class _RegsitroPageState extends State<RegsitroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: widget.tipo_registro == 'c'
              ? const Text(toolbar_cliente)
              : const Text(toolbar_vendedor)),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        alignment: Alignment.bottomCenter,
        child: Expanded(
          child: ElevatedButton(
              onPressed: () {
                _apiCreateclient();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: color_primary,
                  minimumSize: Size.fromHeight(altoMedium)),
              child: Text(txt_aceptar,
                  style: TextStyle(
                      fontSize: textMedium,
                      color: color_secondary,
                      fontWeight: FontWeight.w700))),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(marginSmall),
        child: Form(
            key: widget._formKey,
            child: ListView(
              children: [
                Text(
                  sub_toolbar,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: textBigMedium, fontWeight: FontWeight.w200),
                ),
                SizedBox(height: marginMedium),
                TextFormField(
                  style: TextStyle(fontSize: textMedium),
                  controller: widget.oTextEditingControllerName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return texto_vacio;
                    }
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Nombres y Apellidos'),
                ),
                SizedBox(
                  height: marginMedium,
                ),
                TextFormField(
                  controller: widget.oTextEditingControllerEmail,
                  style: TextStyle(fontSize: textMedium),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return texto_vacio;
                    } else if (!_getCheckEmail(value)) {
                      return texto_email_invalid;
                    }
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Correo eletrónico'),
                ),
                SizedBox(
                  height: marginMedium,
                ),
                TextFormField(
                  style: TextStyle(fontSize: textMedium),
                  controller: widget.oTextEditingControllerPass,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLength: 9,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return texto_vacio;
                    } else if (value.length < 9) {
                      return texto_pass_corta;
                    }
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), hintText: 'Contraseña'),
                ),
                SizedBox(
                  height: marginMediumSmall,
                ),
                TextFormField(
                  style: TextStyle(fontSize: textMedium),
                  controller: widget.oTextEditingControllerPassCon,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLength: 9,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return texto_vacio;
                    } else if (value.length < 9) {
                      return texto_pass_corta;
                    } else if (value !=
                        widget.oTextEditingControllerPass.text) {
                      return texto_pass_difirente;
                    }
                  },
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Confirmación de contraseña'),
                ),
                SizedBox(
                  height: marginMediumSmall,
                ),
              ],
            )),
      ),
    );
  }

  _apiCreateclient() async {
    if (!widget._formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: texto_vacio, backgroundColor: color_danger);
      return;
    }
    ResponseModel oR = await ProviderClient.createClient(
        widget.oTextEditingControllerEmail.text,
        widget.oTextEditingControllerPass.text,
        widget.oTextEditingControllerName.text,
        "",
        "M",
        "1998-06-11",
        "XXXX XXX XXX");
    Fluttertoast.showToast(
        msg: oR.msm!,
        backgroundColor: oR.statusCode == 200
            ? color_success
            : oR.statusCode == 300
                ? color_info
                : color_danger,
        textColor: color_secondary,
        gravity: ToastGravity.BOTTOM);
  }

  _getCheckEmail(value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
