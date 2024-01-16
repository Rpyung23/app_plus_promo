import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plus_promo/util/textos.dart';

class SecureData {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static FlutterSecureStorage storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  static saveStoragePreference(email) async {
    try {
      await storage.write(key: 'codigo', value: email);
      return true;
    } catch (e) {
      return false;
    }
  }
}
