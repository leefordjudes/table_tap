part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class Unauthenticated extends AuthenticationState {}

final class Authenticated extends AuthenticationState {
  final UserProfileResponse user;

  Authenticated({required this.user});
}

final class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure(this.error);
}

// final class AuthenticationLoading extends AuthenticationState {}
