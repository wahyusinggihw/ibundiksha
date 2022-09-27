import 'package:flutter/material.dart';

Widget appBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        // Navigator.pop(context);
      },
    ),
  );
}