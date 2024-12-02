part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent({
    required this.name,
    required this.password,
    required this.email,
  });
}
class LogInEvent extends AuthEvent {
  final String email;
  final String password;

  LogInEvent({
    required this.password,
    required this.email,
  });
}
