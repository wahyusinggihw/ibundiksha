import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/screens/home_screen.dart';
import 'package:ibundiksha/screens/profile_screen.dart';
// import 'package:ibundiksha/screens/qrscanner_screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // final NotificationHelper _notificationHelper = NotificationHelper();

  int pageIndex = 0;
  final List<Widget> listPage = [
    const HomeScreen(),
    // const QrScanner(),
    const ProfileScreen(),
  ];

  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   selectNotificationSubject.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // _notificationHelper
    //     .configureSelectNotificationSubject(context,'/detail');
    Future<void> _launchUrl() async {
      final Uri _url = Uri.parse(_scanBarcode);
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    Future<void> scanQR() async {
      String barcodeScanRes;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.QR);

        if (barcodeScanRes.isNotEmpty) {
          // _launchUrl();
          Navigator.pushNamed(context, routeQrScannerResult,
              arguments: barcodeScanRes);
        } else if (barcodeScanRes == '-1') {
          // Navigator.pushNamed(context, routeMainScreen);
        }
        print(barcodeScanRes);
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      setState(() {
        _scanBarcode = barcodeScanRes;
      });
    }

    // Platform messages are asynchronous, so we initialize in an async method.

    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            listPage.elementAt(pageIndex),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Align(
                alignment: const Alignment(0.0, 1.1),
                child: BottomNavigationBar(
                  selectedItemColor: Colors.cyan,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  backgroundColor: Colors.cyan.shade50,
                  currentIndex: pageIndex,
                  onTap: (int index) {
                    setState(() {
                      pageIndex = index;
                    });
                    print(index);
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings_outlined),
                        activeIcon: Icon(Icons.settings),
                        label: 'Setting'),
                    // BottomNavigationBarItem(
                    //     icon: Icon(
                    //       Icons.qr_code_scanner_outlined,
                    //       color: Colors.transparent,
                    //     ),
                    //     activeIcon: Icon(Icons.qr_code_scanner_rounded),
                    //     label: ''),
                    BottomNavigationBarItem(
                        activeIcon: Icon(Icons.account_circle_rounded),
                        icon: Icon(Icons.account_circle_outlined),
                        label: 'Profile'),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 50),
            //   child: Align(
            //     alignment: const Alignment(0.0, 1.1),
            //     child: Container(
            //       width: 70,
            //       height: 70,
            //       decoration: BoxDecoration(
            //         color: Colors.cyan,
            //         borderRadius: BorderRadius.circular(50),
            //       ),
            //       child: GestureDetector(
            //         child: Icon(
            //           Icons.qr_code_scanner_rounded,
            //           size: 40,
            //           color: pageIndex == 1 ? Colors.white : Colors.white38,
            //         ),
            //         onTap: () {
            //           setState(() {
            //             pageIndex = 1;
            //           });
            //           // print('qrscan');
            //         },
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              color: Colors.white38,
              Icons.qr_code_scanner_rounded,
              size: 40,
            ),
            onPressed: () {
              scanQR();
              // print('qrscan');
            },
          ),
        ),
      ),
    );
  }
}
