import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared/modules/profile/models/user_data.dart';
import 'package:dio/dio.dart';
import 'package:shared/modules/profile/resources/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  final _repository = ProfileRepository();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    final SharedPreferences sharedPrefs = await prefs;
    if (event is GetUserData) {
      yield ProfileLoading();
      try {
        int? userId = sharedPrefs.getInt('userId');
        Response response = await _repository.getUserData(userId!);
        if (response.data["error"] == null) {
          UserData user = UserData.fromJson(response.data["data"]);
          yield ProfileDataLoaded(user);
        } else {
          yield ProfileLoadError(response.data["error"].toString());
        }
      } catch (e) {
        yield ProfileLoadError(e.toString());
      }
    }
  }
}
