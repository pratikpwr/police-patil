import 'package:bloc/bloc.dart';
import 'package:shared/shared.dart';
import 'package:shared/modules/authentication/models/current_user_data.dart';

import 'package:shared/modules/authentication/resources/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_bloc_public.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());
  final AuthenticationRepository authenticationService =
      AuthenticationRepository();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    final SharedPreferences sharedPreferences = await prefs;
    if (event is AppLoadedUp) {
      yield* _mapAppSignUpLoadedState(event);
    }

    if (event is UserLogin) {
      yield* _mapUserLoginState(event);
    }
    if (event is UserLogOut) {
      sharedPreferences.setString('authtoken', '');
      sharedPreferences.setInt('userId', 0);
      yield UserLogoutState();
    }
    if (event is GetUserData) {
      int? currentUserId = sharedPreferences.getInt('userId');
      final data = await authenticationService.getUserData(currentUserId ?? 4);
      final currentUserData = CurrentUserData.fromJson(data);
      yield SetUserData(currentUserData: currentUserData);
    }
  }

  Stream<AuthenticationState> _mapAppSignUpLoadedState(
      AppLoadedUp event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(const Duration(seconds: 1)); // a simulated delay
      final SharedPreferences sharedPreferences = await prefs;
      if (sharedPreferences.getString('authtoken') != null) {
        yield AppAuthenticated();
      } else {
        yield AuthenticationStart();
      }
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }

  Stream<AuthenticationState> _mapUserLoginState(UserLogin event) async* {
    final SharedPreferences sharedPreferences = await prefs;
    yield AuthenticationLoading();
    try {
      await Future.delayed(
          const Duration(milliseconds: 300)); // a simulated delay
      // final data = await authenticationService.loginWithEmailAndPassword(
      //     event.email, event.password);
      // if (data["error"] == null) {
      //   final currentUser = Token.fromJson(data);
      //   if (currentUser != null) {
      //     sharedPreferences.setString('authtoken', currentUser.token);
      //     yield AppAuthenticated();
      //   } else {
      //     yield AuthenticationNotAuthenticated();
      //   }
      // } else {
      //   yield AuthenticationFailure(message: data["error"]);
      // }
      yield AppAuthenticated();
    } catch (e) {
      yield AuthenticationFailure(message: e.toString());
    }
  }
}
