part of 'app_version_bloc.dart';

abstract class AppVersionState extends Equatable {
  const AppVersionState();

  @override
  List<Object> get props => [];
}

class AppVersionInitial extends AppVersionState {}

class AppVersionLoading extends AppVersionState {}

class AppVersionSuccess extends AppVersionState {
  final AppStatus status;

  const AppVersionSuccess(this.status);

  @override
  List<Object> get props => [status];
}

class AppVersionFailed extends AppVersionState {
  final String error;

  const AppVersionFailed(this.error);

  @override
  List<Object> get props => [error];
}
