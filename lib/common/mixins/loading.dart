import 'package:flutter/material.dart';

mixin Loading<T extends StatefulWidget> on State<T> {
  bool isLoading = false;
  // Its used to change the loading state
  void toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
