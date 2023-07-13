part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

final class _AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  const _AuthenticationStatusChanged(this.status);
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}
