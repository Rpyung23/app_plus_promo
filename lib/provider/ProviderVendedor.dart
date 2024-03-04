import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plus_promo/model/response_model.dart';
import 'package:plus_promo/model/usuario_vendedor/login_usuario_model.dart';
import 'package:plus_promo/util/url.dart';

import '../model/profileclientmodel.dart';

class ProviderVendedor {
  ProviderVendedor();

  static Future<ResponseModel> createVendedor(email, pass, name) async {
    try {
      http.Response oR = await http.post(Uri.parse(url_create_vendedor),
          encoding: encondingApi,
          headers: headersApi,
          body: jsonEncode({
            "email": email,
            "pass": pass,
            "name": name,
            "photo":
                "https://firebasestorage.googleapis.com/v0/b/pluspromo-773e2.appspot.com/o/user%2Fimages.jpg?alt=media"
          }));

      return ResponseModel.fromRawJson(oR.body);
    } catch (e) {
      return ResponseModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<LoginClienteVendedorModel> loginVendedor(email, pass) async {
    try {
      http.Response oR = await http.post(Uri.parse(url_login_vendedor),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({"user": email, "pass": pass}));

      return LoginClienteVendedorModel.fromRawJson(oR.body);
    } catch (e) {
      return LoginClienteVendedorModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ProfileClientModel> profilenVendedor(usuario) async {
    try {
      http.Response response = await http.post(Uri.parse(url_profile_usuario),
          encoding: encondingApi,
          headers: headersApi,
          body: jsonEncode({'email_client': usuario}));

      print(response.body);

      return ProfileClientModel.fromRawJson(response.body);
    } catch (e) {
      return ProfileClientModel(statusCode: 400, msm: e.toString());
    }
  }
}
