import 'package:flutter/material.dart';
import 'package:ibundiksha/widgets/about.dart';
import 'package:ibundiksha/widgets/menu_home.dart';
import '../widgets/appbar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    var mainContainer = MenuHome.mainContainer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Koperasi Undiksha'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
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
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text("Password"),
                          ),
                          Container(
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
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
                              onPressed: () {
                                Navigator.pushNamed(context, '/main');
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
      ),
      bottomNavigationBar:
          about(context, "Copyright" + '©' + "2022 By Undiksha"),
    );
  }
}
