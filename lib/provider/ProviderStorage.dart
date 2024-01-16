import '../model/store_model.dart';
import 'package:http/http.dart' as http;

import '../util/url.dart';

class ProviderStorage {
  static Future<StorageModel> createStore() async {
    try {
      http.Response oResponse = await http.post(Uri.parse(url_upload_foto));
      return StorageModel.fromRawJson(oResponse.body);
    } catch (e) {
      return StorageModel(downloadUrl: null);
    }
  }
}
