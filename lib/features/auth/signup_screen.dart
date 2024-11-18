import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';

import './login_screen.dart';
import '../../common/common.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final String token;
  @override
  void initState() {
    final api = context.read<ApiRepository>();
    token = api.storage.read<String>('token') ?? 'NoToken';
    super.initState();
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
            Text('Signup Screen $token'),
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
