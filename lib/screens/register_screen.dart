import 'package:flutter/material.dart';
import 'package:ibundiksha/layouts/register_narrow_layout.dart';
import 'package:ibundiksha/layouts/register_wide_layout.dart';
import 'package:ibundiksha/widgets/about.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Koperasi Undiksha'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            if (constraints.maxWidth > 450) {
              return const RegisterWideLayout();
            } else {
              return const RegisterNarrowLayout();
            }
          }),
        ),
      ),
      bottomNavigationBar: about(context, "Copyright © 2022 By Undiksha"),
    );
  }
}
