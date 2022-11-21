import 'package:flutter/material.dart';
import 'package:ibundiksha/screens/login_api.dart';
import 'package:ibundiksha/screens/profile.dart';
import 'package:ibundiksha/widgets/bottombar.dart';
import '../screens/splash.dart';
import 'route_list.dart';
import 'package:ibundiksha/screens/login.dart';
import 'package:ibundiksha/screens/home.dart';
import 'package:ibundiksha/screens/transaksi.dart';
import 'package:ibundiksha/screens/no_route.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeSplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case routeMainScreen:
        return MaterialPageRoute(builder: (_) => BottomBar());
      case routeLoginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case routeHomeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case routeTransaksiScreen:
        return MaterialPageRoute(builder: (_) => TransaksiScreen());
      case routeProfileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case routeLoginAPI:
        return MaterialPageRoute(builder: (_) => LoginApi());

      default:
        return MaterialPageRoute(builder: (_) => NoRouteScreen());
    }
  }
}
