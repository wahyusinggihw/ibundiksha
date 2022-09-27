import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/router/route_generator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initialize() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushNamedAndRemoveUntil(context, routeLoginScreen, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Center(
            child: Icon(
              Icons.account_balance_wallet,
              size: 100,
            ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
        ],
      ),
    );
  }
}
