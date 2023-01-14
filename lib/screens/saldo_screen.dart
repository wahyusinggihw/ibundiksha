import 'package:flutter/material.dart';
import 'package:ibundiksha/services/shared_preferences.dart';

class SaldoScreen extends StatelessWidget {
  const SaldoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPrefs sharedPrefs = SharedPrefs();
    String saldo = sharedPrefs.getString('saldo');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Saldo"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Saldo anda adalah:"),
            Text(saldo),
          ],
        ),
      )),
    );
  }
}
