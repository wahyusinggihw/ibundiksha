import 'dart:convert';
import 'dart:io';

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

  String url = "http://apikoperasi.rey1024.com";
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

      var data = response.data;
      print(response.statusCode);

      if (response.statusCode == 200) {
        double? saldo = double.parse(data[0]['saldo']);
        int? userId = int.parse(data[0]['user_id']);

        CurrentUserModel currentUserData = CurrentUserModel(
          isLoggedIn: true,
          userId: userId,
          username: data[0]['username'],
          nama: data[0]['nama'],
          password: data[0]['password'],
          saldo: saldo,
          nomorRekening: data[0]['nomor_rekening'],
        );

        sharedPrefs.addString('userId', currentUserData.userId!.toString());
        sharedPrefs.addString('nama', currentUserData.nama!);
        sharedPrefs.addString('username', currentUserData.username!);
        sharedPrefs.addString('saldo', currentUserData.saldo!.toString());
        sharedPrefs.addString(
            'nomorRekening', currentUserData.nomorRekening!.toString());
        sharedPrefs.addBool('isLoggedIn', currentUserData.isLoggedIn!);

        return currentUserData;
      } else if (response.statusCode == 404) {
        print('Login error');
      }
    } on DioError catch (error, stacktrace) {
      print('Login error');
      // print('Exception occured: $error stackTrace: $stacktrace');
      // throw Exception(error.response);
      CurrentUserModel currentUserData = CurrentUserModel(
        isLoggedIn: false,
      );
      return currentUserData;
    }
    return null;
  }

  Future<CurrentUserModel?> registerService(
      {required String username, nama, nim, password}) async {
    // final Response response;

    try {
      var response = await dio.post('$url/register', data: {
        "username": username,
        "nama": nama,
        "nim": nim,
        "password": password,
      });

      var data = response.data;

      if (response.statusCode == 200) {
        var loginResponse = await loginService(
          username: username,
          password: password,
        );
        return loginResponse;
      } else {
        print('Register error');
        CurrentUserModel currentUserData = CurrentUserModel(
          isLoggedIn: false,
        );
        return currentUserData;
      }
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
    return null;
  }

  logoutService() {
    sharedPrefs.addBool('isLoggedIn', false);
    CurrentUserModel currentUserData = CurrentUserModel(
      isLoggedIn: false,
    );
    return currentUserData;
  }
}
