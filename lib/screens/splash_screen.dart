import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, routeLoginScreen, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Hero(
              tag: 'logo',
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
            )
          ],
        ),
      ),
    );
  }
}
