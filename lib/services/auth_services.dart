import 'dart:convert';
import 'dart:ffi';

import "package:dio/dio.dart";
import 'package:ibundiksha/models/current_user_model.dart';
import 'package:ibundiksha/models/list_users_model.dart';
import 'package:ibundiksha/services/shared_preferences.dart';

class Auth {
  Dio dio = Dio();
  // Future<String?> loginService(String username, String password) async {
  //   if (username == '2015051034' && password == '2015051034') {
  //     return "Success";
  //   } else {
  //     return "Failed";
  //   }
  // }

  String url = "https://koperasiundiksha.000webhostapp.com";
  SharedPrefs sharedPrefs = SharedPrefs();

  Future<CurrentUserModel?> loginService({
    required String username,
    required String password,
  }) async {
    final Response response;

    try {
      // response = await dio.get(url);
      // di reqres tidak memakai header dan token jadi di komen dulu
      // dio.options.headers['Authentication'] = 'Bearer $token'
      // dio.options.headers['Content-Type'] = 'application/json'
      response = await dio.post(
        url,
        data: {
          "username": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // print(json);
        var data = response.data;

        List<dynamic> dataList = (data['data'] as List).cast<dynamic>();

        double? saldo = double.parse(dataList[0]['saldo']);
        int? userId = int.parse(dataList[0]['user_id']);

        CurrentUserModel currentUserData = CurrentUserModel(
          isLoggedIn: true,
          userId: userId,
          username: dataList[0]['username'],
          nama: dataList[0]['nama'],
          password: dataList[0]['password'],
          saldo: saldo,
        );
        sharedPrefs.addString('nama', currentUserData.nama!);
        sharedPrefs.addString('username', currentUserData.username!);
        sharedPrefs.addString('saldo', currentUserData.saldo!.toString());
        print(currentUserData.saldo);

        return currentUserData;
      }
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
    return null;
  }

  registerService({required String username, nama, password}) async {
    final Response response;

    try {
      response = await dio.post('$url+/register', data: {
        "username": username,
        "nama": nama,
        "password": password,
      });

      if (response.statusCode == 200) {
        var data = response.data;
        if (data['status'] == 'success') {
          print(data['data']);
        }
      }
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  logoutService() {
    sharedPrefs.clearString();
    CurrentUserModel currentUserData = CurrentUserModel(
      isLoggedIn: false,
    );
    return currentUserData;
  }
}
