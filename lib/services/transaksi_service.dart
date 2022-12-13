import 'package:ibundiksha/models/current_user_model.dart';

import "package:dio/dio.dart";
import 'package:ibundiksha/models/current_user_model.dart';
import 'package:ibundiksha/models/list_users_model.dart';
import 'package:ibundiksha/services/shared_preferences.dart';

class Transaksi {
  String url = "https://koperasiundiksha.000webhostapp.com";
  Dio dio = Dio();
  SharedPrefs sharedPrefs = SharedPrefs();

  transferService({required int userId, required int jumlahSetoran}) async {
    final Response response;

    try {
      response = await dio.post(
        "$url/setoran?",
        data: {
          "user_id": userId,
          "jumlah_setoran": jumlahSetoran,
        },
      );
      var data = response.data;
      if (data['status'] == 'success') {
        print('success');
      } else {
        print('failed');
      }
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  tarikanService({required int userId, required jumlahTarikan}) async {
    final Response response;

    try {
      response = await dio.post(
        "$url/tarikan",
        data: {
          "user_id": userId,
          "jumlah_tarikan": jumlahTarikan,
        },
      );
      var data = response.data;
      if (data['status'] == 'success') {
        print('success');
      } else {
        print('failed');
      }
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
