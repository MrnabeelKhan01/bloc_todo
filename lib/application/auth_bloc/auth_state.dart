part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final SignUpModel signUpModel;
  AuthLoaded(this.signUpModel);
}
class LogInLoaded extends AuthState {
  final LogInModel logInModel;
  LogInLoaded(this.logInModel);
}

class AuthFailed extends AuthState {
  final SignUpModel signUpModel;

  AuthFailed(this.signUpModel);
}
class LogInFailed extends AuthState {
  final LogInModel logInModel;

  LogInFailed(this.logInModel);
}
