import 'package:flutter/material.dart';
import '../screens/splash.dart';
import 'route_list.dart';
import 'package:ibundiksha/screens/login.dart';
import 'package:ibundiksha/screens/home.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case routeLoginScreen:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case routeHomeScreen:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
