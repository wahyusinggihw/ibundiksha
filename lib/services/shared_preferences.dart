// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  static Future init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String getString(key) {
    return _sharedPrefs!.getString(key)!;
  }

  static addString(String key, value) async {
    await _sharedPrefs!.setString(key, value);
  }

  static addBool(String key, value) async {
    await _sharedPrefs!.setBool(key, value);
  }

  static getBool(String key) {
    return _sharedPrefs!.getBool(key)!;
  }

  clearString() async {
    await _sharedPrefs!.clear();
  }
}
