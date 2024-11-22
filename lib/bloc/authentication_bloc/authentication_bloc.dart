import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';
import 'package:api/user/user.dart';
import 'package:get_storage/get_storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ApiRepository api;

  AuthenticationBloc({required this.api}) : super(Unauthenticated()) {
    on<AuthenticationInitEvent>(_onInit);
    on<AuthenticationSuccessEvent>(_onAuthSuccess);
  }

  void _onInit(
    AuthenticationInitEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final token = await GetStorage().read('token');
    print('\n exToken: $token\n');
    if (token == null) {
      emit(Unauthenticated());
      return;
    }
    try {
      final UserProfileResponse profile = await api.getUserProfile(token);
      return emit(Authenticated(user: profile));
    } catch (ex) {
      debugPrint('getUserProfile error: ${ex.toString()}');
      // await GetStorage().remove('token');
      return emit(Unauthenticated());
    }
  }

  void _onAuthSuccess(
    AuthenticationSuccessEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    print('onAuthSuccess');
    print('event token: ${event.token}');
    // await api.storage.write('token', event.token);
    // await api.storage.setString('token', event.token);
    await GetStorage().write('token', event.token);
    return emit(Authenticated(user: event.user));
  }
}
