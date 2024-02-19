import 'dart:convert';

import 'package:plus_promo/model/response_model.dart';
import 'package:plus_promo/util/secure_data.dart';

import '../model/create_cupon.dart';
import 'package:http/http.dart' as http;

import '../model/cupon_lista/cupon_lista.dart';
import '../model/cupon_lista/data_cupon_lista.dart';
import '../model/static_cupon.dart';
import '../util/url.dart';

class ProviderCreateCupon {
  static Future<ListCuponModel> readCuponList() async {
    try {
      var email = await SecureData.getStoragePreference();

      http.Response oResponse = await http.post(Uri.parse(url_list_cupon),
          body: jsonEncode({
            "email": email,
          }),
          headers: headersApi,
          encoding: encondingApi);
      print(oResponse.body);
      return ListCuponModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return ListCuponModel(statusCode: 400, datos: [], msm: e.toString());
    }
  }

  static Future<CreateCuponModel> createCupon(
      email, name, porcent, f_exp, cant, foto, idCategoria) async {
    try {
      http.Response oResponse = await http.post(Uri.parse(url_create_cupon),
          body: jsonEncode({
            "email": email,
            "name": name,
            "porcent": porcent,
            "f_exp": f_exp,
            "cant": cant,
            "foto": foto,
            "categoria": idCategoria
          }),
          headers: headersApi,
          encoding: encondingApi);
      return CreateCuponModel.fromRawJson(oResponse.body);
    } catch (e) {
      return CreateCuponModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ResponseModel> updateCupon(
      DatoCuponLista oDatoCuponLista, categoria) async {
    try {
      http.Response oR = await http.put(Uri.parse(url_update_cupon),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({
            "code_cupon": oDatoCuponLista.codeCupon,
            "nombre_cupon": oDatoCuponLista.nombreCupon,
            "porcetaje_descuento": oDatoCuponLista.porcetajeDescuento,
            "fecha_expiracion": oDatoCuponLista.fechaExpiracion,
            "cant_cupon": oDatoCuponLista.cantCupon,
            "categoria": categoria
          }));
      return ResponseModel.fromRawJson(oR.body);
    } catch (e) {
      return ResponseModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ListCuponModel> readCuponClientList() async {
    try {
      //var email = await SecureData.getStoragePreference();

      http.Response oResponse =
          await http.get(Uri.parse(url_list_client_cupon), headers: headersApi);
      print(oResponse.body);
      return ListCuponModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return ListCuponModel(statusCode: 400, datos: [], msm: e.toString());
    }
  }

  static Future<ResponseModel> consumirCuponClient(usuario, cupon) async {
    try {
      http.Response oR = await http.put(Uri.parse(url_consumir_cupon),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({"user": usuario, "cupon": cupon}));
      return ResponseModel.fromRawJson(oR.body);
    } catch (e) {
      return ResponseModel(statusCode: 200, msm: e.toString());
    }
  }

  static Future<ModelStaticCupon> consumirPanelCupon() async {
    try {
      String? code = await SecureData.getStoragePreference();

      http.Response oR = await http.post(Uri.parse(url_static),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({"email": code}));
      print(oR.body);
      return ModelStaticCupon.fromRawJson(oR.body);
    } catch (e) {
      return ModelStaticCupon(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ListCuponModel> readCuponClientCategoryList(categoria) async {
    try {
      //var email = await SecureData.getStoragePreference();

      http.Response oResponse = await http.post(
          Uri.parse(url_list_client_cupon_categoria),
          body: jsonEncode({"categoria": categoria}),
          headers: headersApi,
          encoding: encondingApi);
      print(oResponse.body);
      return ListCuponModel.fromRawJson(oResponse.body);
    } catch (e) {
      print(e.toString());
      return ListCuponModel(statusCode: 400, datos: [], msm: e.toString());
    }
  }
}
