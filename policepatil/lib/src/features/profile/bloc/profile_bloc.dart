import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_data.dart';
import '../resources/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  final _repository = ProfileRepository();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
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
    if (event is ChangeUserData) {
      yield ProfileUpdating();
      try {
        int? userId = sharedPrefs.getInt('userId');
        Response response =
            await _repository.updateUserData(userId!, event.user);
        if (response.data["message"] != null) {
          yield ProfileUpdateSuccess(response.data["message"]);
        } else {
          yield ProfileUpdateFailed(response.data["error"].toString());
        }
      } catch (e) {
        yield ProfileUpdateFailed(e.toString());
      }
    }
  }
}
