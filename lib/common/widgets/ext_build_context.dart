import 'package:flutter/material.dart';

extension CustomSnackBar on BuildContext {
  void errorToast(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Align(alignment: Alignment.center, child: Text(message)),
        duration: const Duration(seconds: 10),
        behavior: SnackBarBehavior.floating,
        elevation: 5,
        backgroundColor: const Color.fromARGB(148, 227, 70, 70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
        ),
      ),
    );
  }
}
