part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadError extends ProfileState {
  final String error;

  const ProfileLoadError(this.error);

  @override
  List<Object> get props => [error];
}

class ProfileDataLoaded extends ProfileState {
  final UserClass user;

  const ProfileDataLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final String message;

  const ProfileUpdateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileUpdateFailed extends ProfileState {
  final String message;

  const ProfileUpdateFailed(this.message);

  @override
  List<Object> get props => [message];
}
