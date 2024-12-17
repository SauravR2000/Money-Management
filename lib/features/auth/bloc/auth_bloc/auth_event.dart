part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignupEvent extends AuthEvent {
  final String email;
  final String userName;
  final String password;

  SignupEvent({
    required this.email,
    required this.userName,
    required this.password,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}
