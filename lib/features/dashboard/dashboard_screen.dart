import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';
import 'package:get_storage/get_storage.dart';

import '../auth/login_screen.dart';
import '../../common/common.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final String token;

  void _logout() async {
    await GetStorage().remove('token');
    Navigator.of(context).pushAndRemoveUntil(
      NoAnimationMaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (_) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    final api = context.read<ApiRepository>();
    // token = api.storage.read<String>('token') ?? 'NoToken';
    // token = api.storage.getString('token') ?? 'NoToken';
    token = GetStorage().read('token') ?? 'NoToken';
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
            Text('Dashboard Screen $token'),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
