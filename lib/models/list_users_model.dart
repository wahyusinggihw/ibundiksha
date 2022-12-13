// class ListUsersModel {
//   ListUsersModel({
//     this.id,
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.avatar,
//   });

//   int? id;
//   String? email;
//   String? firstName;
//   String? lastName;
//   String? avatar;

//   factory ListUsersModel.fromJson(Map<String, dynamic> json) => ListUsersModel(
//         id: json["id"],
//         email: json["email"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         avatar: json["avatar"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "email": email,
//         "first_name": firstName,
//         "last_name": lastName,
//         "avatar": avatar,
//       };

// }

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class ListUsersModel {
  ListUsersModel({
    this.userId,
    this.username,
    this.nama,
    this.saldo,
  });
  String? userId;
  String? username;
  String? nama;
  String? saldo;

  factory ListUsersModel.fromJson(Map<String, dynamic> json) => ListUsersModel(
        userId: json["user_id"],
        username: json["username"],
        nama: json["nama"],
        saldo: json["saldo"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "nama": nama,
        "saldo": saldo,
      };
}
