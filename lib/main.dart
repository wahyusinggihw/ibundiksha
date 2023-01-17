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
import 'package:ibundiksha/screens/setoran_screen.dart';
import 'package:ibundiksha/screens/splash_screen.dart';
import 'package:ibundiksha/screens/tarik_screen.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/widgets/bottombar.dart';
import 'package:ibundiksha/screens/qrscanner_result_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ibundiksha/screens/transfer_detail_screen.dart';
import 'package:ibundiksha/screens/transfer_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ibundiksha/services/notif_services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

// It is assumed that all messages contain a data field with the key 'type'
Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

_launchURL() async {
  if (!await launchUrl(
    Uri.parse(
        'https://www.google.com/'), //url ini bisa kalian ganti dengan url lain
    mode: LaunchMode.externalApplication,
  )) {
    throw "Tidak bisa membuka halaman";
  }
}

void _handleMessage(RemoteMessage message) {
  if (message.notification!.title == 'pesan berhasil') {
    _launchURL();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  MyNotificationService myNotificationService = MyNotificationService();
  myNotificationService.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    // sharedPrefs.addBool('isLoggedIn', false);
    bool isLoggedIn = sharedPrefs.getBool('isLoggedIn') == null
        ? false
        : sharedPrefs.getBool('isLoggedIn')!;
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
        title: "Internet Banking Undiksha",
        initialRoute: isLoggedIn == true ? routeMainScreen : routeSplashScreen,
        // onGenerateRoute: RouterGenerator.generateRoute,
        routes: {
          noRoute: (context) => const NoRouteScreen(),
          routeSplashScreen: (context) => const SplashScreen(),
          routeMainScreen: (context) => const BottomBar(),
          routeLoginScreen: (context) => const LoginScreen(),
          routeRegisterScreen: (context) => const RegisterScreen(),
          routeHomeScreen: (context) => const HomeScreen(),
          // routeQRScanner: (context) => QrScanner(),
          routeQrScannerResult: (context) => const QrScannerResult(),
          routeProfileScreen: (context) => const ProfileScreen(),
          routeSaldoScreen: (context) => const SaldoScreen(),
          routeTransferScreen: (context) => const TransferScreen(),
          routeTransferDetailScreen: (context) => const TransferDetailScreen(),
          routeTarikScreen: (context) => const TarikScreen(),
          routePembayaranScreen: (context) => const PembayaranScreen(),
          routeSetoranScreen: (context) => const SetoranScreen(),
        });
  }
}
