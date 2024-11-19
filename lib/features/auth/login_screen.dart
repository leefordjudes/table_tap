import 'package:api/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';

import '../../bloc/bloc.dart';
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
  final _formKey = GlobalKey<FormState>();

  final _usernameFocusNode = FocusNode();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late final String token;

  void _submit() async {
    final api = context.read<ApiRepository>();
    final authenticationBloc = context.read<AuthenticationBloc>();
    final data = LoginRequest(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    try {
      final UserProfileResponse user = await api.login(data);
      _reset();
      authenticationBloc.add(
        AuthenticationSuccessEvent(token: token, user: user),
      );
    } catch (_) {
      //graphQLApi.removeHeader(ApiHeader.xat);
    }
  }

  void _reset() {
    _usernameController.clear();
    _passwordController.clear();
    _usernameFocusNode.requestFocus();
  }

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
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Text('Login Screen $token'),
              TextFormField(
                autofocus: true,
                focusNode: _usernameFocusNode,
                textInputAction: TextInputAction.next,
                controller: _usernameController,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                textInputAction: TextInputAction.none,
                onFieldSubmitted: (_) {
                  _submit();
                },
              ),
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
      ),
    );
  }
}
