import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/screens/home.dart';
import 'package:ibundiksha/services/list_users_service.dart';

class LoginApi extends StatefulWidget {
  const LoginApi({Key? key}) : super(key: key);

  @override
  State<LoginApi> createState() => _LoginApiState();
}

class _LoginApiState extends State<LoginApi> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TextField(
                  controller: usernameController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(
                        fontSize: 50,
                      )),
                ),
              ),
              Container(
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 50,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // ListUsersService _service = ListUsersService();
                  // var status = await _service.postLogin(
                  //     usernameController.text, passwordController.text);
                  // if (status!.contains('Success')) {
                  //   print("success");
                  //   Navigator.pushNamedAndRemoveUntil(
                  //       context, routeHomeScreen, (route) => false);
                  // } else {
                  //   print('salah');
                  // }
                },
                child: const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// postLogin(String username, String password) async {
//   ListUsersService _service = ListUsersService();
//   await _service.postLogin(username, password);
//   return 'Success';
// }
