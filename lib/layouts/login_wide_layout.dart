import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/widgets/snackbars.dart';
import '../widgets/menu_home.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ibundiksha/services/auth_services.dart';
import 'package:ibundiksha/router/route_list.dart';

class LoginWideLayout extends StatefulWidget {
  const LoginWideLayout({Key? key}) : super(key: key);

  @override
  State<LoginWideLayout> createState() => _LoginWideLayoutState();
}

class _LoginWideLayoutState extends State<LoginWideLayout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                              // Navigator.pushNamed(context, '/main');
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
                              child: Text(
                                'Daftar Mbanking',
                                style: TextStyle(
                                  fontSize: ResponsiveValue(
                                    context,
                                    defaultValue: 12.0,
                                    valueWhen: const [
                                      Condition.smallerThan(
                                          name: TABLET, value: 12.0),
                                      Condition.largerThan(
                                          name: DESKTOP, value: 60.0),
                                    ],
                                  ).value,
                                ),
                              ),
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
