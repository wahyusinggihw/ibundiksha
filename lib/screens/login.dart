import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ibundiksha/services/login_services.dart';
import 'package:ibundiksha/widgets/about.dart';
import 'package:ibundiksha/widgets/dialogs.dart';
import 'package:ibundiksha/widgets/menu_home.dart';
import 'package:ibundiksha/layouts/login_wide_layout.dart';
import 'package:ibundiksha/layouts/login_narrow_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koperasi Undiksha'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            if (constraints.maxWidth > 450) {
              return LoginWideLayout();
            } else {
              return LoginNarrowLayout();
            }
          }),
        ),
      ),
      bottomNavigationBar: about(context, "Copyright © 2022 By Undiksha"),
    );
  }
}
