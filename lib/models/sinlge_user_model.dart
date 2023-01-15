// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class SingleUserModel {
  SingleUserModel({
    this.userId,
    this.username,
    this.password,
    this.nama,
    this.saldo,
    this.nomorRekening,
  });
  int? userId;
  String? username;
  String? password;
  String? nama;
  double? saldo;
  String? nomorRekening;

  factory SingleUserModel.fromJson(Map<String, dynamic> json) =>
      SingleUserModel(
        userId: json["user_id"],
        username: json["username"],
        password: json["password"],
        nama: json["nama"],
        saldo: json["saldo"],
        nomorRekening: json["nomor_rekening"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "password": password,
        "nama": nama,
        "saldo": saldo,
        "nomor_rekening": nomorRekening,
      };
}
