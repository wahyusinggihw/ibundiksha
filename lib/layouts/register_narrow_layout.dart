import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import '../widgets/menu_home.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ibundiksha/services/auth_services.dart';
import 'package:ibundiksha/widgets/about.dart';
import 'package:ibundiksha/widgets/dialogs.dart';
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
    var width = MediaQuery.of(context).size.height;
    var mainContainer = MenuHome.mainContainer;
    var snackBarCustom = Dialogs().snackBarCustom;
    SharedPrefs sharedPrefs = SharedPrefs();

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
                          child: Text("Nama lengkap"),
                        ),
                        Container(
                          // height: 50,
                          child: TextFormField(
                            controller: _namaController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nama cant empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Username"),
                        ),
                        Container(
                          // height: 60,
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
                          child: Text("NIM"),
                        ),
                        Container(
                          // height: 60,
                          child: TextFormField(
                            controller: _nimController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "NIM cant empty";
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
                              suffixIcon: _isObscure
                                  ? IconButton(
                                      icon: Icon(Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = false;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = true;
                                        });
                                      },
                                    ),
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
                                'Register',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () async {
                              // postLogin(_usernameController.text,
                              //     _passwordController.text);
                              // _service.postLogin(_usernameController.text,
                              //     _passwordController.text);
                              if (_formKey.currentState!.validate()) {
                                var status = await _auth.registerService(
                                    nama: _namaController.text,
                                    username: _usernameController.text,
                                    nim: _nimController.text.substring(7),
                                    password: _passwordController.text);
                                if (status!.isLoggedIn == true) {
                                  var loginSuccess = SnackBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    backgroundColor: Colors.blue,
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                      "Register Success\nSigned in as ${_usernameController.text}",
                                    ),
                                    // margin: EdgeInsets.only(
                                    //     bottom:
                                    //         MediaQuery.of(context).size.height -
                                    //             160,
                                    //     right: 20,
                                    //     left: 20),
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
                                      "Register failed",
                                    ),
                                    // margin: EdgeInsets.only(
                                    //     bottom:
                                    //         MediaQuery.of(context).size.height -
                                    //             160,
                                    //     right: 20,
                                    //     left: 20),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(loginFailed);
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
                              child: Text('Login Mbanking'),
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
