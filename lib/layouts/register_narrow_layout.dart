// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/widgets/snackbars.dart';
import '../widgets/menu_home.dart';
import 'package:ibundiksha/services/auth_services.dart';
import 'package:ibundiksha/widgets/menu_home.dart';

class RegisterNarrowLayout extends StatefulWidget {
  const RegisterNarrowLayout({Key? key}) : super(key: key);

  @override
  State<RegisterNarrowLayout> createState() => _RegisterNarrowLayoutState();
}

class _RegisterNarrowLayoutState extends State<RegisterNarrowLayout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final Auth _auth = Auth();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mainContainer = MenuHome.mainContainer;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.05,
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
                child: mainContainer(
                  context,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("Nama lengkap"),
                        ),
                        TextFormField(
                          controller: _namaController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nama cant empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
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
                          child: Text("NIM"),
                        ),
                        TextFormField(
                          controller: _nimController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "NIM cant empty";
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
                                'Register',
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
                            // Spacer(),
                            // TextButton(
                            //   onPressed: () {
                            //     // Navigator.pushNamed(context, '/register');
                            //   },
                            //   child: Text('lupa password?'),
                            // ),
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
