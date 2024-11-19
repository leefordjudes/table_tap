part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

final class AuthenticationInitEvent extends AuthenticationEvent {}

final class AuthenticationSuccessEvent extends AuthenticationEvent {
  final String token;
  final UserProfileResponse user;

  AuthenticationSuccessEvent({
    required this.token,
    required this.user,
  });
}
