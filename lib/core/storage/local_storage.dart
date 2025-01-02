import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LocalStorageSharedPref {
  String userId = "userId";
  String token = "token";
  String userName = "userName";

  Future<SharedPreferences> getSharedPreferenceInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<String> getStringValue({required String key}) async {
    final SharedPreferences sharedPref = await getSharedPreferenceInstance();
    return sharedPref.getString(key) ?? "";
  }

  void storeStringValue({required String key, required String value}) async {
    final SharedPreferences sharedPref = await getSharedPreferenceInstance();
    sharedPref.setString(key, value);
  }

  void deleteValue({required String key}) async {
    final SharedPreferences sharedPref = await getSharedPreferenceInstance();
    sharedPref.remove(key);
  }
}
