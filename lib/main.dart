import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/screens/home_screen.dart';
import 'package:ibundiksha/screens/login_screen.dart';
import 'package:ibundiksha/screens/no_route.dart';
import 'package:ibundiksha/screens/pembayaran_screen.dart';
import 'package:ibundiksha/screens/profile_screen.dart';
// import 'package:ibundiksha/screens/qrscanner_screen.dart';
import 'package:ibundiksha/screens/register_screen.dart';
import 'package:ibundiksha/screens/saldo_screen.dart';
import 'package:ibundiksha/screens/splash_screen.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/widgets/bottombar.dart';
import 'package:ibundiksha/screens/qrscanner_result_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ibundiksha/screens/transaksi_detail_screen.dart';
import 'package:ibundiksha/screens/transaksi_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
            ),
        debugShowCheckedModeBanner: false,
        title: "Koperasi Undiksha",
        initialRoute: routeLoginScreen,
        // onGenerateRoute: RouterGenerator.generateRoute,
        routes: {
          noRoute: (context) => NoRouteScreen(),
          routeSplashScreen: (context) => SplashScreen(),
          routeMainScreen: (context) => BottomBar(),
          routeLoginScreen: (context) => LoginScreen(),
          routeRegisterScreen: (context) => RegisterScreen(),
          routeHomeScreen: (context) => HomeScreen(),
          // routeQRScanner: (context) => QrScanner(),
          routeQrScannerResult: (context) => QrScannerResult(),
          routeProfileScreen: (context) => ProfileScreen(),
          routeSaldoScreen: (context) => SaldoScreen(),
          routeTransaksiScreen: (context) => TransaksiScreen(),
          routeTransaksiDetailScreen: (context) => TransaksiDetailScreen(),
          routePembayaranScreen: (context) => PembayaranScreen(),
        });
  }
}
