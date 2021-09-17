import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared/modules/auth/resources/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  final AuthRepository _authRepository = AuthRepository();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield AuthLoading();
      try {
        final signInResponse = await _authRepository.logIn(
            username: event.email, password: event.password);
        bool isAuth = true;
        yield AuthSuccess(isAuth);
      } catch (err) {
        debugPrint(err.toString());
        // auth failure error
      }
    }
  }
}
