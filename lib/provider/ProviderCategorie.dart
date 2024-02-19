import 'package:http/http.dart' as http;
import 'package:plus_promo/util/url.dart';

import '../model/categorie/categorie_model.dart';

class ProviderCategorie {
  static Future<ModelCategorie> readCategoriaModel() async {
    try {
      http.Response oR =
          await http.get(Uri.parse(url_categorie), headers: headersApi);
      return ModelCategorie.fromRawJson(oR.body);
    } catch (e) {
      return ModelCategorie(statusCode: 400, msm: e.toString(), datos: []);
    }
  }
}
