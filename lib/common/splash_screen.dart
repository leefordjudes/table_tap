import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  // final Color backgroundColor;
  const SplashScreen({
    super.key,
    // this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Tap'),
      ),
      // backgroundColor: backgroundColor,
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
