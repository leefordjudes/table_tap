import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'bloc/bloc.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }

  runApp(const AppView());
}
