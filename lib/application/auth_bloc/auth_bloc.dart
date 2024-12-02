import 'package:bloc/bloc.dart';
import 'package:bloc_todo/infrastructure/models/login.dart';
import 'package:bloc_todo/infrastructure/services/auth.dart';
import 'package:flutter/cupertino.dart';
import '../../infrastructure/models/sign_up.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final signUpResponse = await AuthServices().signUpUser(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        if (signUpResponse.status == true) {
          emit(AuthLoaded(signUpResponse));
        } else {
          emit(AuthFailed(signUpResponse));
        }
      } catch (e) {
        emit(AuthFailed(
          SignUpModel(
            status: false,
            error: e.toString(),
          ),
        ));
      }
    });

    on<LogInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final logInResponse = await AuthServices().loginUser(
          email: event.email,
          password: event.password,
        );
        if (logInResponse.status == true) {
          emit(LogInLoaded(logInResponse));
        } else {
          emit(LogInFailed(
            LogInModel(
              status: false,
              message: 'Invalid Credential',
            ),
          ));
        }
      } catch (e) {
        emit(LogInFailed(
          LogInModel(
            status: false,
            message: 'Invalid Credential',
          ),
        ));
      }
    });
  }
}
