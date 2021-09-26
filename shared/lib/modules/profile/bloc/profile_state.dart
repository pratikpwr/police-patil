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
  final UserData user;

  const ProfileDataLoaded(this.user);

  @override
  List<Object> get props => [user];
}
