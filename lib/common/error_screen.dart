import 'package:flutter/material.dart';

import '../../features/features.dart';

import 'no_animation_material_page_route.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Tap'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(error),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  NoAnimationMaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (_) => false,
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
