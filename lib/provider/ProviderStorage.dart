import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../model/store_model.dart';
import 'package:http/http.dart' as http;

import '../util/url.dart';

class ProviderStorage {
  static Future<StorageModel> createStore(XFile oF) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url_upload_foto));
      var file = await http.MultipartFile.fromPath('file', oF.path);
      request.files.add(file);
      var response = await request.send();
      var body = await response.stream.bytesToString();
      print(body);

      return StorageModel.fromRawJson(body);
    } catch (e) {
      return StorageModel(downloadUrl: null);
    }
  }
}
