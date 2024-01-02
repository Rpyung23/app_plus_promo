import 'dart:convert';

import 'package:plus_promo/model/usuario/login_usuario_model.dart';
import 'package:http/http.dart' as http;
import 'package:plus_promo/util/url.dart';

class ProviderUsuario {
  ProviderUsuario() {}

  static Future<LoginUsuarioModel> loginUsuario(usuario, pass) async {
    try {
      http.Response response = await http.post(Uri.parse(url_login_usuario),
          encoding: encondingApi,
          headers: headersApi,
          body: jsonEncode({'user': usuario, 'pass': pass}));

      return LoginUsuarioModel.fromRawJson(response.body);
    } catch (e) {
      return LoginUsuarioModel(statusCode: 400, msm: e.toString());
    }
  }
}
