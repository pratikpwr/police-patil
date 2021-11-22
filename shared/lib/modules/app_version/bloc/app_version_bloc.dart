import 'dart:async';
import 'package:api/api.dart';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared/modules/app_version/app_version.dart';
import 'package:package_info/package_info.dart';

part 'app_version_event.dart';

part 'app_version_state.dart';

class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
  AppVersionBloc() : super(AppVersionInitial());

  @override
  Stream<AppVersionState> mapEventToState(
    AppVersionEvent event,
  ) async* {
    if (event is GetAppVersion) {
      yield AppVersionLoading();
      try {
        Response _response = await ApiSdk.appVersion();
        if (_response.data["message"] == "Success") {
          final _appVer = AppVersion.fromJson(_response.data);

          // TODO: latest version
          // hardcoded curVersion in file
          PackageInfo packageInfo = await PackageInfo.fromPlatform();

          Version curVersion = Version.parse(packageInfo.version);
          Version minVersion = Version.parse(_appVer.minVersion!);
          Version latVersion = Version.parse(_appVer.latestVersion!);
          debugPrint("---Version: $curVersion---");
          if (minVersion > curVersion) {
            yield const AppVersionSuccess(AppStatus.outdated);
          } else if (latVersion > curVersion) {
            yield const AppVersionSuccess(AppStatus.fine);
          } else {
            yield const AppVersionSuccess(AppStatus.latest);
          }
        } else {
          yield const AppVersionFailed("Something Went Wrong!");
        }
      } catch (e) {
        yield AppVersionFailed(e.toString());
      }
    }
  }
}
