import 'dart:async';

import 'package:api/shared_prefs/shared_const.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is NavigateToHome) {
      yield SplashLoading();
      await Future.delayed(const Duration(seconds: 4));
      yield SplashLoaded();
    }
  }

// Future<bool> checkLogin() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool _isLogin = prefs.getBool(KEY_IS_LOGIN) ?? false;
//   return _isLogin;
// }
}
