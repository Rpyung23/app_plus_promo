import 'dart:convert';

import 'package:plus_promo/model/profileclientmodel.dart';
import 'package:plus_promo/model/usuario_vendedor/login_usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:plus_promo/util/url.dart';

import '../model/response_model.dart';

class ProviderClient {
  ProviderClient() {}

  static Future<LoginClienteVendedorModel> loginClient(usuario, pass) async {
    try {
      http.Response response = await http.post(Uri.parse(url_login_client),
          encoding: encondingApi,
          headers: headersApi,
          body: jsonEncode({'user': usuario, 'pass': pass}));

      return LoginClienteVendedorModel.fromRawJson(response.body);
    } catch (e) {
      return LoginClienteVendedorModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ProfileClientModel> profilenClient(usuario) async {
    try {
      http.Response response = await http.post(Uri.parse(url_profile_client),
          encoding: encondingApi,
          headers: headersApi,
          body: jsonEncode({'email_client': usuario}));

      return ProfileClientModel.fromRawJson(response.body);
    } catch (e) {
      return ProfileClientModel(statusCode: 400, msm: e.toString());
    }
  }

  static Future<ResponseModel> createClient(email_client, pass_client,
      name_client, dni_client, sex_client, f_client, tel_client) async {
    try {
      http.Response oR = await http.post(Uri.parse(url_create_client),
          headers: headersApi,
          encoding: encondingApi,
          body: jsonEncode({
            "email_client": "cliente@gmail.com",
            "pass_client": "12345678",
            "name_client": "CLIENTES TEST",
            "dni_client": "0604588653",
            "photo_client":
                "https://firebasestorage.googleapis.com/v0/b/pluspromo-773e2.appspot.com/o/client%2Fcsm_Person_Yury_Prof_Foto_AnLI_Footgrafie__2_.JPG_94f12fbf25.jpg?alt=media",
            "sex_client": "M", // M o F
            "f_client": "1998-06-11",
            "tel_client": "0993706015"
          }));
      return ResponseModel.fromRawJson(oR.body);
    } catch (e) {
      return ResponseModel(statusCode: 400, msm: e.toString());
    }
  }
}
