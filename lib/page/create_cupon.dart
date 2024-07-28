// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plus_promo/model/store_model.dart';
import 'package:plus_promo/provider/ProviderCupon.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/secure_data.dart';

import '../model/categorie/categorie_model.dart';
import '../model/categorie/data_categorie_model.dart';
import '../model/create_cupon.dart';
import '../model/cupon_lista/data_cupon_lista.dart';
import '../model/response_model.dart';
import '../provider/ProviderCategorie.dart';
import '../provider/ProviderStorage.dart';
import '../util/icons.dart';

class CreateCuponPage extends StatefulWidget {
  XFile? oXFile;
  ImagePicker oImagePicker = ImagePicker();

  TextEditingController oTextEditingControllerName = TextEditingController();
  TextEditingController oTextEditingControllerPor = TextEditingController();
  TextEditingController oTextEditingControllerFExp = TextEditingController();
  TextEditingController oTextEditingControllerCantCu = TextEditingController();
  List<DatoCategorieModel> oDatoCategorieModel = [];
  DatoCategorieModel? oDatoCategorieSelectModel;

  int update_create_cupon;
  DatoCuponLista? oDatoCuponLista;

  CreateCuponPage(
      {required this.update_create_cupon, required this.oDatoCuponLista});

  @override
  State<CreateCuponPage> createState() => _CreateCuponPageState();
}

class _CreateCuponPageState extends State<CreateCuponPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.update_create_cupon == 1) {
      widget.oTextEditingControllerName.text =
          widget.oDatoCuponLista!.nombreCupon!;
      widget.oTextEditingControllerPor.text =
          widget.oDatoCuponLista!.porcetajeDescuento!;
      widget.oTextEditingControllerFExp.text =
          widget.oDatoCuponLista!.fechaExpiracion!.toString();
      widget.oTextEditingControllerCantCu.text =
          widget.oDatoCuponLista!.cantCupon!.toString();
    }
    _initApiCategoria();
  }

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
        DropdownButtonFormField(
          items: _getItemCategorias(),
          onChanged: (item) {
            widget.oDatoCategorieSelectModel = item as DatoCategorieModel?;
          },
          decoration: InputDecoration(
              hintText: "Seleccionar Categoría",
              prefixIcon: icon_task,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder()),
        ),
        SizedBox(
          height: marginSmall,
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
            //showCursor: true,
            readOnly: true,
            onTap: () async {
              await _selectDate(context);
            },
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
            widget.update_create_cupon == 0
                ? _initCreateCupon()
                : _updateCupon();
          },
          child: Text(
            widget.update_create_cupon == 1
                ? "ACTUALIZAR CUPON"
                : "CREAR CUPON",
            style: TextStyle(color: color_secondary, fontSize: textMedium),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: color_primary,
              minimumSize: Size(double.infinity, altoMedium)),
        ),
        SizedBox(
          height: marginSmall,
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
            child: widget.oDatoCuponLista != null
                ? Image.network(widget.oDatoCuponLista!.fotoCupon!,
                    fit: BoxFit.cover)
                : widget.oXFile == null
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
    String? code = await SecureData.getStoragePreference();
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

    if (widget.oXFile == null && widget.update_create_cupon == 0) {
      Fluttertoast.showToast(
          msg: "SELECCIONAR IMAGEN PARA EL CUPON",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_success,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    StorageModel oStorageModel =
        await ProviderStorage.createStore(widget.oXFile!);

    if (oStorageModel.downloadUrl == null) {
      Fluttertoast.showToast(
          msg: 'FOTO NO SUBIDA',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: color_info,
          textColor: color_danger,
          fontSize: 16.0);

      return;
    }

    CreateCuponModel oCreateCuponModel = await ProviderCreateCupon.createCupon(
        code,
        widget.oTextEditingControllerName.text,
        widget.oTextEditingControllerPor.text,
        widget.oTextEditingControllerFExp.text,
        widget.oTextEditingControllerCantCu.text,
        oStorageModel.downloadUrl,
        widget.oDatoCategorieSelectModel!.idCategoria);

    if (oCreateCuponModel.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "CUPON CREADO CON EXITO",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_primary,
          textColor: Colors.white,
          fontSize: 16.0);
      _clearForm();
    } else {
      Fluttertoast.showToast(
          msg: oCreateCuponModel.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: color_danger,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  _clearForm() {
    widget.oDatoCategorieSelectModel = null;
    widget.oXFile = null;
    widget.oTextEditingControllerName.clear();
    widget.oTextEditingControllerPor.clear();
    widget.oTextEditingControllerFExp.clear();
    widget.oTextEditingControllerCantCu.clear();
    setState(() {});
  }

  _updateCupon() async {
    widget.oDatoCuponLista!.nombreCupon =
        widget.oTextEditingControllerName.text;
    widget.oDatoCuponLista!.porcetajeDescuento =
        widget.oTextEditingControllerPor.text;
    widget.oDatoCuponLista!.fechaExpiracion =
        widget.oTextEditingControllerFExp.text;
    widget.oDatoCuponLista!.cantCupon =
        int.tryParse(widget.oTextEditingControllerCantCu.text);
    ResponseModel oResponseModel = await ProviderCreateCupon.updateCupon(
        widget.oDatoCuponLista!, widget.oDatoCategorieSelectModel!.idCategoria);

    if (oResponseModel.statusCode == 200) {
      _clearForm();
      Navigator.of(context).pop();
    }

    Fluttertoast.showToast(
        msg: oResponseModel.statusCode == 200
            ? "CUPON ACTUALZIADO CON EXITO"
            : oResponseModel.msm!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color_success,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _initApiCategoria() async {
    ModelCategorie oM = await ProviderCategorie.readCategoriaModel();
    widget.oDatoCategorieModel = oM!.datos!;
    setState(() {});
  }

  _getItemCategorias() {
    List<DropdownMenuItem<DatoCategorieModel>> oL = [];
    try {
      for (var i = 0; i < widget.oDatoCategorieModel.length; i++) {
        oL.add(DropdownMenuItem(
            value: widget.oDatoCategorieModel[i],
            child: Text(widget.oDatoCategorieModel[i].detalleCategoria!)));
      }
      return oL;
    } catch (e) {
      print("CARGANDO ITEMS CATEGORIA.....");
      print(e.toString());
    }
    setState(() {});
  }

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      locale: Locale('es'),
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now())
      setState(() {
        widget.oTextEditingControllerFExp.text =
            "${pickedDate.toLocal()}".split(' ')[0];
      });
  }
}
