import 'package:flutter/material.dart';

class Dialogs {
  showAlertDialog(
      BuildContext context, String title, String message, String route) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, route, (route) => false),
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
