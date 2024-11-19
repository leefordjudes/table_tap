import 'package:flutter/material.dart';

import '../../features/features.dart';

import 'no_animation_material_page_route.dart';

// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text(state.error),
//     duration: const Duration(seconds: 10),
//     behavior: SnackBarBehavior.floating,
//     backgroundColor: const Color.fromARGB(200, 34, 34, 34),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     margin: EdgeInsets.only(
//       bottom: MediaQuery.of(context).size.height - 100,
//       right: 20,
//       left: 20,
//     ),
//   ),
// );

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
