import 'package:flutter/material.dart';

Widget about(BuildContext context, String title) {
  return Container(
    height: 30,
    width: double.infinity,
    color: Colors.cyan.shade100,
    child: Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
    ),
  );
}
