import 'package:ibundiksha/models/current_user_model.dart';

import "package:dio/dio.dart";
import 'package:ibundiksha/models/current_user_model.dart';
import 'package:ibundiksha/models/list_users_model.dart';
import 'package:ibundiksha/services/shared_preferences.dart';

class Transaksi {
  String url = "http://apikoperasi.rey1024.com/";
  Dio dio = Dio();
  SharedPrefs sharedPrefs = SharedPrefs();

  currentUserSaldo({
    required int userId,
  }) async {
    final Response response;
    try {
      response = await dio.post(
        "$url/getsingleuser",
        data: {
          "user_id": userId,
        },
      );
      var data = response.data;
      if (response.statusCode == 200) {
        double? saldo = double.parse(data[0]['saldo']);
        sharedPrefs.addString('saldo', saldo.toString());
      } else {
        print('failed');
      }
      return data;
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  transferService(
      {required idPengirim,
      required int jumlahTransfer,
      required String nomorRekening}) async {
    final Response response;

    try {
      response = await dio.post(
        "$url/transfer",
        data: {
          "nomor_rekening": nomorRekening,
          "jumlah_transfer": jumlahTransfer,
          "id_pengirim": idPengirim,
        },
      );
      var data = response.data;
      if (data['status'] == 'success') {
        currentUserSaldo(userId: idPengirim).then((value) {
          double? saldo = double.parse(value[0]['saldo']);
          sharedPrefs.addString('saldo', saldo.toString());
        });
      } else {
        print('failed');
      }
      return data;
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  tarikanService({required int userId, required double jumlahTarikan}) async {
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
        currentUserSaldo(userId: userId).then((value) {
          double? saldo = double.parse(value[0]['saldo']);
          sharedPrefs.addString('saldo', saldo.toString());
        });
        print('success');
      } else {
        print('failed');
      }
      return data;
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  setoranService({required int userId, required double jumlahSetoran}) async {
    final Response response;

    try {
      response = await dio.post(
        "$url/setoran",
        data: {
          "user_id": userId,
          "jumlah_setoran": jumlahSetoran,
        },
      );
      var data = response.data;
      if (data['status'] == 'success') {
        currentUserSaldo(userId: userId).then((value) {
          double? saldo = double.parse(value[0]['saldo']);
          sharedPrefs.addString('saldo', saldo.toString());
        });
      } else {
        print('failed');
      }
      return data;
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
