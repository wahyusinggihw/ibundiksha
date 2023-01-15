import "package:dio/dio.dart";
import 'package:ibundiksha/models/list_users_model.dart';
import 'package:ibundiksha/models/current_user_model.dart';
import 'package:ibundiksha/models/sinlge_user_model.dart';

class ListUsersService {
  Dio dio = Dio();
  String url = "http://apikoperasi.rey1024.com";

  Future<List<ListUsersModel>?> getDataUsers() async {
    final Response response;
    try {
      response = await dio.get(
        '$url/users',
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print(json);
        var json = response.data;
        return json
            .map<ListUsersModel>((u) => ListUsersModel.fromJson(u))
            .toList();
      }
      return null;
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  Future<SingleUserModel?> getSingleUser(int userId) async {
    final Response response;
    try {
      response = await dio.post(
        '$url/getsingleuser',
        data: {
          "user_id": userId,
        },
      );
      if (response.statusCode == 200) {
        var data = response.data;
        // print(data[0]);
        double? saldo = double.parse(data[0]["saldo"]);
        int? userId = int.parse(data[0]["user_id"]);
        SingleUserModel singleUserModel = SingleUserModel(
          userId: userId,
          username: data[0]["username"],
          password: data[0]["password"],
          nama: data[0]["nama"],
          saldo: saldo,
          nomorRekening: data[0]["nomor_rekening"],
        );
        return singleUserModel;
      }
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
    return null;
  }

  // Future<List<ListUsersModel>?> getDataUsers() async {
  //   String url = "https://reqres.in/api/users?page=2";
  //   final Response response;
  //   try {
  //     response = await dio.get(
  //       url,
  //     );
  //     // print(response.data);
  //     if (response.statusCode == 200) {
  //       var json = response.data;
  //       //boleh dipakai sesuai kondisi data json
  //       if (json is Map && json.keys.contains('data')) {
  //         var data = json['data'];
  //         if (data is List) {
  //           return data
  //               .map<ListUsersModel>((u) => ListUsersModel.fromJson(u))
  //               .toList();
  //         }
  //       }
  //     }
  //     return null;
  //   } on DioError catch (error, stacktrace) {
  //     print('Exception occured: $error stackTrace: $stacktrace');
  //     throw Exception(error.response);
  //   }
  // }

}
