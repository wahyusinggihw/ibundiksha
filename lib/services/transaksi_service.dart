import "package:dio/dio.dart";
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/services/notif_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Transaksi {
  String url = "http://apikoperasi.rey1024.com/";
  Dio dio = Dio();
  SharedPrefs sharedPrefs = SharedPrefs();
  MyNotificationService notifService = MyNotificationService();

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
      String token = '';
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

        await FirebaseFirestore.instance
            .collection('usersToken')
            .doc(nomorRekening)
            .get()
            .then((DocumentSnapshot doc) {
          final dbData = doc.data() as Map<String, dynamic>;
          token = dbData['token'];
          print('token di firestore: $token');
        });

        notifService.sendPushNotification(
            title: 'Dana Masuk!',
            body: 'Dana Rp.$jumlahTransfer masuk ke rekening $nomorRekening',
            token: token);
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
