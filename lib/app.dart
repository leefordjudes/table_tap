// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:api/api.dart';
import 'package:tools/tools.dart';

import 'bloc/bloc.dart';
import 'common/common.dart';
import 'features/features.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiRepository(
            errorHandler: (errors) {
              final exception = errors.firstWhereOrNull(
                (element) => element.isNotNullOrEmpty,
              );
              if (exception != null) {
                context.errorToast(exception);
              }
            },
            baseUrl: API_BASE_URL,
            storage: GetStorage(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(api: context.read<ApiRepository>())
                ..add(AuthenticationInitEvent()),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      onGenerateRoute: (_) => NoAnimationMaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            RepositoryProvider(
              create: (context) => ApiRepository(
                errorHandler: (errors) {
                  final exception = errors.firstWhereOrNull(
                    (element) => element.isNotNullOrEmpty,
                  );
                  if (exception != null) {
                    context.errorToast(exception);
                  }
                },
                baseUrl: API_BASE_URL,
                storage: GetStorage(),
              ),
            ),
            BlocProvider(
              create: (context) =>
                  AuthenticationBloc(api: context.read<ApiRepository>())
                    ..add(AuthenticationInitEvent()),
            ),
          ],
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
              if (state is AuthenticationFailure) {
                _navigator.pushAndRemoveUntil(
                  NoAnimationMaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (_) => false,
                );
                context.errorToast(state.error);
              } else if (state is Unauthenticated) {
                _navigator.pushAndRemoveUntil(
                  NoAnimationMaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (_) => false,
                );
              } else if (state is Authenticated) {
                _navigator.pushAndRemoveUntil(
                  NoAnimationMaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                  (_) => false,
                );
              }
            },
            builder: (context, state) {
              return child!;
            },
          ),
        );
      },
    );
    // return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //   builder: (context, state) {
    //     Widget currentScreen = const SplashScreen();
    //     if (state is AuthenticationFailure) {
    //       currentScreen = ErrorScreen(error: state.error);
    //     } else if (state is Authenticated) {
    //       currentScreen = const DashboardScreen();
    //     } else if (state is Unauthenticated) {
    //       currentScreen = const LoginScreen();
    //     }
    //     return currentScreen;
    //   },
    // );
  }
}
