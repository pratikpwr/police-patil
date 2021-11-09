part of 'app_version_bloc.dart';

abstract class AppVersionEvent extends Equatable {
  const AppVersionEvent();

  @override
  List<Object?> get props => [];
}

class GetAppVersion extends AppVersionEvent {}
