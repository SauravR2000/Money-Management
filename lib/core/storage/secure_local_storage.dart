import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureLocalStorage {
  static String userId = "userId";
  static String token = "token";

  late EncryptedSharedPreferences sharedPref;

  SecureLocalStorage() {
    sharedPref = EncryptedSharedPreferences.getInstance();
  }

  String getStringValue({required String key}) {
    return sharedPref.getString(key) ?? "";
  }

  void storeStringValue({required String key, required String value}) {
    sharedPref.setString(key, value);
  }

  void deleteValue({required String key}) {
    sharedPref.remove(key);
  }
}
