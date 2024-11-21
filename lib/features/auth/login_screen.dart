import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:email_validator/email_validator.dart';

import 'package:api/lib.dart';
import 'package:api/user/user.dart';
import 'package:table_tap/common/common.dart';

import '../../bloc/bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Loading {
  final _formKey = GlobalKey<FormState>();

  final _emailFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final String token;

  void _submit() async {
    toggleLoading(true);
    if (!_formKey.currentState!.validate()) {
      toggleLoading(false);
      return;
    }

    final api = context.read<ApiRepository>();
    final authenticationBloc = context.read<AuthenticationBloc>();
    final data = LoginRequest(
      username: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    try {
      final UserLoginResponse res = await api.login(data);
      authenticationBloc.add(
        AuthenticationSuccessEvent(token: res.token, user: res.user),
      );
      toggleLoading(false);
    } on DioException catch (ex) {
      toggleLoading(false);
      if (mounted) {
        context.errorToast(ex.message ?? 'Internal server error');
      }
    } on CustomException catch (ex) {
      toggleLoading(false);
      if (mounted) {
        context.errorToast(ex.message);
      }
    }

    _reset();
  }

  void _reset() {
    _emailController.clear();
    _passwordController.clear();
    _emailFocusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    context.read<ApiRepository>().storage.remove('token').then((result) {
      // previously stored token removed
    });
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Login'),
                const SizedBox(height: 20),
                TextFormField(
                  autofocus: true,
                  autovalidateMode: AutovalidateMode.disabled,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: const Icon(Icons.person),
                    errorStyle: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 0,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email address.';
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return 'Enter valid email address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: const Icon(Icons.key),
                    errorStyle: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 0,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: const BorderSide(color: Colors.red, width: 1),
                    ),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  textInputAction: TextInputAction.none,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // todo => validate length
                      return 'Enter password.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submit,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        const SizedBox.square(
                          dimension: 10,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 1),
                        ),
                      const SizedBox(width: 10),
                      const Text('Login'),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
