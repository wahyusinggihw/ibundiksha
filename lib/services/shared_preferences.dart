// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;
  static Future init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static Future setNIM(String nim) async {
    await _sharedPrefs!.setString('nim', nim);
  }

  static String getNIM(key) {
    return _sharedPrefs!.getString(key)!;
  }

  static Future setUsername(String username) async {
    await _sharedPrefs!.setString('username', username);
  }

  static String getUsername(key) {
    return _sharedPrefs!.getString(key)!;
  }

  // getString(String keyString) async {
  //   return _sharedPrefs!.getString(keyString);
  // }

  // setString(String key, String string) async {
  //   _sharedPrefs!.setString(key, string);
  // }
}
