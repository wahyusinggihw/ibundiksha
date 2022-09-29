class Services {
  Future<String?> loginService(String email, String password) async {
    if (email == 'wahyu@gmail.com' && password == 'wahyus') {
      return "Success";
    } else {
      return "Failed";
    }
  }
}
