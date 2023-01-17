// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/widgets/snackbars.dart';
import '../widgets/menu_home.dart';
import 'package:ibundiksha/services/auth_services.dart';

class RegisterWideLayout extends StatefulWidget {
  const RegisterWideLayout({Key? key}) : super(key: key);

  @override
  State<RegisterWideLayout> createState() => _RegisterWideLayoutState();
}

class _RegisterWideLayoutState extends State<RegisterWideLayout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  SharedPrefs sharedPrefs = SharedPrefs();
  final Auth _auth = Auth();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var mainWideContainer = MenuHome.mainWideContainer;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: mainWideContainer(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Username"),
                        ),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username cant empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Password"),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            suffixIcon: _isObscure
                                ? IconButton(
                                    icon: const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = true;
                                      });
                                    },
                                  ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cant empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Password"),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cant empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.cyan,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const SizedBox(
                              width: 100,
                              child: Text(
                                'Login',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var status = await _auth.registerService(
                                    nama: _namaController.text,
                                    username: _usernameController.text,
                                    nim: _nimController.text.substring(7),
                                    password: _passwordController.text);
                                if (status!.isLoggedIn == true) {
                                  var loginSuccess = successSnackBar(
                                      "Register Success\nSigned in as ${_usernameController.text}");
                                  if (kDebugMode) {
                                    print("Register success");
                                  }
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(loginSuccess);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/main', (route) => false);
                                } else {
                                  var loginFailed =
                                      errorSnackBar("Register failed");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(loginFailed);
                                  if (kDebugMode) {
                                    print("Register failed");
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        // const SizedBox(height: 10),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, routeLoginScreen);
                              },
                              child: const Text('Login Mbanking'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
