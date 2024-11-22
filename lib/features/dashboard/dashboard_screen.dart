// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';

import '../auth/login_screen.dart';
import '../../common/common.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final String token;

  @override
  void initState() {
    super.initState();
    final api = context.read<ApiRepository>();
    token = api.storage.read<String>('token') ?? 'NoToken';
  }

  @override
  Widget build(BuildContext context) {
    final api = context.read<ApiRepository>();
    void logout() async {
      await api.storage.remove('token');
      Navigator.of(context).pushAndRemoveUntil(
        NoAnimationMaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (_) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Tap'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Dashboard Screen $token'),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
