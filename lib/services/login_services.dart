class Auth {
  Future<String?> loginService(String username, String password) async {
    if (username == '2015051034' && password == '2015051034') {
      return "Success";
    } else {
      return "Failed";
    }
  }
}
