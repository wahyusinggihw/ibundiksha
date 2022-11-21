import "package:dio/dio.dart";

class Auth {
  Dio dio = Dio();
  Future<String?> loginService(String username, String password) async {
    if (username == '2015051034' && password == '2015051034') {
      return "Success";
    } else {
      return "Failed";
    }
  }

  postLogin(String username, String password) async {
    String url = "https://reqres.in/api/users";
    final Response response;

    FormData formData = FormData.fromMap(
      {
        "name": username,
        "job": password,
      },
    );
    try {
      // di reqres tidak memakai header dan token jadi di komen dulu
      // dio.options.headers['Authentication'] = 'Bearer $token'
      // dio.options.headers['Content-Type'] = 'application/json'
      response = await dio.post(
        url,
        data: formData,
      );
      if (response.statusCode == 201) {
        return 'Success';
      } else if (response.statusCode == 400) {
        return 'Failed';
      }
    } on DioError catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
