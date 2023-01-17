import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/widgets/snackbars.dart';

import '../widgets/menu_home.dart';

import 'package:ibundiksha/services/auth_services.dart';
import 'package:ibundiksha/widgets/menu_home.dart';

class LoginNarrowLayout extends StatefulWidget {
  const LoginNarrowLayout({Key? key}) : super(key: key);

  @override
  State<LoginNarrowLayout> createState() => _LoginNarrowLayoutState();
}

class _LoginNarrowLayoutState extends State<LoginNarrowLayout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = Auth();
  SharedPrefs sharedPrefs = SharedPrefs();
  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mainContainer = MenuHome.mainContainer;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
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
                          obscureText: _isObsecure,
                          decoration: InputDecoration(
                            suffixIcon: _isObsecure
                                ? IconButton(
                                    icon: const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObsecure = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObsecure = true;
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
                                'Login',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (kDebugMode) {
                                  print(_usernameController.text);
                                  print(_passwordController.text);
                                }
                                var status = await _auth.loginService(
                                    username: _usernameController.text,
                                    password: _passwordController.text);
                                if (status!.isLoggedIn == true) {
                                  var loginSuccess = successSnackBar(
                                      "Signed in as ${_usernameController.text}");

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(loginSuccess);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      routeMainScreen, (route) => false);
                                  if (kDebugMode) {
                                    print('User logged in');
                                  }
                                } else {
                                  var loginFailed =
                                      errorSnackBar("Login failed");
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(loginFailed);
                                  if (kDebugMode) {
                                    print('Login error');
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
                                Navigator.pushNamed(context, '/register');
                              },
                              child: const Text('Daftar Mbanking'),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, '/register');
                              },
                              child: const Text('lupa password?'),
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
