import 'package:flutter/material.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/textos.dart';

class RegsitroPage extends StatefulWidget {
  String tipo_registro = 'c';
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
        child: Expanded(child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: color_primary,
                minimumSize: Size.fromHeight(altoMedium)),
            child: Text(txt_aceptar,
                style: TextStyle(
                    fontSize: textMedium,
                    color: color_secondary,
                    fontWeight: FontWeight.w700))),),
      ),
      body: Container(
        margin: EdgeInsets.all(marginSmall),
        child: ListView(
          children: [
            Text(
              sub_toolbar,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: textBigMedium, fontWeight: FontWeight.w200),
            ),
            SizedBox(height: marginMedium),
            TextField(
              style: TextStyle(fontSize: textMedium),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: hint_email),
            ),
            SizedBox(
              height: marginMedium,
            ),
            TextField(
              style: TextStyle(fontSize: textMedium),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: hint_pass),
            ),
            SizedBox(
              height: marginMedium,
            ),
            TextField(
              style: TextStyle(fontSize: textMedium),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 9,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: hint_email),
            ),
            SizedBox(
              height: marginMediumSmall,
            ),
            TextField(
              style: TextStyle(fontSize: textMedium),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              maxLength: 9,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: hint_pass),
            ),
            SizedBox(
              height: marginMediumSmall,
            ),
          ],
        ),
      ),
    );
  }
}
