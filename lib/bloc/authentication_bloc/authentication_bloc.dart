import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:api/api.dart';
import 'package:api/user/user.dart';

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
    final token = api.storage.read<String>('token');
    if (token == null) {
      emit(Unauthenticated());
      return;
    }
    // api.client.setHeader({'token': token});
    try {
      final UserProfileResponse profile = await api.getUserProfile();
      return emit(Authenticated(user: profile));
    } catch (ex) {
      debugPrint('getUserProfile error: ${ex.toString()}');
      await api.storage.remove('token');
      return emit(Unauthenticated());
    }
  }

  void _onAuthSuccess(
    AuthenticationSuccessEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await api.storage.write('token', event.token);
    return emit(Authenticated(user: event.user));
  }
}
