import "package:flutter/material.dart";

SnackBar mySnackBar(BuildContext context, String title) {
  return SnackBar(
    content: Text(title),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.cyan,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

SnackBar successSnackBar(String title) {
  return SnackBar(
    content: Text(title),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.cyan,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

SnackBar errorSnackBar(String title) {
  return SnackBar(
    content: Text(title),
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
