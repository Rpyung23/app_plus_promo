import '../model/create_cupon.dart';
import 'package:http/http.dart' as http;

import '../util/url.dart';

class ProviderCreateCupon {
  static Future<CreateCuponModel> createCupon(
      email, name, porcent, f_exp, cant, foto) async {
    try {
      http.Response oResponse = await http.post(Uri.parse(url_create_cupon),
          headers: headersApi, encoding: encondingApi);
      return CreateCuponModel.fromRawJson(oResponse.body);
    } catch (e) {
      return CreateCuponModel(statusCode: 400, msm: e.toString());
    }
  }
}