// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  static Future init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String getString(key) {
    _sharedPrefs!.reload();
    return _sharedPrefs!.getString(key)!;
  }

  addString(String key, value) async {
    await _sharedPrefs!.setString(key, value);
  }

  removeString(key) async {
    await _sharedPrefs!.remove(key);
  }

  addBool(String key, value) async {
    await _sharedPrefs!.setBool(key, value);
  }

  getBool(key) {
    _sharedPrefs!.reload();
    return _sharedPrefs!.getBool(key);
  }

  clearPrefs() async {
    await _sharedPrefs!.clear();
  }
}
