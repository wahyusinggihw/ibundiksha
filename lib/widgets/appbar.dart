import 'package:flutter/material.dart';
import 'package:ibundiksha/widgets/menu_home.dart';

// String activeScreen = MenuHome.active;
Widget myAppBar(
    {required BuildContext context,
    String? activeScreen,
    List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.cyan,
    centerTitle: true,
    // automaticallyImplyLeading: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: actions,
    title: Text(activeScreen!),
  );
}
