import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';

import './signup_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../../common/common.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final String token;

  // void showError(String error) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(error),
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    final api = context.read<ApiRepository>();
    token = api.storage.read<String>('token') ?? 'NoToken';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Tap'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Login Screen $token'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  NoAnimationMaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                  (_) => false,
                );
              },
              child: const Text('Dashboard'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  NoAnimationMaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                  (_) => false,
                );
              },
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
