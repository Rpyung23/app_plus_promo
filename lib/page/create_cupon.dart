import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plus_promo/model/store_model.dart';
import 'package:plus_promo/provider/ProviderCupon.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/secure_data.dart';

import '../model/create_cupon.dart';
import '../provider/ProviderStorage.dart';
import '../util/icons.dart';

class CreateCuponPage extends StatefulWidget {
  XFile? oXFile;

  ImagePicker oImagePicker = ImagePicker();

  TextEditingController oTextEditingControllerName = TextEditingController();
  TextEditingController oTextEditingControllerPor = TextEditingController();
  TextEditingController oTextEditingControllerFExp = TextEditingController();
  TextEditingController oTextEditingControllerCantCu = TextEditingController();

  CreateCuponPage({super.key});

  @override
  State<CreateCuponPage> createState() => _CreateCuponPageState();
}

class _CreateCuponPageState extends State<CreateCuponPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: color_secondary,
        backgroundColor: color_primary,
        title: Text("NUEVO CUPON"),
      ),
      body: Container(
        margin: EdgeInsets.only(right: marginSmall, left: marginSmall),
        child: _getBodyCreateCupon(),
      ),
    ));
  }

  _getBodyCreateCupon() {
    return ListView(
      children: [
        SizedBox(
          height: marginSmall,
        ),
        _getPictureImage(),
        SizedBox(
          height: marginMedium,
        ),
        TextFormField(
          controller: widget.oTextEditingControllerName,
          decoration: InputDecoration(
              hintText: "Nombre del cupón",
              prefixIcon: icon_cupon,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder()),
        ),
        SizedBox(
          height: marginSmall,
        ),
        TextFormField(
            controller: widget.oTextEditingControllerPor,
            keyboardType: TextInputType.number,
            showCursor: true,
            decoration: InputDecoration(
                prefixIcon: icon_porcent,
                hintText: "Porcentaje de descuento",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder())),
        SizedBox(
          height: marginSmall,
        ),
        TextFormField(
            controller: widget.oTextEditingControllerFExp,
            keyboardType: TextInputType.datetime,
            showCursor: true,
            decoration: InputDecoration(
                prefixIcon: icon_fecha,
                hintText: "Fecha de expiración",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder())),
        SizedBox(
          height: marginSmall,
        ),
        TextFormField(
            controller: widget.oTextEditingControllerCantCu,
            keyboardType: TextInputType.number,
            showCursor: true,
            decoration: InputDecoration(
                prefixIcon: icon_cant_cupons,
                hintText: "Cantidad de cupones",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder())),
        SizedBox(
          height: marginSmall,
        ),
        ElevatedButton(
          onPressed: () {
            _initCreateCupon();
          },
          child: Text(
            "CREAR CUPON",
            style: TextStyle(color: color_secondary, fontSize: textMedium),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: color_primary,
              minimumSize: Size(double.infinity, altoMedium)),
        )
      ],
    );
  }

  _getPictureImage() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            height: 200,
            width: 200,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: color_primary,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: widget.oXFile == null
                ? Image.asset("./assets/not_image.jpg", fit: BoxFit.cover)
                : Image.file(
                    File(widget.oXFile!.path),
                    fit: BoxFit.cover,
                  ),
          ),
          onTap: () {
            _getPickImagen();
          },
        )
      ],
    );
  }

  _getPickImagen() async {
    widget.oXFile =
        await widget.oImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {});
  }

  _initCreateCupon() async {
    String? code = SecureData.getStoragePreference();
    if (code == null) {
      Fluttertoast.showToast(
          msg: "ERROR STORAGE PREFERENCE",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    StorageModel oStorageModel =
        await ProviderStorage.createStore(File(widget.oXFile!.path));

    CreateCuponModel oCreateCuponModel = await ProviderCreateCupon.createCupon(
        code,
        widget.oTextEditingControllerName.text,
        widget.oTextEditingControllerPor.text,
        widget.oTextEditingControllerFExp.text,
        widget.oTextEditingControllerCantCu.text,
        '');

    if (oCreateCuponModel.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "CUPON CON EXITO",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_primary,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "ERROR CUPON",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_danger,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
