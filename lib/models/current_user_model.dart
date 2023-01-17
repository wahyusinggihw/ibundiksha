class CurrentUserModel {
  CurrentUserModel({
    this.isLoggedIn,
    this.userId,
    this.username,
    this.password,
    this.nama,
    this.saldo,
    this.nomorRekening,
  });
  bool? isLoggedIn;
  int? userId;
  String? username;
  String? password;
  String? nama;
  double? saldo;
  String? nomorRekening;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        isLoggedIn: false,
        userId: json["user_id"],
        username: json["username"],
        password: json["password"],
        nama: json["nama"],
        saldo: json["saldo"],
        nomorRekening: json["nomor_rekening"],
      );

  Map<String, dynamic> toJson() => {
        "isLoggedIn": isLoggedIn,
        "user_id": userId,
        "username": username,
        "password": password,
        "nama": nama,
        "saldo": saldo,
        "nomor_rekening": nomorRekening,
      };
}
