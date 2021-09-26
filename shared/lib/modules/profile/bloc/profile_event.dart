part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends ProfileEvent {}

class ChangeUserData extends ProfileEvent {
  final UserData user;

  // TODO: add photo logic here
  // here you have to return old info if its not updated
  const ChangeUserData(this.user);

  @override
  List<Object> get props => [user];
}
