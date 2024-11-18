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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Bloc.observer = AppBlocObserver();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => GetStorage(),
        ),
        RepositoryProvider(
          create: (context) => ApiRepository(
            errorHandler: (errors) {
              final exception = errors.firstWhereOrNull(
                (element) => element.isNotNullOrEmpty,
              );
              if (exception != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(exception),
                  ),
                );
              }
            },
            baseUrl: API_BASE_URL,
            storage: context.read<GetStorage>(),
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          Widget currentScreen = const SplashScreen();
          if (state is Authenticated) {
            currentScreen = const DashboardScreen();
          } else if (state is Unauthenticated) {
            currentScreen = const LoginScreen();
          }
          return currentScreen;
        },
      ),
    );
  }
}
