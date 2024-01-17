import 'dart:convert';

import 'package:plus_promo/util/secure_data.dart';

import '../model/create_cupon.dart';
import 'package:http/http.dart' as http;

import '../model/cupon_lista/cupon_lista.dart';
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
      email, name, porcent, f_exp, cant, foto) async {
    try {
      http.Response oResponse = await http.post(Uri.parse(url_create_cupon),
          body: jsonEncode({
            "email": email,
            "name": name,
            "porcent": porcent,
            "f_exp": f_exp,
            "cant": cant,
            "foto": foto
          }),
          headers: headersApi,
          encoding: encondingApi);
      return CreateCuponModel.fromRawJson(oResponse.body);
    } catch (e) {
      return CreateCuponModel(statusCode: 400, msm: e.toString());
    }
  }
}
