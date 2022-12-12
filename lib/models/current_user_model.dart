// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class CurrentUserModel {
  CurrentUserModel({
    this.isLoggedIn,
    this.userId,
    this.username,
    this.password,
    this.nama,
    this.saldo,
  });
  bool? isLoggedIn;
  int? userId;
  String? username;
  String? password;
  String? nama;
  double? saldo;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        isLoggedIn: false,
        userId: json["user_id"],
        username: json["username"],
        password: json["password"],
        nama: json["nama"],
        saldo: json["saldo"],
      );

  Map<String, dynamic> toJson() => {
        "isLoggedIn": isLoggedIn,
        "user_id": userId,
        "username": username,
        "password": password,
        "nama": nama,
        "saldo": saldo,
      };
}
