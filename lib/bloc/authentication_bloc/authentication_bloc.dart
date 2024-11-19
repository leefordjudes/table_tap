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
      api.storage.write('token', 'user-token1');
      return;
    }
    api.client.setHeader({'token': token});
    try {
      final UserProfileResponse profile = await api.getUserProfile();
      return emit(Authenticated(user: profile));
    } catch (ex) {
      debugPrint('getUserProfile error: ${ex.toString()}');
      return emit(AuthenticationFailure(ex.toString()));
    }
  }

  void _onAuthSuccess(
    AuthenticationSuccessEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final token = api.storage.read<String>('token');
    if (token == null) {
      emit(Unauthenticated());
      api.storage.write('token', 'user-token1');
      return;
    }
    api.client.setHeader({'token': token});
    try {
      final UserProfileResponse profile = await api.getUserProfile();
      return emit(Authenticated(user: profile));
    } catch (err) {
      debugPrint('getUserProfile error: ${err.toString()}');
      return emit(Unauthenticated());
    }
  }
}
