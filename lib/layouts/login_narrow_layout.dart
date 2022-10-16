import 'package:flutter/material.dart';
import '../widgets/menu_home.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ibundiksha/services/login_services.dart';
import 'package:ibundiksha/widgets/about.dart';
import 'package:ibundiksha/widgets/dialogs.dart';
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    var mainContainer = MenuHome.mainContainer;
    var loginService = Auth().loginService;
    var snackBarCustom = Dialogs().snackBarCustom;

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
            SizedBox(height: 20),
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Username"),
                        ),
                        Container(
                          // height: 50,
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username cant empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Password"),
                        ),
                        Container(
                          // height: 60,
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cant empty";
                              }
                              return null;
                            },
                          ),
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
                                var message = await loginService(
                                    _usernameController.text,
                                    _passwordController.text);
                                if (message!.contains("Success")) {
                                  var loginSuccess = SnackBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    backgroundColor: Colors.blue,
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      "Signed in as ${_usernameController.text}",
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.height -
                                                160,
                                        right: 20,
                                        left: 20),
                                  );
                                  print("success");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(loginSuccess);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/main', (route) => false);
                                } else {
                                  var loginFailed = SnackBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      "Login failed",
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.height -
                                                160,
                                        right: 20,
                                        left: 20),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(loginFailed);
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
                                // Navigator.pushNamed(context, '/register');
                              },
                              child: Text('Daftar Mbanking'),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, '/register');
                              },
                              child: Text('lupa password?'),
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
