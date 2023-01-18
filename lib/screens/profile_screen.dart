// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibundiksha/router/route_list.dart';
import 'package:ibundiksha/services/auth_services.dart';
import 'package:ibundiksha/services/shared_preferences.dart';
import 'package:ibundiksha/services/transaksi_service.dart';
import 'package:ibundiksha/widgets/menu_home.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:ibundiksha/widgets/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPrefs sharedPrefs = SharedPrefs();
  final Transaksi _transaksi = Transaksi();
  String nama = '';
  String username = '';
  String currentUserId = '';
  String saldo = '';
  final _auth = Auth();

  @override
  void initState() {
    super.initState();
    nama = sharedPrefs.getString('nama');
    username = sharedPrefs.getString('username');
    currentUserId = sharedPrefs.getString('userId');
    saldo = sharedPrefs.getString('saldo');
    _transaksi.currentUserSaldo(userId: int.parse(currentUserId)).then((value) {
      setState(() {
        saldo = value[0]['saldo'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.cyan,
        actions: [
          ResponsiveVisibility(
            visible: false,
            visibleWhen: const [
              Condition.largerThan(name: MOBILE),
            ],
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () {},
              child: const Text("Logout"),
            ),
          ),
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => myDialog(
                    context: context,
                    title: "Konfirmasi",
                    message: "Anda yakin ingin logout?",
                    onPressed: () async {
                      var status = await _auth.logoutService();
                      if (status.isLoggedIn == false) {
                        if (kDebugMode) {
                          print('User logged out');
                        }
                        Navigator.pushNamedAndRemoveUntil(
                            context, routeLoginScreen, (route) => false);
                      }
                    }),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/user.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Saldo : ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  saldo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Username : ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Nama : ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1),
                child: const Contact())
          ],
        ),
      ),
    );
  }
}
