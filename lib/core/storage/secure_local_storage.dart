import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureLocalStorage {
  String userId = "userId";
  String token = "token";
  String pinCode = "pinCode";

  late FlutterSecureStorage sharedPref;

  SecureLocalStorage() {
    sharedPref = FlutterSecureStorage();
  }

  Future<String> getStringValue({required String key}) async {
    return await sharedPref.read(key: key) ?? "";
  }

  void storeStringValue({required String key, required String value}) async {
    await sharedPref.write(key: key, value: value);
  }

  void deleteValue({required String key}) async {
    await sharedPref.delete(key: key);
  }
}
